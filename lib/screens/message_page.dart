import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'browse_page.dart';
import 'add_plant_page.dart';
import 'profile_page.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _pulseController;
  String _selectedFilter = 'All';
  
  final List<String> _filterOptions = ['All', 'Unread', 'Groups', 'Support', 'Active'];
  
  final List<ChatItem> _chatItems = [
    ChatItem(
      name: "GreenSwap Support",
      avatar: Icons.eco,
      lastMessage: "Welcome to GreenSwap! How can we help you today?",
      time: "09:30",
      isOfficial: true,
      unreadCount: 1,
      isOnline: true,
      messageType: MessageType.text,
    ),
    ChatItem(
      name: "John Smith",
      avatar: Icons.person,
      lastMessage: "Hi, is the plant still available?",
      time: "Yesterday",
      unreadCount: 2,
      isOnline: true,
      messageType: MessageType.text,
      lastSeen: "2 min ago",
    ),
    ChatItem(
      name: "Mary Johnson",
      avatar: Icons.person,
      lastMessage: "Thank you for the quick delivery!",
      time: "Yesterday",
      isOnline: false,
      messageType: MessageType.text,
      lastSeen: "1 hour ago",
    ),
    ChatItem(
      name: "Alex Wong",
      avatar: Icons.person,
      lastMessage: "Can I pick it up tomorrow afternoon?",
      time: "06/15",
      isOnline: true,
      messageType: MessageType.text,
      lastSeen: "Active now",
    ),
    ChatItem(
      name: "Lisa Chen",
      avatar: Icons.person,
      lastMessage: "Would you accept \$25 for it?",
      time: "06/14",
      isOnline: false,
      messageType: MessageType.text,
      lastSeen: "3 hours ago",
    ),
    ChatItem(
      name: "Plant Exchange Group",
      avatar: Icons.group,
      lastMessage: "New eco-friendly items now available!",
      time: "06/12",
      isOfficial: true,
      unreadCount: 5,
      isOnline: true,
      messageType: MessageType.text,
      memberCount: 1247,
    ),
    ChatItem(
      name: "Sarah Williams",
      avatar: Icons.person,
      lastMessage: "📷 Photo",
      time: "06/11",
      isOnline: false,
      messageType: MessageType.image,
      lastSeen: "Yesterday",
    ),
    ChatItem(
      name: "Plant Care Tips",
      avatar: Icons.tips_and_updates,
      lastMessage: "💡 New tip: Watering schedule for succulents",
      time: "06/10",
      isOfficial: true,
      isOnline: true,
      messageType: MessageType.tip,
      memberCount: 856,
    ),
    ChatItem(
      name: "Mike Rodriguez",
      avatar: Icons.person,
      lastMessage: "🎵 Voice message",
      time: "06/09",
      isOnline: true,
      messageType: MessageType.voice,
      lastSeen: "5 min ago",
    ),
    ChatItem(
      name: "Plant Swap Singapore",
      avatar: Icons.group,
      lastMessage: "📍 Weekend market at Botanic Gardens",
      time: "06/08",
      isOfficial: true,
      unreadCount: 12,
      isOnline: true,
      messageType: MessageType.location,
      memberCount: 2341,
    ),
    ChatItem(
      name: "Emma Thompson",
      avatar: Icons.person,
      lastMessage: "Thanks! The monstera is beautiful 🌿",
      time: "06/07",
      isOnline: false,
      messageType: MessageType.text,
      lastSeen: "2 days ago",
    ),
    ChatItem(
      name: "Rare Plants Collectors",
      avatar: Icons.group,
      lastMessage: "🔥 Rare variegated monstera available!",
      time: "06/06",
      isOfficial: true,
      unreadCount: 8,
      isOnline: true,
      messageType: MessageType.text,
      memberCount: 567,
    ),
  ];

  final List<QuickAction> _quickActions = [
    QuickAction(
      title: 'New Group',
      icon: Icons.group_add,
      color: const Color(0xFF4CAF50),
    ),
    QuickAction(
      title: 'Scan QR',
      icon: Icons.qr_code_scanner,
      color: Colors.blue,
    ),
    QuickAction(
      title: 'Nearby',
      icon: Icons.location_on,
      color: Colors.orange,
    ),
    QuickAction(
      title: 'Support',
      icon: Icons.help_outline,
      color: Colors.purple,
    ),
  ];

  List<ChatItem> get _filteredChatItems {
    switch (_selectedFilter) {
      case 'Unread':
        return _chatItems.where((item) => item.unreadCount > 0).toList();
      case 'Groups':
        return _chatItems.where((item) => item.memberCount != null).toList();
      case 'Support':
        return _chatItems.where((item) => item.isOfficial).toList();
      case 'Active':
        return _chatItems.where((item) => item.isOnline).toList();
      default:
        return _chatItems;
    }
  }

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildSearchBar().animate().fadeIn(duration: 600.ms).slideY(begin: -0.1),
                const SizedBox(height: 16),
                _buildQuickActions().animate().fadeIn(duration: 600.ms, delay: 100.ms).slideX(begin: -0.1),
                const SizedBox(height: 16),
                _buildFilterTabs().animate().fadeIn(duration: 600.ms, delay: 200.ms),
                const SizedBox(height: 8),
                _buildActiveNowSection().animate().fadeIn(duration: 600.ms, delay: 300.ms),
                const SizedBox(height: 16),
              ],
            ),
          ),
          _buildChatList(),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 100,
      floating: false,
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.arrow_back, color: Colors.black87, size: 20),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF4CAF50).withOpacity(0.1),
                const Color(0xFF81C784).withOpacity(0.05),
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                children: [
                  AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: 1.0 + (_pulseController.value * 0.1),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4CAF50).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.message,
                            color: Color(0xFF4CAF50),
                            size: 24,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Messages',
                        style: GoogleFonts.poppins(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        '${_chatItems.where((item) => item.unreadCount > 0).length} unread conversations',
                        style: GoogleFonts.poppins(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.edit_outlined, color: Colors.black87, size: 20),
          ),
          onPressed: () {
            _showNewChatDialog(context);
          },
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search conversations...',
            hintStyle: GoogleFonts.poppins(color: Colors.grey[500]),
            prefixIcon: Container(
              padding: const EdgeInsets.all(12),
              child: const Icon(Icons.search, color: Color(0xFF4CAF50), size: 20),
            ),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, color: Colors.grey, size: 20),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {});
                    },
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
          onChanged: (value) => setState(() {}),
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      height: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Quick Actions',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _quickActions.length,
              itemBuilder: (context, index) {
                final action = _quickActions[index];
                return Container(
                  width: 120,
                  margin: const EdgeInsets.only(right: 12),
                  child: GestureDetector(
                    onTap: () => _handleQuickAction(action.title),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                        color: action.color.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: action.color.withOpacity(0.2),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            action.icon,
                            color: action.color,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              action.title,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[800],
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ).animate().fadeIn(delay: Duration(milliseconds: index * 100)).scale(begin: const Offset(0.8, 0.8));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Container(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _filterOptions.length,
        itemBuilder: (context, index) {
          final filter = _filterOptions[index];
          final isSelected = filter == _selectedFilter;
          final unreadCount = _getUnreadCountForFilter(filter);
          
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedFilter = filter;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: isSelected ? const LinearGradient(
                  colors: [Color(0xFF4CAF50), Color(0xFF45A049)],
                ) : null,
                color: isSelected ? null : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? Colors.transparent : Colors.grey[300]!,
                ),
                boxShadow: isSelected ? [
                  BoxShadow(
                    color: const Color(0xFF4CAF50).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ] : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    filter,
                    style: GoogleFonts.poppins(
                      color: isSelected ? Colors.white : Colors.grey[700],
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      fontSize: 12,
                    ),
                  ),
                  if (unreadCount > 0) ...[
                    const SizedBox(width: 8),
                    Transform.translate(
                      offset: const Offset(0, -1),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.white.withOpacity(0.35) : Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          unreadCount.toString(),
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ).animate(target: isSelected ? 1 : 0)
            .scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05), duration: 200.ms);
        },
      ),
    );
  }

  Widget _buildActiveNowSection() {
    final activeUsers = _chatItems.where((item) => item.isOnline && item.memberCount == null).take(6).toList();
    
    if (activeUsers.isEmpty) return const SizedBox.shrink();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Active Now',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '(${activeUsers.length})',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 70,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: activeUsers.length,
            itemBuilder: (context, index) {
              final user = activeUsers[index];
              return Container(
                margin: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ChatDetailPage(chatItem: user),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xFF4CAF50).withAlpha(20),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.green,
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              user.avatar,
                              color: const Color(0xFF4CAF50),
                              size: 24,
                            ),
                          ),
                          Positioned(
                            bottom: 2,
                            right: 2,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.name.split(' ')[0],
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn(delay: Duration(milliseconds: index * 100)).scale(begin: const Offset(0.8, 0.8));
            },
          ),
        ),
      ],
    );
  }

  Widget _buildChatList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final item = _filteredChatItems[index];
          return _buildChatItem(item, index);
        },
        childCount: _filteredChatItems.length,
      ),
    );
  }

  Widget _buildChatItem(ChatItem item, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChatDetailPage(chatItem: item),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar with status
            Stack(
              children: [
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: item.isOfficial ? const Color(0xFF4CAF50).withAlpha(20) : Colors.grey.withAlpha(20),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    item.avatar,
                    color: item.isOfficial ? const Color(0xFF4CAF50) : Colors.grey,
                    size: 30,
                  ),
                ),
                if (item.isOfficial)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.verified,
                        color: Color(0xFF4CAF50),
                        size: 16,
                      ),
                    ),
                  ),
                if (!item.isOfficial && item.isOnline)
                  Positioned(
                    right: 2,
                    bottom: 2,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            // Message content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              item.name,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            if (item.memberCount != null) ...[
                              const SizedBox(width: 4),
                              Text(
                                '(${item.memberCount})',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            item.time,
                            style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          if (item.unreadCount > 0)
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Color(0xFF4CAF50),
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                item.unreadCount.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      _buildMessageTypeIcon(item.messageType),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          item.lastMessage,
                          style: GoogleFonts.poppins(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  if (item.lastSeen != null && !item.isOnline)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        'Last seen ${item.lastSeen}',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: index * 50), duration: 300.ms)
      .slideX(begin: 0.1, end: 0, delay: Duration(milliseconds: index * 50), duration: 300.ms, curve: Curves.easeOutCubic);
  }

  Widget _buildMessageTypeIcon(MessageType type) {
    switch (type) {
      case MessageType.image:
        return const Icon(Icons.image, size: 14, color: Colors.blue);
      case MessageType.voice:
        return const Icon(Icons.mic, size: 14, color: Colors.orange);
      case MessageType.location:
        return const Icon(Icons.location_on, size: 14, color: Colors.red);
      case MessageType.tip:
        return const Icon(Icons.lightbulb, size: 14, color: Colors.amber);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        _showNewChatDialog(context);
      },
      backgroundColor: const Color(0xFF4CAF50),
      child: const Icon(Icons.add, color: Colors.white),
    ).animate()
      .scale(delay: 800.ms, duration: 400.ms, curve: Curves.elasticOut);
  }

  int _getUnreadCountForFilter(String filter) {
    switch (filter) {
      case 'Unread':
        return _chatItems.where((item) => item.unreadCount > 0).length;
      case 'Groups':
        return _chatItems.where((item) => item.memberCount != null && item.unreadCount > 0).length;
      case 'Support':
        return _chatItems.where((item) => item.isOfficial && item.unreadCount > 0).length;
      case 'Active':
        return _chatItems.where((item) => item.isOnline && item.unreadCount > 0).length;
      default:
        return 0;
    }
  }

  void _handleQuickAction(String action) {
    switch (action) {
      case 'New Group':
        _showCreateGroupDialog();
        break;
      case 'Scan QR':
        _showQRScanner();
        break;
      case 'Nearby':
        _showNearbyUsers();
        break;
      case 'Support':
        _contactSupport();
        break;
    }
  }

  void _showCreateGroupDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Create New Group',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Group name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Description (optional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: GoogleFonts.poppins()),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
              ),
              child: Text('Create', style: GoogleFonts.poppins(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showQRScanner() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('QR Scanner feature coming soon!', style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF4CAF50),
      ),
    );
  }

  void _showNearbyUsers() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Nearby users feature coming soon!', style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF4CAF50),
      ),
    );
  }

  void _contactSupport() {
    final supportChat = _chatItems.firstWhere(
      (item) => item.name == "GreenSwap Support",
      orElse: () => _chatItems.first,
    );
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChatDetailPage(chatItem: supportChat),
      ),
    );
  }

  void _showNewChatDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Start New Chat',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.support_agent,
                    color: Color(0xFF4CAF50),
                  ),
                ),
                title: Text(
                  'Contact Support',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  'Get help with your account',
                  style: GoogleFonts.poppins(fontSize: 12),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _contactSupport();
                },
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.search,
                    color: Colors.blue,
                  ),
                ),
                title: Text(
                  'Find Users',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  'Search for other plant lovers',
                  style: GoogleFonts.poppins(fontSize: 12),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _showNearbyUsers();
                },
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.group_add,
                    color: Colors.orange,
                  ),
                ),
                title: Text(
                  'Create Group',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  'Start a plant community',
                  style: GoogleFonts.poppins(fontSize: 12),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _showCreateGroupDialog();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomNav() {
    return Container(
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
          if (i == 0) {
            Navigator.of(context).pop(); // Go back to Home
          } else if (i == 1) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const BrowsePage()),
            );
          } else if (i == 2) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const AddPlantPage()),
            );
          } else if (i == 4) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
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
    );
  }
}

