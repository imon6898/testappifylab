import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsfeedController extends GetxController {
  // Observable data for posts and loading state
  var posts = [].obs;
  var isLoading = false.obs;

  // API Endpoints
  final String fetchPostsUrl =
      "https://iap.ezycourse.com/api/app/teacher/community/getFeed";
  final String likePostUrl =
      "https://iap.ezycourse.com/api/app/teacher/community/createLike";
  final String addCommentUrl =
      "https://iap.ezycourse.com/api/app/student/comment/createComment";

  // Fetch posts from API
  Future<void> fetchPosts() async {
    isLoading.value = true;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      if (token == null) {
        Get.snackbar("Error", "Authentication token not found.");
        return;
      }

      final payload = {
        "community_id": "2914",
        "space_id": "5883",
        "more": "",
      };
      print("Request Payload: $payload");

      final response = await http.post(
        Uri.parse(fetchPostsUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(payload),

      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        posts.value = data['data'];
      } else {
        print("Error: ${response.statusCode}");
        print("Response Body: ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Like a post
  Future<void> likePost(String feedId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      if (token == null) {
        Get.snackbar("Error", "No authentication token found. Please log in.");
        return;
      }

      final response = await http.post(
        Uri.parse(likePostUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "feed_id": feedId,
          "reaction_type": "LIKE",
          "action": "create",
        }),
      );

      if (response.statusCode == 200) {
        fetchPosts();
      } else {
        Get.snackbar("Error", "Failed to like the post");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    }
  }

  // Add a comment to a post
  Future<void> addComment(String feedId, String comment) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      if (token == null) {
        Get.snackbar("Error", "No authentication token found. Please log in.");
        return;
      }

      final response = await http.post(
        Uri.parse(addCommentUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "feed_id": feedId,
          "comment_txt": comment,
          "commentSource": "COMMUNITY",
        }),
      );

      if (response.statusCode == 200) {
        fetchPosts();
      } else {
        Get.snackbar("Error", "Failed to add a comment");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }
}
