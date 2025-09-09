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