// Message model
class Message {
  final String text;
  final bool isMe;
  final String time;
  final IconData avatar;
  final MessageType type;

  Message({
    required this.text,
    required this.isMe,
    required this.time,
    required this.avatar,
    this.type = MessageType.text,
  });
}

enum MessageType {
  text,
  image,
  plantCard,
  location,
  voice,
  tip,
}

class ChatItem {
  final String name;
  final IconData avatar;
  final String lastMessage;
  final String time;
  final bool isOfficial;
  final int unreadCount;
  final bool isOnline;
  final MessageType messageType;
  final String? lastSeen;
  final int? memberCount;

  ChatItem({
    required this.name,
    required this.avatar,
    required this.lastMessage,
    required this.time,
    this.isOfficial = false,
    this.unreadCount = 0,
    this.isOnline = false,
    this.messageType = MessageType.text,
    this.lastSeen,
    this.memberCount,
  });
}

class QuickAction {
  final String title;
  final IconData icon;
  final Color color;

  QuickAction({
    required this.title,
    required this.icon,
    required this.color,
  });
}

// Chat Detail Page
class ChatDetailPage extends StatefulWidget {
  final ChatItem chatItem;

  const ChatDetailPage({super.key, required this.chatItem});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late AnimationController _typingController;
  
  List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    _typingController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    
    _initializeMessages();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _typingController.dispose();
    super.dispose();
  }

  void _initializeMessages() {
    // Initialize with some sample messages based on the chat item
    if (widget.chatItem.name == "GreenSwap Support") {
      _messages = [
        Message(
          text: "Hello! Welcome to GreenSwap! 🌱",
          isMe: false,
          time: "09:25",
          avatar: Icons.eco,
          type: MessageType.text,
        ),
        Message(
          text: "How can I help you today?",
          isMe: false,
          time: "09:25",
          avatar: Icons.eco,
          type: MessageType.text,
        ),
        Message(
          text: "I have a question about plant care",
          isMe: true,
          time: "09:26",
          avatar: Icons.person,
          type: MessageType.text,
        ),
        Message(
          text: "Of course! I'd be happy to help. What plant are you caring for?",
          isMe: false,
          time: "09:27",
          avatar: Icons.eco,
          type: MessageType.text,
        ),
        Message(
          text: "assets/images/nature2.jpg",
          isMe: true,
          time: "09:28",
          avatar: Icons.person,
          type: MessageType.image,
        ),
        Message(
          text: "Beautiful Monstera! Here are some care tips:",
          isMe: false,
          time: "09:29",
          avatar: Icons.eco,
          type: MessageType.text,
        ),
        Message(
          text: "• Water when top soil is dry\n• Bright, indirect light\n• Humidity 40-60%\n• Temperature 65-80°F",
          isMe: false,
          time: "09:29",
          avatar: Icons.eco,
          type: MessageType.text,
        ),
        Message(
          text: widget.chatItem.lastMessage,
          isMe: false,
          time: widget.chatItem.time,
          avatar: Icons.eco,
          type: MessageType.text,
        ),
      ];
    } else if (widget.chatItem.name == "John Smith") {
      _messages = [
        Message(
          text: "Hey! I saw your succulent collection on your profile 🌵",
          isMe: false,
          time: "2 days ago",
          avatar: Icons.person,
          type: MessageType.text,
        ),
        Message(
          text: "Hi John! Thanks for checking it out! Which ones caught your eye? 😊",
          isMe: true,
          time: "2 days ago",
          avatar: Icons.person,
          type: MessageType.text,
        ),
        Message(
          text: "The jade plant looks amazing! Is it still available?",
          isMe: false,
          time: "2 days ago",
          avatar: Icons.person,
          type: MessageType.text,
        ),
        Message(
          text: "Jade Plant|Succulent|\$18|4.7|3-year-old healthy jade, perfect for beginners",
          isMe: true,
          time: "2 days ago",
          avatar: Icons.person,
          type: MessageType.plantCard,
        ),
        Message(
          text: "Perfect! I'm actually looking to trade. I have some rare air plants 🌿",
          isMe: false,
          time: "2 days ago",
          avatar: Icons.person,
          type: MessageType.text,
        ),
        Message(
          text: "assets/images/nature2.jpg",
          isMe: false,
          time: "2 days ago",
          avatar: Icons.person,
          type: MessageType.image,
        ),
        Message(
          text: "Wow! Those tillandsias are gorgeous! I'd love to trade 🤝",
          isMe: true,
          time: "Yesterday",
          avatar: Icons.person,
          type: MessageType.text,
        ),
        Message(
          text: "Great! When would be good for you to meet up?",
          isMe: false,
          time: "Yesterday",
          avatar: Icons.person,
          type: MessageType.text,
        ),
        Message(
          text: "Bedok Community Center|1.3240° N, 103.9300° E",
          isMe: true,
          time: "Yesterday",
          avatar: Icons.person,
          type: MessageType.location,
        ),
        Message(
          text: widget.chatItem.lastMessage,
          isMe: false,
          time: widget.chatItem.time,
          avatar: Icons.person,
          type: MessageType.text,
        ),
      ];
    } else {
      _messages = [
        Message(
          text: "Hello! Thanks for your interest in our plants! 🌱",
          isMe: false,
          time: "1 hour ago",
          avatar: widget.chatItem.avatar,
          type: MessageType.text,
        ),
        Message(
          text: widget.chatItem.lastMessage,
          isMe: false,
          time: widget.chatItem.time,
          avatar: widget.chatItem.avatar,
          type: MessageType.text,
        ),
      ];
    }
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add(
          Message(
            text: _messageController.text.trim(),
            isMe: true,
            time: "Now",
            avatar: Icons.person,
            type: MessageType.text,
          ),
        );
      });
      _messageController.clear();
      _scrollToBottom();
      
      // Simulate response after a delay
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _messages.add(
              Message(
                text: _getAutoResponse(),
                isMe: false,
                time: "Now",
                avatar: widget.chatItem.avatar,
                type: MessageType.text,
              ),
            );
          });
          _scrollToBottom();
        }
      });
    }
  }

  String _getAutoResponse() {
    final responses = [
      "Thanks for your message! I'll get back to you soon.",
      "That sounds great! Let me check and get back to you.",
      "I appreciate your interest. Let me think about it.",
      "Sure, I'd be happy to help with that!",
      "Let me check my schedule and get back to you.",
    ];
    return responses[DateTime.now().millisecond % responses.length];
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.arrow_back, color: Colors.black87, size: 20),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: widget.chatItem.isOfficial 
                  ? const Color(0xFF4CAF50).withAlpha(20) 
                  : Colors.grey.withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: Icon(
                widget.chatItem.avatar,
                color: widget.chatItem.isOfficial ? const Color(0xFF4CAF50) : Colors.grey,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.chatItem.name,
                    style: GoogleFonts.poppins(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Online',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF4CAF50),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.phone, color: Colors.black87, size: 20),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.more_vert, color: Colors.black87, size: 20),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages list
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message, index);
              },
            ),
          ),
          
          // Message input
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Message message, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!message.isMe) ...[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: widget.chatItem.isOfficial 
                  ? const Color(0xFF4CAF50).withAlpha(20) 
                  : Colors.grey.withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: Icon(
                message.avatar,
                color: widget.chatItem.isOfficial ? const Color(0xFF4CAF50) : Colors.grey,
                size: 18,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: _buildMessageContent(message),
          ),
          if (message.isMe) ...[
            const SizedBox(width: 8),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50).withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person,
                color: Color(0xFF4CAF50),
                size: 18,
              ),
            ),
          ],
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.1);
  }

  Widget _buildMessageContent(Message message) {
    switch (message.type) {
      case MessageType.image:
        return _buildImageMessage(message);
      case MessageType.plantCard:
        return _buildPlantCardMessage(message);
      case MessageType.location:
        return _buildLocationMessage(message);
      case MessageType.voice:
        return _buildVoiceMessage(message);
      case MessageType.text:
      default:
        return _buildTextMessage(message);
    }
  }

  Widget _buildTextMessage(Message message) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: message.isMe 
          ? const Color(0xFF4CAF50) 
          : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(16),
          topRight: const Radius.circular(16),
          bottomLeft: Radius.circular(message.isMe ? 16 : 4),
          bottomRight: Radius.circular(message.isMe ? 4 : 16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.text,
            style: GoogleFonts.poppins(
              color: message.isMe ? Colors.white : Colors.black87,
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message.time,
            style: GoogleFonts.poppins(
              color: message.isMe 
                ? Colors.white.withOpacity(0.7) 
                : Colors.grey[500],
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageMessage(Message message) {
    return Column(
      crossAxisAlignment: message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          constraints: const BoxConstraints(
            maxWidth: 250,
            maxHeight: 200,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              message.text,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          message.time,
          style: GoogleFonts.poppins(
            color: Colors.grey[500],
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildPlantCardMessage(Message message) {
    final parts = message.text.split('|');
    if (parts.length < 5) return _buildTextMessage(message);
    
    final name = parts[0];
    final category = parts[1];
    final price = parts[2];
    final rating = double.tryParse(parts[3]) ?? 0.0;
    final description = parts[4];

    return Container(
      constraints: const BoxConstraints(maxWidth: 280),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF4CAF50).withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              image: const DecorationImage(
                image: AssetImage('assets/images/nature2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  category,
                  style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      rating.toString(),
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                    const Spacer(),
                    Text(
                      price,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF4CAF50),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: Colors.grey[600],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'View Details',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  message.time,
                  style: GoogleFonts.poppins(
                    color: Colors.grey[500],
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationMessage(Message message) {
    final parts = message.text.split('|');
    if (parts.length < 2) return _buildTextMessage(message);
    
    final locationName = parts[0];
    final coordinates = parts[1];

    return Container(
      constraints: const BoxConstraints(maxWidth: 250),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              color: Colors.blue.withOpacity(0.1),
            ),
            child: Center(
              child: Icon(
                Icons.location_on,
                color: Colors.blue[600],
                size: 40,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.place, color: Colors.blue[600], size: 16),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        locationName,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  coordinates,
                  style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.blue[600],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'Open in Maps',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message.time,
                  style: GoogleFonts.poppins(
                    color: Colors.grey[500],
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoiceMessage(Message message) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 200),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: message.isMe 
          ? const Color(0xFF4CAF50) 
          : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(16),
          topRight: const Radius.circular(16),
          bottomLeft: Radius.circular(message.isMe ? 16 : 4),
          bottomRight: Radius.circular(message.isMe ? 4 : 16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.play_arrow,
                color: message.isMe ? Colors.white : const Color(0xFF4CAF50),
                size: 24,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  height: 3,
                  decoration: BoxDecoration(
                    color: (message.isMe ? Colors.white : const Color(0xFF4CAF50)).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: 0.4,
                    child: Container(
                      decoration: BoxDecoration(
                        color: message.isMe ? Colors.white : const Color(0xFF4CAF50),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '0:15',
                style: GoogleFonts.poppins(
                  color: message.isMe ? Colors.white : Colors.black87,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            message.time,
            style: GoogleFonts.poppins(
              color: message.isMe 
                ? Colors.white.withOpacity(0.7) 
                : Colors.grey[500],
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.attach_file, color: Colors.grey, size: 20),
            ),
            onPressed: () {},
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: GoogleFonts.poppins(color: Colors.grey),
                  border: InputBorder.none,
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.send, color: Colors.white, size: 20),
            ),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
} 