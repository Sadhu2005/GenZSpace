class UserModel {
  final String uid;
  final String name;
  final String phone;
  final String collegeId;
  final String college;
  final String course;
  final String branch;
  final int year;
  final List<String> interests;
  final String? instagram;
  final String? linkedin;
  final String? profileImageUrl;
  final String? bio;
  final String? location;
  final DateTime joinedAt;
  final bool isAlumni;
  final bool isVerified;
  final List<String> skills;
  final List<String> achievements;
  final Map<String, dynamic> socialStats;
  final List<String> studySquads;
  final List<String> friends;
  final Map<String, dynamic> privacySettings;

  UserModel({
    required this.uid,
    required this.name,
    required this.phone,
    required this.collegeId,
    required this.college,
    required this.course,
    required this.branch,
    required this.year,
    required this.interests,
    this.instagram,
    this.linkedin,
    this.profileImageUrl,
    this.bio,
    this.location,
    required this.joinedAt,
    this.isAlumni = false,
    this.isVerified = false,
    this.skills = const [],
    this.achievements = const [],
    this.socialStats = const {},
    this.studySquads = const [],
    this.friends = const [],
    this.privacySettings = const {},
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'phone': phone,
      'collegeId': collegeId,
      'college': college,
      'course': course,
      'branch': branch,
      'year': year,
      'interests': interests,
      'instagram': instagram,
      'linkedin': linkedin,
      'profileImageUrl': profileImageUrl,
      'bio': bio,
      'location': location,
      'joinedAt': joinedAt.toIso8601String(),
      'isAlumni': isAlumni,
      'isVerified': isVerified,
      'skills': skills,
      'achievements': achievements,
      'socialStats': socialStats,
      'studySquads': studySquads,
      'friends': friends,
      'privacySettings': privacySettings,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      phone: map['phone'],
      collegeId: map['collegeId'],
      college: map['college'],
      course: map['course'],
      branch: map['branch'],
      year: map['year'],
      interests: List<String>.from(map['interests'] ?? []),
      instagram: map['instagram'],
      linkedin: map['linkedin'],
      profileImageUrl: map['profileImageUrl'],
      bio: map['bio'],
      location: map['location'],
      joinedAt: DateTime.parse(map['joinedAt']),
      isAlumni: map['isAlumni'] ?? false,
      isVerified: map['isVerified'] ?? false,
      skills: List<String>.from(map['skills'] ?? []),
      achievements: List<String>.from(map['achievements'] ?? []),
      socialStats: Map<String, dynamic>.from(map['socialStats'] ?? {}),
      studySquads: List<String>.from(map['studySquads'] ?? []),
      friends: List<String>.from(map['friends'] ?? []),
      privacySettings: Map<String, dynamic>.from(map['privacySettings'] ?? {}),
    );
  }
}

class StudentFilter {
  final String college;
  final String branch;
  final int year;
  final String domain;
  StudentFilter({required this.college, required this.branch, required this.year, required this.domain});
}

class FriendRequest {
  final String fromUserId;
  final String toUserId;
  final DateTime sentAt;
  FriendRequest({required this.fromUserId, required this.toUserId, required this.sentAt});
}

class MiniGroup {
  final String groupId;
  final String groupName;
  final List<String> memberIds;
  MiniGroup({required this.groupId, required this.groupName, required this.memberIds});
}

class FeedbackWallPost {
  final String postId;
  final String userId;
  final String content;
  final DateTime createdAt;
  FeedbackWallPost({required this.postId, required this.userId, required this.content, required this.createdAt});
}
class SkillShowcase {
  final String userId;
  final List<String> skills;
  SkillShowcase({required this.userId, required this.skills});
}
class MarketplaceItem {
  final String itemId;
  final String sellerId;
  final String title;
  final String description;
  final double price;
  MarketplaceItem({required this.itemId, required this.sellerId, required this.title, required this.description, required this.price});
}
class CollegeLeaderboard {
  final String college;
  final int hackathonPoints;
  final int placementPoints;
  CollegeLeaderboard({required this.college, required this.hackathonPoints, required this.placementPoints});
}

// My Vibes (Stories) Model
class MyVibe {
  final String id;
  final String userId;
  final String userName;
  final String userProfileImage;
  final String content;
  final String? imageUrl;
  final String? videoUrl;
  final DateTime createdAt;
  final DateTime expiresAt;
  final List<String> viewedBy;
  final List<String> reactedBy;
  final String vibeType; // 'text', 'image', 'video', 'poll'

  MyVibe({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userProfileImage,
    required this.content,
    this.imageUrl,
    this.videoUrl,
    required this.createdAt,
    required this.expiresAt,
    this.viewedBy = const [],
    this.reactedBy = const [],
    required this.vibeType,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userProfileImage': userProfileImage,
      'content': content,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'createdAt': createdAt.toIso8601String(),
      'expiresAt': expiresAt.toIso8601String(),
      'viewedBy': viewedBy,
      'reactedBy': reactedBy,
      'vibeType': vibeType,
    };
  }

