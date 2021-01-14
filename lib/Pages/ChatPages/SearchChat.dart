import 'package:flutter/material.dart';
import 'package:realestate/Pages/ChatPages/ConversationScreen.dart';
import 'package:realestate/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:realestate/ModelClasses/UserModelClasses/RentalLifeUser.dart';
import 'package:realestate/Service Classes/FirestoreDatabaseServicesForUser.dart';
import 'package:provider/provider.dart';

class SearchChatScreen extends StatefulWidget {
  RentalLifeUser _rentalLifeUser;

  SearchChatScreen(this._rentalLifeUser);
  @override
  _SearchChatScreenState createState() => _SearchChatScreenState();
}

class _SearchChatScreenState extends State<SearchChatScreen> {

  TextEditingController searchTextEditingController = new TextEditingController();


  FirestoreDatabaseServicesForUser databaseService = FirestoreDatabaseServicesForUser();
  QuerySnapshot searchSnapshot;


  initiateSearch(){
    databaseService.getUserByName(searchTextEditingController.text)
        .then((val){
      setState(() {
        // print("name is : -------- ${widget._rentalLifeUser.name}");
        searchSnapshot = val;
      });
    });
  }

  /// create chatroom , send user to conversation screen
  createChatroomAndStartConversation(String userName){

    if(userName != widget._rentalLifeUser.name ){
      String chatRoomId= getChatRoomId(userName, widget._rentalLifeUser.name);

      List<String> user =  [userName, widget._rentalLifeUser.name];
      Map<String, dynamic> chatRoomMap = {
        "users": user,
        "chatRoomId": chatRoomId,
      };
//    print({widget._rentalLifeUser.name});
      databaseService.createChatRoom(chatRoomId,  chatRoomMap);
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => ConversationScreen(chatRoomId, widget._rentalLifeUser)
      ));
    }
    else print("You can not send message to yourself");
  }


  Widget searchList(){
    return searchSnapshot != null ? ListView.builder(
      shrinkWrap: true,
      itemCount: searchSnapshot.documents.length,
      itemBuilder: (context, index){
        return searchTile(
          searchSnapshot.documents[index].data['name'],
          searchSnapshot.documents[index].data["email"],
        );
      },
    ) : Container();
  }

  // user tile in search list..
  Widget searchTile(String firstName, String userEmail){
    return Container
      (
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                firstName,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16
                ),
              ),
              Text(
                userEmail,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16
                ),
              )
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              //sendMessage(firstName);
            },
            child: GestureDetector(
              onTap: (){
                createChatroomAndStartConversation(firstName);

              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(24)
                ),
                child: Text("Message",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                  ),),
              ),
            ),
          )
        ],
      ),
    );
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final rentalLifeUserFromProvider = Provider.of<RentalLifeUser>(context);


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text("Search User"),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              color: Colors.orangeAccent,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchTextEditingController,
                      decoration: InputDecoration(
                          hintText: "Search Username...",
                          hintStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none
                      ),

                    ),
                  ),
                  GestureDetector(
                    onTap: (){

                      initiateSearch();},
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                const Color(0x36FFFFFF),
                                const Color(0x0FFFFFFF),
                              ]
                          ),
                          borderRadius: BorderRadius.circular(40)
                      ),
                      padding: EdgeInsets.all(12),
                      child: Image.asset("image_assets/search_white.png"),
                    ),
                  ),
                ],

              ),
            ),
            searchList(),
          ],
        ),
      ),
    );
  }

}
getChatRoomId(String a, String b){
  /* if(a.substring(0,1).codeUnitAt(0) > b.substring(0,1).codeUnitAt(0)){
    return "$b\_$a";
  }
  else */
  return "$a\_$b";
}