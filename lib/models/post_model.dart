class FeedType {
  static const String fun = 'Fun';
  static const String academic = 'Academic';
}

class PostModel {
  final String id;
  final String userId;
  final String userName;
  final String userCollege;
  final String content;
  final String? imageUrl;
  final DateTime timestamp;
  final bool isAcademic;
  final int likes;
  final List<String> likedBy;
  final List<Comment> comments;
  final String feedType;

  PostModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userCollege,
    required this.content,
    this.imageUrl,
    required this.timestamp,
    required this.isAcademic,
    this.likes = 0,
    this.likedBy = const [],
    this.comments = const [],
    required this.feedType,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userCollege': userCollege,
      'content': content,
      'imageUrl': imageUrl,
      'timestamp': timestamp.toIso8601String(),
      'isAcademic': isAcademic,
      'likes': likes,
      'likedBy': likedBy,
      'comments': comments.map((comment) => comment.toMap()).toList(),
      'feedType': feedType,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'],
      userId: map['userId'],
      userName: map['userName'],
      userCollege: map['userCollege'],
      content: map['content'],
      imageUrl: map['imageUrl'],
      timestamp: DateTime.parse(map['timestamp']),
      isAcademic: map['isAcademic'],
      likes: map['likes'] ?? 0,
      likedBy: List<String>.from(map['likedBy'] ?? []),
      comments: List<Comment>.from(
          map['comments']?.map((x) => Comment.fromMap(x)) ?? []),
      feedType: map['feedType'],
    );
  }
}

class Comment {
  final String userId;
  final String userName;
  final String content;
  final DateTime timestamp;

  Comment({
    required this.userId,
    required this.userName,
    required this.content,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      userId: map['userId'],
      userName: map['userName'],
      content: map['content'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}