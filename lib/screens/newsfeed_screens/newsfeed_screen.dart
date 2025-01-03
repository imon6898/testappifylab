import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'dart:async';

import '../../routes/app_routes.dart';

class NewsfeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff115C67),
        leading: GestureDetector(
          onTap: () {
            // Add functionality for menu tap
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              "assets/icons/menu.svg",
              height: 18,
              width: 18,
              color: Colors.white,
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Python Developer Community",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              "#General",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          PostWidget(
            username: "Alexander John",
            timeAgo: "2 days ago",
            content: "Hello everyone this is a post from app to see if attached link is working or not. Here is a link https://www.merriam-webster.com/dictionary/link but I think this is not working. This should work but not working!!!!",
            imageUrl: "assets/sample.png",
            likes: 3,
            comments: 12,
          ),
          SizedBox(height: 16),
          PostWidget(
            username: "Ruiz Rahim",
            timeAgo: "2 days ago",
            content: "This is sample Test for Checking",
            imageUrl: null,
            likes: 0,
            comments: 0,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
        selectedItemColor: Color(0xff115C67),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 1) { // Logout button is tapped
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Logout'),
                content: Text('Are you sure, you want to logout?'),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.offAllNamed(AppRoutes.LoginScreen);
                        },
                        child: Text('Yes'),
                      ),

                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: Text('No'),
                      ),
                    ],
                  ),

                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class PostWidget extends StatefulWidget {
  final String username;
  final String timeAgo;
  final String content;
  final String? imageUrl;
  final int likes;
  final int comments;

  const PostWidget({
    required this.username,
    required this.timeAgo,
    required this.content,
    this.imageUrl,
    required this.likes,
    required this.comments,
  });

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool isLongPress = false;
  Timer? timer;

  void showReactionsOverlay(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildReactionIcon(context, "assets/icons/like.svg"),
            _buildReactionIcon(context, "assets/icons/love.svg"),
            _buildReactionIcon(context, "assets/icons/care.svg"),
            _buildReactionIcon(context, "assets/icons/haha.svg"),
            _buildReactionIcon(context, "assets/icons/wow.svg"),
            _buildReactionIcon(context, "assets/icons/sad.svg"),
            _buildReactionIcon(context, "assets/icons/angry.svg"),
          ],
        ),
      ),
    );
  }

  Widget _buildReactionIcon(BuildContext context, String iconPath) {
    return GestureDetector(
      onTap: () {
        print("Selected reaction from $iconPath");
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SvgPicture.asset(
          iconPath,
          height: 20,
          width: 20,
        ),
      ),
    );
  }

  void showCommentsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Comments',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 5, // Replace with actual comment count
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      child: Icon(Icons.person, color: Colors.grey.shade700),
                    ),
                    title: Text('User $index'),
                    subtitle: Text('This is a sample comment.'),
                  );
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Write a comment...',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  // Add comment submission logic
                  Navigator.pop(context);
                },
                child: Text('Post Comment'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey.shade300,
                  child: Icon(Icons.person, color: Colors.grey.shade700),
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.username,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      widget.timeAgo,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              widget.content,
              style: TextStyle(fontSize: 14),
            ),
            if (widget.imageUrl != null) ...[
              SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(widget.imageUrl!),
              ),
            ],
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onLongPressStart: (_) {
                    timer = Timer(Duration(seconds: 1), () {
                      setState(() {
                        isLongPress = true;
                      });
                      showReactionsOverlay(context);
                    });
                  },
                  onLongPressEnd: (_) {
                    timer?.cancel();
                    if (!isLongPress) {
                      // Handle regular like
                      print("Liked");
                    }
                    setState(() {
                      isLongPress = false;
                    });
                  },
                  child: Row(
                    children: [
                      Icon(
                        isLongPress ? Icons.emoji_emotions_outlined : Icons.thumb_up_alt_outlined,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 4),
                      Text("${widget.likes} Likes"),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showCommentsBottomSheet(context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.comment_outlined, color: Colors.grey),
                      SizedBox(width: 4),
                      Text("${widget.comments} Comments"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
