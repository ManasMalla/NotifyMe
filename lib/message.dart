import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  final String notificationKey;
  const MessageScreen({Key? key, required this.notificationKey})
      : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.notificationKey.isEmpty
            ? "Recieved Notification"
            : widget.notificationKey),
      ),
    );
  }
}
