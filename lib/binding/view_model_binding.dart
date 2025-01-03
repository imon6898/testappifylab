import 'package:get/get.dart';
import 'package:testappifylab/screens/login_screens/controller/login_controller.dart';
import 'package:testappifylab/screens/newsfeed_screens/controller/newsfeed_controller.dart';
import '../screens/comment_screens/controller/comment_controller.dart';



class ViewModelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
    Get.lazyPut<NewsfeedController>(() => NewsfeedController(), fenix: true);
    Get.lazyPut<CommentController>(() => CommentController(), fenix: true);
    // Get.lazyPut<LoginController>(() => LoginController(), fenix: true);

  }
}