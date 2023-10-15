
class MessageModel {
  String? sender;
  String? text;
  bool? seen;
  DateTime? messageCreateTime;
  MessageModel({
    this.sender,
    this.text,
    this.seen,
    this.messageCreateTime,
  });
MessageModel.fromMap(Map <String, dynamic> map){
    sender =map["sender"];
    text =map["text"];
    seen =map["seen"];
    messageCreateTime =map["messageCreateTime"];
  }


  Map<String ,dynamic> toMap(){
    return {
        "sender": sender,
        "text" : text,
        "seen" :seen,
        "messageCreateTime" : messageCreateTime
    };

  }

}
