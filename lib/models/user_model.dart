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
  final bool isAlumni;

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
    this.isAlumni = false,
  });
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