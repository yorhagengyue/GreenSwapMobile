import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'product_detail_page.dart';
import 'add_plant_page.dart';
import 'message_page.dart';
import 'profile_page.dart';

class BrowsePage extends StatefulWidget {
  const BrowsePage({super.key});

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> with TickerProviderStateMixin {
  String _selectedCategory = 'All';
  String _selectedSortBy = 'Popular';
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _pulseController;
  late AnimationController _rotateController;
  
  final List<String> _categories = ['All', 'Plants', 'Seeds', 'Tools', 'Pots', 'Fertilizers'];
  final List<String> _sortOptions = ['Popular', 'Price: Low to High', 'Price: High to Low', 'Newest', 'Rating'];
  
  final List<BrowseItem> _items = [
    BrowseItem(
      name: 'Monstera Deliciosa',
      category: 'Plants',
      price: '\$35.99',
      originalPrice: '\$45.99',
      image: 'assets/images/nature2.jpg',
      rating: 4.8,
      location: 'Tampines',
      isPopular: true,
      discount: 22,
      seller: 'PlantLover88',
      reviews: 156,
    ),
    BrowseItem(
      name: 'Snake Plant',
      category: 'Plants',
      price: '\$22.50',
      image: 'assets/images/nature2.jpg',
      rating: 4.6,
      location: 'Bedok',
      seller: 'GreenThumb',
      reviews: 89,
    ),
    BrowseItem(
      name: 'Fiddle Leaf Fig',
      category: 'Plants',
      price: '\$45.00',
      image: 'assets/images/nature2.jpg',
      rating: 4.9,
      location: 'Jurong',
      isPopular: true,
      seller: 'PlantParent',
      reviews: 203,
    ),
    BrowseItem(
      name: 'Pothos',
      category: 'Plants',
      price: '\$18.99',
      originalPrice: '\$24.99',
      image: 'assets/images/nature2.jpg',
      rating: 4.7,
      location: 'Pasir Ris',
      discount: 24,
      seller: 'EcoGarden',
      reviews: 67,
    ),
    BrowseItem(
      name: 'Rubber Plant',
      category: 'Plants',
      price: '\$28.75',
      image: 'assets/images/nature2.jpg',
      rating: 4.5,
      location: 'Enous',
      seller: 'PlantShop',
      reviews: 134,
    ),
    BrowseItem(
      name: 'Peace Lily',
      category: 'Plants',
      price: '\$24.99',
      image: 'assets/images/nature2.jpg',
      rating: 4.8,
      location: 'Paya Lebar',
      isPopular: true,
      seller: 'FlowerPower',
      reviews: 178,
    ),
    BrowseItem(
      name: 'Succulent Mix Pack',
      category: 'Plants',
      price: '\$15.99',
      originalPrice: '\$19.99',
      image: 'assets/images/nature2.jpg',
      rating: 4.4,
      location: 'Tampines',
      discount: 20,
      seller: 'SucculentWorld',
      reviews: 92,
    ),
    BrowseItem(
      name: 'Ceramic Pot Set',
      category: 'Pots',
      price: '\$32.00',
      image: 'assets/images/nature2.jpg',
      rating: 4.6,
      location: 'Orchard',
      seller: 'PotCrafters',
      reviews: 45,
    ),
  ];

  final List<TrendingItem> _trendingItems = [
    TrendingItem(
      name: 'Monstera Deliciosa',
      trend: 'Hot',
      change: '+15%',
      image: 'assets/images/nature2.jpg',
      color: Colors.red,
    ),
    TrendingItem(
      name: 'Snake Plant',
      trend: 'Rising',
      change: '+8%',
      image: 'assets/images/nature2.jpg',
      color: Colors.orange,
    ),
    TrendingItem(
      name: 'Pothos',
      trend: 'Stable',
      change: '+2%',
      image: 'assets/images/nature2.jpg',
      color: Colors.green,
    ),
  ];

  List<BrowseItem> get _filteredItems {
    List<BrowseItem> filtered = _selectedCategory == 'All' 
        ? _items 
        : _items.where((item) => item.category == _selectedCategory).toList();
    
    // Apply sorting
    switch (_selectedSortBy) {
      case 'Price: Low to High':
        filtered.sort((a, b) => double.parse(a.price.substring(1)).compareTo(double.parse(b.price.substring(1))));
        break;
      case 'Price: High to Low':
        filtered.sort((a, b) => double.parse(b.price.substring(1)).compareTo(double.parse(a.price.substring(1))));
        break;
      case 'Rating':
        filtered.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Newest':
        // Keep original order for newest
        break;
      case 'Popular':
      default:
        filtered.sort((a, b) => (b.isPopular ? 1 : 0).compareTo(a.isPopular ? 1 : 0));
        break;
    }
    
    return filtered;
  }

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    
    _rotateController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _pulseController.dispose();
    _rotateController.dispose();
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
                _buildSearchAndFilter().animate().fadeIn(duration: 600.ms).slideY(begin: -0.1),
                const SizedBox(height: 16),
                _buildTrendingSection().animate().fadeIn(duration: 600.ms, delay: 100.ms).slideX(begin: -0.1),
                const SizedBox(height: 16),
                _buildCategoryFilter().animate().fadeIn(duration: 600.ms, delay: 200.ms),
                const SizedBox(height: 16),
                _buildSortAndResults().animate().fadeIn(duration: 600.ms, delay: 300.ms),
              ],
            ),
          ),
          _buildItemsGrid(),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AnimatedBuilder(
                        animation: _rotateController,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: _rotateController.value * 2 * 3.14159,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4CAF50).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.eco,
                                color: Color(0xFF4CAF50),
                                size: 24,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Browse Plants',
                        style: GoogleFonts.poppins(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Discover amazing plants from our community',
                    style: GoogleFonts.poppins(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
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
            child: const Icon(Icons.notifications_outlined, color: Colors.black87, size: 20),
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSearchAndFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
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
                  hintText: 'Search plants, pots, tools...',
                  hintStyle: GoogleFonts.poppins(color: Colors.grey[500]),
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(12),
                    child: const Icon(Icons.search, color: Color(0xFF4CAF50), size: 20),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4CAF50).withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.tune, color: Colors.white, size: 20),
              onPressed: _showFilterDialog,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingSection() {
    return Container(
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: 1.0 + (_pulseController.value * 0.1),
                      child: const Icon(Icons.trending_up, color: Colors.orange, size: 20),
                    );
                  },
                ),
                const SizedBox(width: 8),
                Text(
                  'Trending Now',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _trendingItems.length,
              itemBuilder: (context, index) {
                final item = _trendingItems[index];
                return Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: item.color.withOpacity(0.3)),
                    boxShadow: [
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
                        item.name,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: item.color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          item.trend,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: item.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: Duration(milliseconds: index * 100)).scale(begin: const Offset(0.8, 0.8));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = category == _selectedCategory;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = category;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                gradient: isSelected ? const LinearGradient(
                  colors: [Color(0xFF4CAF50), Color(0xFF45A049)],
                ) : null,
                color: isSelected ? null : Colors.white,
                borderRadius: BorderRadius.circular(25),
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
              child: Center(
                child: Text(
                  category,
                  style: GoogleFonts.poppins(
                    color: isSelected ? Colors.white : Colors.grey[700],
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ).animate(target: isSelected ? 1 : 0)
            .scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05), duration: 200.ms);
        },
      ),
    );
  }

  Widget _buildSortAndResults() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${_filteredItems.length} plants found',
            style: GoogleFonts.poppins(
              color: Colors.grey[600],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          GestureDetector(
            onTap: _showSortDialog,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.sort, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    _selectedSortBy,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsGrid() {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final item = _filteredItems[index];
            return _buildItemCard(item, index);
          },
          childCount: _filteredItems.length,
        ),
      ),
    );
  }

  Widget _buildItemCard(BrowseItem item, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              plantName: item.name,
              plantCategory: item.category,
              plantPrice: item.price,
              plantImage: item.image,
              plantRating: item.rating,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with badges
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                      image: DecorationImage(
                        image: AssetImage(item.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Discount badge
                  if (item.discount != null)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '-${item.discount}%',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  // Popular badge
                  if (item.isPopular)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.local_fire_department, color: Colors.white, size: 10),
                            const SizedBox(width: 2),
                            Text(
                              'HOT',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  // Favorite button
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.favorite_border,
                        color: Color(0xFF4CAF50),
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Content
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 12, color: Colors.grey[600]),
                        const SizedBox(width: 2),
                        Text(
                          item.location,
                          style: GoogleFonts.poppins(
                            color: Colors.grey[600],
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(Icons.person, size: 12, color: Colors.grey[600]),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Text(
                            item.seller,
                            style: GoogleFonts.poppins(
                              color: Colors.grey[600],
                              fontSize: 10,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 12),
                        const SizedBox(width: 2),
                        Text(
                          item.rating.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${item.reviews})',
                          style: GoogleFonts.poppins(
                            fontSize: 9,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (item.originalPrice != null)
                              Text(
                                item.originalPrice!,
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: Colors.grey[500],
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            Text(
                              item.price,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: const Color(0xFF4CAF50),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF4CAF50), Color(0xFF45A049)],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF4CAF50).withOpacity(0.3),
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            'Add',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: index * 100), duration: 400.ms)
      .slideY(begin: 0.1, end: 0, delay: Duration(milliseconds: index * 100), duration: 400.ms);
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter Options',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildFilterOption('Price Range', Icons.attach_money),
              _buildFilterOption('Location', Icons.location_on),
              _buildFilterOption('Rating', Icons.star),
              _buildFilterOption('Availability', Icons.check_circle),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Reset', style: GoogleFonts.poppins()),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CAF50),
                      ),
                      child: Text('Apply', style: GoogleFonts.poppins(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterOption(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF4CAF50)),
      title: Text(title, style: GoogleFonts.poppins()),
      trailing: const Icon(Icons.keyboard_arrow_right),
      onTap: () {},
    );
  }

  void _showSortDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sort By',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ..._sortOptions.map((option) => ListTile(
                title: Text(option, style: GoogleFonts.poppins()),
                trailing: _selectedSortBy == option 
                  ? const Icon(Icons.check, color: Color(0xFF4CAF50))
                  : null,
                onTap: () {
                  setState(() {
                    _selectedSortBy = option;
                  });
                  Navigator.pop(context);
                },
              )).toList(),
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
        currentIndex: 1, // Browse tab selected
        onTap: (i) {
          if (i == 0) {
            Navigator.of(context).pop(); // Go back to Home
          } else if (i == 2) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const AddPlantPage()),
            );
          } else if (i == 3) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const MessagePage()),
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

class BrowseItem {
  final String name;
  final String category;
  final String price;
  final String? originalPrice;
  final String image;
  final double rating;
  final String location;
  final bool isPopular;
  final int? discount;
  final String seller;
  final int reviews;

  BrowseItem({
    required this.name,
    required this.category,
    required this.price,
    this.originalPrice,
    required this.image,
    required this.rating,
    required this.location,
    this.isPopular = false,
    this.discount,
    required this.seller,
    required this.reviews,
  });
}

class TrendingItem {
  final String name;
  final String trend;
  final String change;
  final String image;
  final Color color;

  TrendingItem({
    required this.name,
    required this.trend,
    required this.change,
    required this.image,
    required this.color,
  });
} 