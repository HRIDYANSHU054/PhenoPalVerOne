import 'package:ayurbot/screens/chatbotPage.dart';

class MessageModel {
  late String msg;
  late String sender;

  MessageModel({
    required this.msg,
    required this.sender,
  });

  factory MessageModel.fromJsom({
    required String sender,
    required String msg,
  }) {
    return MessageModel(
      msg: msg,
      sender: sender,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'msg': msg,
      'sender': sender,
    };

    return map;
  }
}
