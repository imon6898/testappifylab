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
        backgroundColor: const Color(0xff115C67),
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
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
      body: Column(
        children: [
          GestureDetector(
            onTap: (){
              showPostCreationScreen(context);
            },
              child: MyCustomCard()),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                PostWidget(
                  username: "Alexander John",
                  timeAgo: "2 days ago",
                  content:
                  "Hello everyone this is a post from app to see if attached link is working or not. Here is a link https://www.merriam-webster.com/dictionary/link but I think this is not working. This should work but not working!!!!",
                  imageUrl: "assets/sample.png",
                  likes: 3,
                  comments: 12,
                ),
                const SizedBox(height: 16),
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
        selectedItemColor: const Color(0xff115C67),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 1) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                title: const Center(
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                content: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Are you sure, you want to log out?',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          // Add logout logic here
                        },
                        child: const Text(
                          'Yes',
                          style: TextStyle(
                            color: Color(0xFF6200EE),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'No',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
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

class MyCustomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            flex: 2,
            child: CircleAvatar(
              backgroundColor: Colors.grey[400],
              radius: 24.0,
              child: const Icon(Icons.person, color: Colors.white),
            ),
          ),
          const Expanded(
            flex: 5,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Write Something here...",
                border: InputBorder.none,
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: ElevatedButton(
              onPressed: () {
                // Add your post action here
              },
              child: const Text('Post'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ],
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Icon(Icons.favorite, color: Colors.red),
                  SizedBox(width: 8),
                  Text('You and 2 others', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey.shade300,
                        child: const Icon(Icons.person, color: Colors.grey),
                      ),
                      title: const Text(
                        'IAP Testing',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('4 cup tcake'),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Text('22d', style: TextStyle(color: Colors.grey, fontSize: 12)),
                              SizedBox(width: 16),
                              Text('Like', style: TextStyle(color: Colors.blue, fontSize: 12)),
                              SizedBox(width: 16),
                              Text('Reply', style: TextStyle(color: Colors.blue, fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.thumb_up_alt, color: Colors.blue, size: 16),
                          SizedBox(width: 4),
                          Text('1', style: TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 48.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          child: const Icon(Icons.person, color: Colors.grey),
                        ),
                        title: const Text(
                          'IAP Testing',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: const Text('Hhh'),
                        trailing: const Icon(Icons.more_vert),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade300,
                    child: const Icon(Icons.person, color: Colors.grey),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Write a Comment',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Color(0xff115C67)),
                    onPressed: () {
                      // Handle comment send action
                    },
                  ),
                ],
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
                  child: const Icon(Icons.person, color: Colors.grey),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      widget.timeAgo,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              widget.content,
              style: const TextStyle(fontSize: 14),
            ),
            if (widget.imageUrl != null) ...[
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(widget.imageUrl!),
              ),
            ],
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onLongPressStart: (_) {
                    timer = Timer(const Duration(seconds: 1), () {
                      setState(() {
                        isLongPress = true;
                      });
                      showReactionsOverlay(context);
                    });
                  },
                  onLongPressEnd: (_) {
                    timer?.cancel();
                    if (!isLongPress) {
                      print("Liked");
                    }
                    setState(() {
                      isLongPress = false;
                    });
                  },
                  child: Row(
                    children: [
                      Icon(
                        isLongPress
                            ? Icons.emoji_emotions_outlined
                            : Icons.thumb_up_alt_outlined,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
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
                      const Icon(Icons.comment_outlined, color: Colors.grey),
                      const SizedBox(width: 4),
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



void showPostCreationScreen(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    builder: (BuildContext context) {
      return SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(top: 60.0, bottom: 16, left: 16, right: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      "Close",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Text(
                    "Create Post",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Add post creation logic here
                    },
                    child: const Text(
                      "Create",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const TextField(
                decoration: InputDecoration(
                  hintText: "What's on your mind?",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildColorOption(Colors.white),
                  _buildColorOption(Colors.pink),
                  _buildColorOption(Colors.green),
                  _buildColorOption(Colors.yellow),
                  _buildColorOption(Colors.red),
                  _buildColorOption(Colors.blue),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildColorOption(Color color) {
  return GestureDetector(
    onTap: () {
      // Handle background color selection
    },
    child: Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300),
      ),
    ),
  );
}

