import 'package:chatapp/pages/group_info.dart';
import 'package:chatapp/service/database_service.dart';
import 'package:chatapp/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String userName;
  const ChatPage({super.key,required this.groupId,required this.groupName,required this.userName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Stream<QuerySnapshot>?chats;
  String admin="";
  @override
  void initState() {
    getChatandAdmin();
    super.initState();
  }

  getChatandAdmin(){
    DatabaseService(uid: "").getChats(widget.groupId).then((val){
      setState(() {
        chats=val;
      });
    });
    DatabaseService(uid: "").getGroupAdmin(widget.groupId).then((val){
      setState(() {
        admin=val;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
      elevation: 0,
      title: Text(widget.groupName),
      backgroundColor: Theme.of(context).primaryColor,
      actions: [
        IconButton(onPressed: (){
          nextScreen(context, GroupInfo(
            groupId: widget.groupId,
            groupName: widget.groupName,
            adminName: admin,
            ));
        }, icon: const Icon(Icons.info) ),
      ],
      ),
      body: Center(child: Text(widget.groupName)),
    );
  }
}
