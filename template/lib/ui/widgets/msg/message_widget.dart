import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/message.dart';
import '../../../domain/controller/authentication_controller.dart';
import '../../../domain/controller/messages_controller.dart';

class MessageWidget extends StatefulWidget {
  const MessageWidget({super.key});

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  // Controladores
  AuthenticationController ctrl = Get.find();
  MessagesController msgCtrl = Get.find();
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

  // Widget para mostrar tarjeta de mensaje
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

  // Widget para generar listado de mensajes
  Widget _messageList() {
    return GetX<MessagesController>(
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

  // Widget para crear nuevo mensaje
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

  // Metodo para manejar el scroll automatico de los mensajes
  _scrollToEnd() async {
    _scrollCtrl.animateTo(
      _scrollCtrl.position.maxScrollExtent,
      duration: const Duration(
        milliseconds: 200,
      ),
      curve: Curves.easeInOut,
    );
  }

  // Metodo para agregar mensaje en Firebase
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