  factory MyVibe.fromMap(Map<String, dynamic> map) {
    return MyVibe(
      id: map['id'],
      userId: map['userId'],
      userName: map['userName'],
      userProfileImage: map['userProfileImage'],
      content: map['content'],
      imageUrl: map['imageUrl'],
      videoUrl: map['videoUrl'],
      createdAt: DateTime.parse(map['createdAt']),
      expiresAt: DateTime.parse(map['expiresAt']),
      viewedBy: List<String>.from(map['viewedBy'] ?? []),
      reactedBy: List<String>.from(map['reactedBy'] ?? []),
      vibeType: map['vibeType'],
    );
  }
}

// Study Chat (Messaging) Model
class StudyChat {
  final String id;
  final String name;
  final String? description;
  final String? imageUrl;
  final List<String> participants;
  final String lastMessage;
  final DateTime lastMessageTime;
  final String lastMessageSender;
  final int unreadCount;
  final String chatType; // 'direct', 'group', 'study_group'
  final Map<String, dynamic> settings;

  StudyChat({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    required this.participants,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.lastMessageSender,
    this.unreadCount = 0,
    required this.chatType,
    this.settings = const {},
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'participants': participants,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime.toIso8601String(),
      'lastMessageSender': lastMessageSender,
      'unreadCount': unreadCount,
      'chatType': chatType,
      'settings': settings,
    };
  }

  factory StudyChat.fromMap(Map<String, dynamic> map) {
    return StudyChat(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      participants: List<String>.from(map['participants'] ?? []),
      lastMessage: map['lastMessage'],
      lastMessageTime: DateTime.parse(map['lastMessageTime']),
      lastMessageSender: map['lastMessageSender'],
      unreadCount: map['unreadCount'] ?? 0,
      chatType: map['chatType'],
      settings: Map<String, dynamic>.from(map['settings'] ?? {}),
    );
  }
}

class ChatMessage {
  final String id;
  final String chatId;
  final String senderId;
  final String senderName;
  final String content;
  final String messageType; // 'text', 'image', 'file', 'voice'
  final DateTime timestamp;
  final bool isRead;
  final String? replyToMessageId;
  final Map<String, dynamic> metadata;

  ChatMessage({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.senderName,
    required this.content,
    required this.messageType,
    required this.timestamp,
    this.isRead = false,
    this.replyToMessageId,
    this.metadata = const {},
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chatId': chatId,
      'senderId': senderId,
      'senderName': senderName,
      'content': content,
      'messageType': messageType,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
      'replyToMessageId': replyToMessageId,
      'metadata': metadata,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'],
      chatId: map['chatId'],
      senderId: map['senderId'],
      senderName: map['senderName'],
      content: map['content'],
      messageType: map['messageType'],
      timestamp: DateTime.parse(map['timestamp']),
      isRead: map['isRead'] ?? false,
      replyToMessageId: map['replyToMessageId'],
      metadata: Map<String, dynamic>.from(map['metadata'] ?? {}),
    );
  }
}

// Study Swap (Marketplace) Model
class StudySwapItem {
  final String id;
  final String sellerId;
  final String sellerName;
  final String title;
  final String description;
  final double price;
  final String category; // 'books', 'notes', 'equipment', 'services'
  final List<String> images;
  final String condition;
  final String location;
  final DateTime createdAt;
  final bool isAvailable;
  final List<String> interestedBuyers;
  final String? soldTo;
  final DateTime? soldAt;

  StudySwapItem({
    required this.id,
    required this.sellerId,
    required this.sellerName,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    this.images = const [],
    required this.condition,
    required this.location,
    required this.createdAt,
    this.isAvailable = true,
    this.interestedBuyers = const [],
    this.soldTo,
    this.soldAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sellerId': sellerId,
      'sellerName': sellerName,
      'title': title,
      'description': description,
      'price': price,
      'category': category,
      'images': images,
      'condition': condition,
      'location': location,
      'createdAt': createdAt.toIso8601String(),
      'isAvailable': isAvailable,
      'interestedBuyers': interestedBuyers,
      'soldTo': soldTo,
      'soldAt': soldAt?.toIso8601String(),
    };
  }

  factory StudySwapItem.fromMap(Map<String, dynamic> map) {
    return StudySwapItem(
      id: map['id'],
      sellerId: map['sellerId'],
      sellerName: map['sellerName'],
      title: map['title'],
      description: map['description'],
      price: map['price'].toDouble(),
      category: map['category'],
      images: List<String>.from(map['images'] ?? []),
      condition: map['condition'],
      location: map['location'],
      createdAt: DateTime.parse(map['createdAt']),
      isAvailable: map['isAvailable'] ?? true,
      interestedBuyers: List<String>.from(map['interestedBuyers'] ?? []),
      soldTo: map['soldTo'],
      soldAt: map['soldAt'] != null ? DateTime.parse(map['soldAt']) : null,
    );
  }
}

