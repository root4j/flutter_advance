import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';
import '../controller/messages_nice_controller.dart';
import '../model/message.dart';

class FirebaseMessageWidget extends StatefulWidget {
  const FirebaseMessageWidget({super.key});

  @override
  State<FirebaseMessageWidget> createState() => _FirebaseMessageWidgetState();
}

class _FirebaseMessageWidgetState extends State<FirebaseMessageWidget> {
  // Controladores
  AuthController ctrl = Get.find();
  MessagesNiceController msgCtrl = Get.find();
  // Controladores de Widgets
  final TextEditingController _msgCtrl = TextEditingController();
  final ScrollController _scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    msgCtrl.start();
  }

  @override
  void dispose() {
    msgCtrl.stop();
    super.dispose();
  }

  Widget _messageCard(Message msg) {
    String uid = ctrl.getMail();
    return Card(
      margin: uid == msg.mail
          ? const EdgeInsets.only(
              left: 50,
              top: 10,
              bottom: 10,
              right: 10,
            )
          : const EdgeInsets.only(
              left: 10,
              top: 10,
              bottom: 10,
              right: 50,
            ),
      color: uid == msg.mail ? Colors.blue[100] : Colors.grey[200],
      child: ListTile(
        title: Text(
          msg.mail,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(msg.text),
      ),
    );
  }

  Widget _messageList() {
    return GetX<MessagesNiceController>(
      builder: ((controller) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToEnd());
        return ListView.builder(
          itemCount: msgCtrl.messages.length,
          controller: _scrollCtrl,
          itemBuilder: (context, index) {
            var msg = msgCtrl.messages[index];
            return _messageCard(msg);
          },
        );
      }),
    );
  }

  Widget _messageInput() {
    return Container(
      margin: const EdgeInsets.all(5),
      child: TextField(
        controller: _msgCtrl,
        onSubmitted: (value) async {
          await _addMessage();
          _msgCtrl.clear();
        },
      ),
    );
  }

  _scrollToEnd() async {
    _scrollCtrl.animateTo(
      _scrollCtrl.position.maxScrollExtent,
      duration: const Duration(
        milliseconds: 200,
      ),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _addMessage() async {
    Message msg = Message(ctrl.getMail(), _msgCtrl.text);
    await msgCtrl.addMessage(msg);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToEnd());
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: _messageList(),
        ),
        _messageInput(),
      ],
    );
  }
}
