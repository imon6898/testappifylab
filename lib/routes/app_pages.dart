import 'package:get/get.dart';
import '../screens/comment_screens/comment_screen.dart';
import '../screens/login_screens/login_screen.dart';
import '../screens/newsfeed_screens/newsfeed_screen.dart';
import 'app_routes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.LoginScreen,
      page: () => LoginScreen(),
    ),

    GetPage(
      name: AppRoutes.NewsfeedScreen,
      page: () => NewsfeedScreen(),
    ),

    GetPage(
      name: AppRoutes.CommentScreen,
      page: () => CommentScreen(),
    ),

    GetPage(
      name: AppRoutes.NewsfeedScreen,
      page: () => NewsfeedScreen(),
    ),

  ];
}
