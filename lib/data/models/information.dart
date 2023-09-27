class Message {
  final String sender;
  final String category;
  final String text;

  Message({
    required this.sender,
    required this.category,
    required this.text,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      sender: json['sender'] ?? '',
      category: json['category'] ?? '',
      text: json['text'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'category': category,
      'text': text,
    };
  }
}