// Campus Connect (Events) Model
class CampusEvent {
  final String id;
  final String organizerId;
  final String organizerName;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final String location;
  final String eventType; // 'academic', 'social', 'sports', 'cultural'
  final List<String> attendees;
  final int maxAttendees;
  final String? imageUrl;
  final List<String> tags;
  final bool isOnline;
  final String? meetingLink;
  final Map<String, dynamic> requirements;

  CampusEvent({
    required this.id,
    required this.organizerId,
    required this.organizerName,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.eventType,
    this.attendees = const [],
    required this.maxAttendees,
    this.imageUrl,
    this.tags = const [],
    this.isOnline = false,
    this.meetingLink,
    this.requirements = const {},
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'organizerId': organizerId,
      'organizerName': organizerName,
      'title': title,
      'description': description,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'location': location,
      'eventType': eventType,
      'attendees': attendees,
      'maxAttendees': maxAttendees,
      'imageUrl': imageUrl,
      'tags': tags,
      'isOnline': isOnline,
      'meetingLink': meetingLink,
      'requirements': requirements,
    };
  }

  factory CampusEvent.fromMap(Map<String, dynamic> map) {
    return CampusEvent(
      id: map['id'],
      organizerId: map['organizerId'],
      organizerName: map['organizerName'],
      title: map['title'],
      description: map['description'],
      startTime: DateTime.parse(map['startTime']),
      endTime: DateTime.parse(map['endTime']),
      location: map['location'],
      eventType: map['eventType'],
      attendees: List<String>.from(map['attendees'] ?? []),
      maxAttendees: map['maxAttendees'],
      imageUrl: map['imageUrl'],
      tags: List<String>.from(map['tags'] ?? []),
      isOnline: map['isOnline'] ?? false,
      meetingLink: map['meetingLink'],
      requirements: Map<String, dynamic>.from(map['requirements'] ?? {}),
    );
  }
}

// Study Squads (Groups) Model
class StudySquad {
  final String id;
  final String name;
  final String description;
  final String? imageUrl;
  final String creatorId;
  final List<String> members;
  final List<String> admins;
  final String category; // 'study', 'project', 'hobby', 'sports'
  final String privacy; // 'public', 'private', 'invite_only'
  final List<String> tags;
  final DateTime createdAt;
  final Map<String, dynamic> settings;
  final List<String> recentPosts;

  StudySquad({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl,
    required this.creatorId,
    this.members = const [],
    this.admins = const [],
    required this.category,
    required this.privacy,
    this.tags = const [],
    required this.createdAt,
    this.settings = const {},
    this.recentPosts = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'creatorId': creatorId,
      'members': members,
      'admins': admins,
      'category': category,
      'privacy': privacy,
      'tags': tags,
      'createdAt': createdAt.toIso8601String(),
      'settings': settings,
      'recentPosts': recentPosts,
    };
  }

  factory StudySquad.fromMap(Map<String, dynamic> map) {
    return StudySquad(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      creatorId: map['creatorId'],
      members: List<String>.from(map['members'] ?? []),
      admins: List<String>.from(map['admins'] ?? []),
      category: map['category'],
      privacy: map['privacy'],
      tags: List<String>.from(map['tags'] ?? []),
      createdAt: DateTime.parse(map['createdAt']),
      settings: Map<String, dynamic>.from(map['settings'] ?? {}),
      recentPosts: List<String>.from(map['recentPosts'] ?? []),
    );
  }
}

// Campus Alerts (Notifications) Model
class CampusAlert {
  final String id;
  final String title;
  final String message;
  final String type; // 'academic', 'social', 'emergency', 'general'
  final String priority; // 'low', 'medium', 'high', 'urgent'
  final DateTime createdAt;
  final DateTime? expiresAt;
  final String? actionUrl;
  final String? imageUrl;
  final Map<String, dynamic> metadata;
  final List<String> targetAudience; // college, branch, year, etc.

  CampusAlert({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.priority,
    required this.createdAt,
    this.expiresAt,
    this.actionUrl,
    this.imageUrl,
    this.metadata = const {},
    this.targetAudience = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'type': type,
      'priority': priority,
      'createdAt': createdAt.toIso8601String(),
      'expiresAt': expiresAt?.toIso8601String(),
      'actionUrl': actionUrl,
      'imageUrl': imageUrl,
      'metadata': metadata,
      'targetAudience': targetAudience,
    };
  }

  factory CampusAlert.fromMap(Map<String, dynamic> map) {
    return CampusAlert(
      id: map['id'],
      title: map['title'],
      message: map['message'],
      type: map['type'],
      priority: map['priority'],
      createdAt: DateTime.parse(map['createdAt']),
      expiresAt: map['expiresAt'] != null ? DateTime.parse(map['expiresAt']) : null,
      actionUrl: map['actionUrl'],
      imageUrl: map['imageUrl'],
      metadata: Map<String, dynamic>.from(map['metadata'] ?? {}),
      targetAudience: List<String>.from(map['targetAudience'] ?? []),
    );
  }
}