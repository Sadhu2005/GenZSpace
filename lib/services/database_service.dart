import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post_model.dart';
import '../models/user_model.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a new post
  Future<void> createPost(PostModel post) async {
    await _firestore.collection('posts').doc(post.id).set(post.toMap());
  }

  // Get all posts
  Stream<List<PostModel>> getPosts() {
    return _firestore
        .collection('posts')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PostModel.fromMap(doc.data()))
            .toList());
  }

  // Get academic posts only
  Stream<List<PostModel>> getAcademicPosts() {
    return _firestore
        .collection('posts')
        .where('isAcademic', isEqualTo: true)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PostModel.fromMap(doc.data()))
            .toList());
  }

  // Get fun posts only
  Stream<List<PostModel>> getFunPosts() {
    return _firestore
        .collection('posts')
        .where('isAcademic', isEqualTo: false)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PostModel.fromMap(doc.data()))
            .toList());
  }

  // Search users by college, branch, year, etc.
  Stream<List<UserModel>> searchUsers({
    String? college,
    String? branch,
    int? year,
    String? course,
  }) {
    Query query = _firestore.collection('users');

    if (college != null) {
      query = query.where('college', isEqualTo: college);
    }
    if (branch != null) {
      query = query.where('branch', isEqualTo: branch);
    }
    if (year != null) {
      query = query.where('year', isEqualTo: year);
    }
    if (course != null) {
      query = query.where('course', isEqualTo: course);
    }

    return query.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => UserModel.fromMap(doc.data()))
        .toList());
  }

  // Like a post
  Future<void> likePost(String postId, String userId) async {
    await _firestore.collection('posts').doc(postId).update({
      'likes': FieldValue.increment(1),
      'likedBy': FieldValue.arrayUnion([userId]),
    });
  }

  // Add comment to a post
  Future<void> addComment(String postId, Comment comment) async {
    await _firestore.collection('posts').doc(postId).update({
      'comments': FieldValue.arrayUnion([comment.toMap()]),
    });
  }
}