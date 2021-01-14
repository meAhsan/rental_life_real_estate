import 'package:flutter/material.dart';
import 'package:realestate/Pages/ChatPages/ConversationScreen.dart';
import 'package:realestate/Pages/ChatPages/SearchChat.dart';
import 'package:provider/provider.dart';
import 'package:realestate/ModelClasses/UserModelClasses/RentalLifeUser.dart';
import 'package:realestate/Service Classes/FirestoreDatabaseServicesForUser.dart';
import 'package:realestate/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom extends StatefulWidget {

  @override
  RentalLifeUser _rentalLifeUser2;

  ChatRoom(this._rentalLifeUser2);
  _ChatRoomState createState() => _ChatRoomState();
}
var _rentalLifeUser;
class _ChatRoomState extends State<ChatRoom> {

  FirestoreDatabaseServicesForUser databaseService = FirestoreDatabaseServicesForUser();
  Stream chatRoomsStream;
  String messageReciever ;



  Widget chatRoomList(){
    return StreamBuilder(
      stream:chatRoomsStream,
      builder: (context, snapshot){
        return snapshot.hasData ? ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index){
              return ChatRoomsTile(
                snapshot.data.documents[index].data["chatRoomId"]
                    .toString()
                    .replaceAll("_", " ")
                    .replaceAll(_rentalLifeUser.name, ""),

                snapshot.data.documents[index].data["chatRoomId"],

                _rentalLifeUser,
              );
            })
            : Container();
      },
    );
  }

  getPreviousChats(String chatRoomId, String LoggedInUser){
    String id = chatRoomId;
    var index;
    List<String> list = id.split("_");
    print(list);
    return index = list.indexOf(LoggedInUser);

  }

  getUserInfogetChats() async {

    databaseService.getChatRooms(_rentalLifeUser.name).then((snapshots) {
      setState(() {
        chatRoomsStream = snapshots;
        // print("we got the data + ${chatRoomsStream.toString()} this is name  ${_rentalLifeUser.name}");
      });
    });
  }

  @override
  void initState() {
    /*databaseService.getChatRooms(widget._rentalLifeUser.name).then((value){
     setState(() {
       chatRoomsStream = value;
     });

    });*/
    getUserInfogetChats();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    _rentalLifeUser = Provider.of<RentalLifeUser>(context);
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text("Chats"),
      ),
      body: chatRoomList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        child: Icon(Icons.add),
        onPressed: (){
          // print("name here----------------------------------->>>>>> ${_rentalLifeUser.name}");
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => SearchChatScreen(_rentalLifeUser),

          ));
        },
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {

  RentalLifeUser _rentalLifeUser;
  final String userName;
  final String chatRoom;
  ChatRoomsTile(this.userName, this.chatRoom, this._rentalLifeUser);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ConversationScreen(chatRoom,  _rentalLifeUser),
        ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Text("${userName.substring(0,1).toUpperCase()}",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'OverpassRegular',
                    fontWeight: FontWeight.w300,
                    color: Colors.white
                ),),
            ),
            SizedBox(width: 8,),
            Text(
              userName,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20
              ),

            ),
          ],
        ),
      ),
    );
  }
}

