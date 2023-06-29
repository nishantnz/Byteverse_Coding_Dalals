class Message {
  final String senderId;
  final String recieverid;
  final String text;
  final DateTime timeSent;
  final String messageId;
  Message({
    required this.senderId,
    required this.recieverid,
    required this.text,
    required this.timeSent,
    required this.messageId,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'recieverid': recieverid,
      'text': text,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'messageId': messageId,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'] ?? '',
      recieverid: map['recieverid'] ?? '',
      text: map['text'] ?? '',
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
      messageId: map['messageId'] ?? '',
    );
  }
}
