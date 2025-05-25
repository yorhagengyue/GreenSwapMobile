import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final List<NotificationCategory> _categories = [
    NotificationCategory(
      title: 'Like',
      color: Colors.red,
      gradient: [Colors.red, Colors.orange],
    ),
    NotificationCategory(
      title: 'Feedback',
      color: Colors.orange,
      gradient: [Colors.orange, Colors.yellow],
    ),
    NotificationCategory(
      title: 'Notification',
      color: Colors.blue,
      gradient: [Colors.blue, Colors.lightBlue],
    ),
  ];

  final List<UserAvatar> _userAvatars = [
    UserAvatar(
      image: 'assets/images/avatar1.jpg',
      isOnline: true,
    ),
    UserAvatar(
      image: 'assets/images/avatar2.jpg',
      isOnline: true,
    ),
    UserAvatar(
      image: 'assets/images/avatar3.jpg',
      isOnline: true,
    ),
    UserAvatar(
      image: 'assets/images/avatar4.jpg',
      isOnline: true,
    ),
  ];

  final List<NotificationMessage> _messages = [
    NotificationMessage(
      username: 'vvvvvvv',
      message: 'I noticed a problem with this guide today...',
      time: '06-01',
      hasUnread: true,
      avatar: 'assets/images/avatar_girl.jpg',
    ),
    NotificationMessage(
      username: 'Fly Cut Cut',
      message: 'I have a major question about this guide.',
      time: '12:10',
      hasUnread: false,
      avatar: 'assets/images/avatar_plant_girl.jpg',
    ),
    NotificationMessage(
      username: 'poison.',
      message: '[Link] How to handle this episode?',
      time: '02-01',
      hasUnread: false,
      avatar: 'assets/images/avatar_sunset.jpg',
    ),
    NotificationMessage(
      username: 'World Economy',
      message: 'Thunder Monkey!',
      time: 'Tuesday',
      hasUnread: false,
      avatar: 'assets/images/avatar_economy.jpg',
    ),
    NotificationMessage(
      username: 'Emily',
      message: 'I am Emily',
      time: 'Tuesday',
      hasUnread: false,
      avatar: 'assets/images/avatar_emily.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Notifications',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Notification categories
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: _categories.map((category) => Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: category.gradient,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        category.title,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )).toList(),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // User avatars
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: _userAvatars.map((user) => Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: Stack(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300],
                          image: const DecorationImage(
                            image: AssetImage('assets/images/nature2.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      if (user.isOnline)
                        Positioned(
                          bottom: 2,
                          right: 2,
                          child: Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                    ],
                  ),
                )).toList(),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Messages list
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      // Avatar
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300],
                          image: const DecorationImage(
                            image: AssetImage('assets/images/nature2.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      
                      const SizedBox(width: 12),
                      
                      // Message content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  message.username,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      message.time,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    if (message.hasUnread)
                                      Container(
                                        margin: const EdgeInsets.only(left: 8),
                                        width: 20,
                                        height: 20,
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Center(
                                          child: Text(
                                            '1',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              message.message,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: 3, // Messages tab selected
          onTap: (i) {
            if (i != 3) {
              Navigator.of(context).pop();
            }
          },
          selectedItemColor: const Color(0xFF4CAF50),
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          unselectedLabelStyle: GoogleFonts.poppins(),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Browse'),
            BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Add Plant'),
            BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

class NotificationCategory {
  final String title;
  final Color color;
  final List<Color> gradient;

  NotificationCategory({
    required this.title,
    required this.color,
    required this.gradient,
  });
}

class UserAvatar {
  final String image;
  final bool isOnline;

  UserAvatar({
    required this.image,
    required this.isOnline,
  });
}

class NotificationMessage {
  final String username;
  final String message;
  final String time;
  final bool hasUnread;
  final String avatar;

  NotificationMessage({
    required this.username,
    required this.message,
    required this.time,
    required this.hasUnread,
    required this.avatar,
  });
} 