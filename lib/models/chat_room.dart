class ChatRoomModel {

  String? chatroomId;
  List<String>? participants;
  ChatRoomModel({
    this.chatroomId,
    this.participants,
  });
ChatRoomModel.fromMap(Map <String, dynamic> map){
    chatroomId =map["chatroomId"];
    participants =map["participants"];
   
  }


  Map<String ,dynamic> toMap(){
    return {
       "chatroomId" : chatroomId,
       "participants" : participants
    };

  }
}
