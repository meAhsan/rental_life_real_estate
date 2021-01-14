import 'package:flutter/material.dart';
import 'package:realestate/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:realestate/ModelClasses/UserModelClasses/RentalLifeUser.dart';
import 'package:realestate/Service Classes/FirestoreDatabaseServicesForUser.dart';

class ConversationScreen extends StatefulWidget {
  RentalLifeUser _rentalLifeUser;
  final String chatRoomId;

  ConversationScreen(this.chatRoomId, this._rentalLifeUser);
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {

  FirestoreDatabaseServicesForUser databaseService = FirestoreDatabaseServicesForUser();
  TextEditingController messageController = TextEditingController();
  Stream chatMessagesStream;

  sendMessage(){
    if(messageController.text.isNotEmpty){
      Map<String, dynamic> messageMap = {
        "message": messageController.text,
        "SendBy": widget._rentalLifeUser.name,
        "time": DateTime.now().millisecondsSinceEpoch,
      };
      databaseService.addConversationMessages(widget.chatRoomId, messageMap);
      messageController.text = "";

    }
  }

  Widget ChatMessageList(){
    return StreamBuilder(
      stream: chatMessagesStream,
      builder: (context, snapshot){
        return snapshot.hasData ? ListView.builder(
            itemCount: snapshot.data.documents.length,

            itemBuilder:(context, index){
              return MessageTile(snapshot.data.documents[index].data["message"],
                  snapshot.data.documents[index].data["SendBy"]== widget._rentalLifeUser.name);
            }
        ) : Container();

      },
    );

  }

  @override
  void initState() {
    databaseService.getConversationMessages(widget.chatRoomId).then((value){
      setState(() {
        chatMessagesStream= value;
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text("ChatBox"),
      ),
      body: Container(
        child: Stack(
            children: [
              ChatMessageList(),
              Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 70,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  color: Colors.deepOrangeAccent,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          decoration: InputDecoration(
                              hintText: "Type Message...",
                              hintStyle: TextStyle(color: Colors.black),
                              border: InputBorder.none
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          sendMessage();                    //  initiateSearch();
                        },
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
                          child: Image.asset("image_assets/send.png"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;

  MessageTile(this.message, this.isSendByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: isSendByMe ? 0:20 , right: isSendByMe ? 20:0 ),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,

      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16 ),
        decoration: BoxDecoration(
            gradient: LinearGradient(

                colors: isSendByMe ? [
                  Colors.orange,
                  Colors.orange,
                ]
                    : [
                  Colors.pinkAccent,
                  Colors.pinkAccent
                ]
            ),
            borderRadius: isSendByMe ?
            BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomLeft: Radius.circular(23)
            )
                : BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomRight: Radius.circular(23)
            )
        ),
        child: Text(
          message,
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,

          ),),
      ),
    );
  }
}
