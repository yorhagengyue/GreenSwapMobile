import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/custom_button.dart';

class ProductDetailPage extends StatefulWidget {
  final String? plantName;
  final String? plantCategory;
  final String? plantPrice;
  final String? plantImage;
  final double? plantRating;

  const ProductDetailPage({
    super.key,
    this.plantName,
    this.plantCategory,
    this.plantPrice,
    this.plantImage,
    this.plantRating,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _selectedImageIndex = 0;
  
  final List<String> _productImages = [
    'assets/images/jacket_white.jpg',
    'assets/images/jacket_blue.jpg',
    'assets/images/jacket_black.jpg',
  ];

  final List<RelatedProduct> _relatedProducts = [
    RelatedProduct(
      name: "Men's Sports Suit for Running and Gym...",
      price: "\$25",
      image: 'assets/images/sports_suit_orange.jpg',
    ),
    RelatedProduct(
      name: "Men's Sports Suit for Running and Gym...",
      price: "\$25",
      image: 'assets/images/sports_suit_navy.jpg',
    ),
    RelatedProduct(
      name: "Men's Sports Suit for Running and Gym...",
      price: "\$25",
      image: 'assets/images/sports_suit_purple.jpg',
    ),
    RelatedProduct(
      name: "Men's Sports Suit for Running and Gym...",
      price: "\$25",
      image: 'assets/images/sports_suit_white.jpg',
    ),
    RelatedProduct(
      name: "Men's Sports Suit for Running and Gym...",
      price: "\$25",
      image: 'assets/images/sports_suit_green.jpg',
    ),
    RelatedProduct(
      name: "Men's Sports Suit for Running and Gym...",
      price: "\$25",
      image: 'assets/images/sports_suit_black.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product images
            Container(
              height: 300,
              child: Stack(
                children: [
                  PageView.builder(
                    itemCount: _productImages.length,
                    onPageChanged: (index) {
                      setState(() {
                        _selectedImageIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[100],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            widget.plantImage ?? 'assets/images/nature2.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            
            // Image indicators
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  ..._productImages.asMap().entries.map((entry) {
                    final index = entry.key;
                    return Container(
                      width: 60,
                      height: 60,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _selectedImageIndex == index 
                            ? const Color(0xFF4CAF50) 
                            : Colors.grey[300]!,
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.asset(
                          widget.plantImage ?? 'assets/images/nature2.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            
            // Price and swap info
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    '${widget.plantPrice ?? '\$45'} Or Swap',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF4CAF50),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Hot Offer',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Swap/Buy button
            Container(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check, color: Colors.white, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      'Swap/Buy',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Propose Swap with 50 credit+',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Product title
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.plantName ?? "Men's athletic tracksuit for hiking",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            // Stats
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                '5 swap requests · 120 favorites',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ),
            
            // Tags
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildTag('Fast Response', const Color(0xFF4CAF50)),
                  const SizedBox(width: 8),
                  _buildTag('Good Condition', const Color(0xFF4CAF50)),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Reviews section
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Comment (50+)',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildReview(
                    'Johnthon',
                    'The swap went flawlessly—the jacket matched the description perfectly and was carefully packaged. The seller responded within minutes and arranged our meetup efficiently. Highly recommended!',
                  ),
                  const SizedBox(height: 16),
                  _buildReview(
                    'Aaron Sim',
                    'Nice seller',
                  ),
                ],
              ),
            ),
            
            // Related recommendations
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Related Recommendations',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: _relatedProducts.length,
                    itemBuilder: (context, index) {
                      final product = _relatedProducts[index];
                      return _buildRelatedProduct(product);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
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
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.chat, color: Colors.grey),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.favorite_border, color: Colors.grey),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.grey),
              onPressed: () {},
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomButton(
                text: 'Buy/Swap',
                onPressed: () {},
                color: const Color(0xFF4CAF50),
                textColor: Colors.white,
                height: 48,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildReview(String name, String comment) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[300],
          ),
          child: const Icon(Icons.person, color: Colors.grey),
        ),
        const SizedBox(width: 12),
        Expanded(
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
                comment,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRelatedProduct(RelatedProduct product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[100],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/nature2.jpg', // Using placeholder image
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          product.name,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          product.price,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF4CAF50),
          ),
        ),
      ],
    );
  }
}

class RelatedProduct {
  final String name;
  final String price;
  final String image;

  RelatedProduct({
    required this.name,
    required this.price,
    required this.image,
  });
} 