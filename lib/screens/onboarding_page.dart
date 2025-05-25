import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;
import '../components/custom_button.dart';

class OnboardingPage extends StatefulWidget {
  final VoidCallback onComplete;

  const OnboardingPage({
    super.key,
    required this.onComplete,
  });

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late AnimationController _floatingController;
  late AnimationController _particleController;
  late AnimationController _pulseController;
  
  final List<OnboardingScreenData> _pages = [
    OnboardingScreenData(
      title: 'Welcome to GreenSwap',
      description: 'Connect with plant enthusiasts, swap plants and contribute to a greener planet.',
      image: 'assets/images/onboarding/onboarding1.jpg',
      backgroundColor: const Color(0xFF1B5E20),
      accentColor: const Color(0xFF4CAF50),
      isDark: true,
      icon: Icons.eco,
      features: ['Connect with plant lovers', 'Share growing tips', 'Build green community'],
    ),
    OnboardingScreenData(
      title: 'Discover Plants',
      description: 'Browse through thousands of plants shared by the community and find your next green companion.',
      image: 'assets/images/onboarding/onboarding2.jpg',
      backgroundColor: const Color(0xFF2E7D32),
      accentColor: const Color(0xFF66BB6A),
      isDark: true,
      icon: Icons.search,
      features: ['Thousands of plants', 'Detailed plant info', 'Care instructions'],
    ),
    OnboardingScreenData(
      title: 'Swap & Share',
      description: 'Exchange plants with enthusiasts nearby or share growing tips with the global community.',
      image: 'assets/images/onboarding/onboarding3.jpg',
      backgroundColor: const Color(0xFF388E3C),
      accentColor: const Color(0xFF81C784),
      isDark: true,
      icon: Icons.swap_horiz,
      features: ['Local exchanges', 'Safe transactions', 'Global community'],
    ),
    OnboardingScreenData(
      title: 'Start Your Journey',
      description: 'Join us today and be part of a movement that makes the world greener one plant at a time.',
      image: 'assets/images/onboarding/onboarding4.jpg',
      backgroundColor: const Color(0xFFE8F5E9),
      accentColor: const Color(0xFF4CAF50),
      isDark: false,
      icon: Icons.rocket_launch,
      features: ['Start immediately', 'No hidden fees', 'Join 10k+ users'],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    
    _particleController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
    
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _floatingController.dispose();
    _particleController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      widget.onComplete();
    }
  }

  void _goToPrevPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated background particles
          _buildParticleBackground(),
          
          // Main page content
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              final page = _pages[index];
              return _buildEnhancedPage(page, index);
            },
          ),
          
          // Top navigation
          _buildTopNavigation(),
          
          // Bottom navigation
          _buildBottomNavigation(),
        ],
      ),
    );
  }

  Widget _buildParticleBackground() {
    return AnimatedBuilder(
      animation: _particleController,
      builder: (context, child) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            painter: ParticlePainter(_particleController.value, _pages[_currentPage].backgroundColor),
          ),
        );
      },
    );
  }

  Widget _buildTopNavigation() {
    return Positioned(
      top: 50,
      left: 20,
      right: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo with animation
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Transform.scale(
                scale: 1.0 + (_pulseController.value * 0.1),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.eco,
                        color: _currentPage == _pages.length - 1 ? const Color(0xFF4CAF50) : Colors.white,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'GreenSwap',
                        style: TextStyle(
                          color: _currentPage == _pages.length - 1 ? Colors.black87 : Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          
          // Skip button with modern design
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: TextButton(
              onPressed: widget.onComplete,
              child: Text(
                'Skip',
                style: TextStyle(
                  color: _currentPage == _pages.length - 1 ? Colors.black54 : Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Positioned(
      bottom: 50,
      left: 20,
      right: 20,
      child: Column(
        children: [
          // Enhanced page indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _pages.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: _currentPage == index ? 32 : 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: _currentPage == index
                      ? _pages[_currentPage].accentColor
                      : Colors.white.withOpacity(0.4),
                  boxShadow: _currentPage == index ? [
                    BoxShadow(
                      color: _pages[_currentPage].accentColor.withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ] : null,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          
          // Navigation buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Previous button
              if (_currentPage > 0)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: _currentPage == _pages.length - 1 ? Colors.black26 : Colors.white.withOpacity(0.5),
                    ),
                  ),
                  child: CustomButton(
                    text: 'Previous',
                    type: ButtonType.outlined,
                    textColor: _currentPage == _pages.length - 1 ? Colors.black54 : Colors.white,
                    onPressed: _goToPrevPage,
                    width: 120,
                    fullWidth: false,
                    height: 50,
                  ),
                )
              else
                const SizedBox(width: 120),
              
              // Next/Get Started button with enhanced design
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(
                    colors: [
                      _pages[_currentPage].accentColor,
                      _pages[_currentPage].accentColor.withOpacity(0.8),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _pages[_currentPage].accentColor.withOpacity(0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: CustomButton(
                  text: _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                  onPressed: _goToNextPage,
                  color: Colors.transparent,
                  textColor: _currentPage == _pages.length - 1 ? Colors.white : Colors.black87,
                  width: 160,
                  fullWidth: false,
                  height: 50,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedPage(OnboardingScreenData page, int index) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            page.backgroundColor,
            page.backgroundColor.withOpacity(0.8),
            page.accentColor.withOpacity(0.3),
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 120),
              
              // Floating icon with animation
              AnimatedBuilder(
                animation: _floatingController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, math.sin(_floatingController.value * 2 * math.pi) * 10),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            page.accentColor,
                            page.accentColor.withOpacity(0.7),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: page.accentColor.withOpacity(0.4),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Icon(
                        page.icon,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ).animate().scale(delay: Duration(milliseconds: index * 200)),
              
              const SizedBox(height: 40),
              
              // Enhanced image with overlay
              Container(
                height: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        page.image,
                        height: 280,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            page.backgroundColor.withOpacity(0.3),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 800.ms, curve: Curves.easeOut),

              const SizedBox(height: 40),

              // Enhanced content
              Animate(
                effects: [
                  FadeEffect(duration: 600.ms, delay: Duration(milliseconds: 200 + index * 100)),
                  SlideEffect(
                    begin: const Offset(0, 0.3),
                    end: Offset.zero,
                    duration: 600.ms,
                    delay: Duration(milliseconds: 200 + index * 100),
                  ),
                ],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      page.title,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: page.isDark 
                          ? const Color(0xE6FFFFFF)
                          : Colors.black87,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      page.description,
                      style: TextStyle(
                        fontSize: 18,
                        color: page.isDark 
                          ? const Color(0xB3FFFFFF)
                          : Colors.black54,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    
                    // Feature list with icons
                    ...page.features.asMap().entries.map((entry) {
                      final featureIndex = entry.key;
                      final feature = entry.value;
                      return Animate(
                        effects: [
                          FadeEffect(
                            duration: 400.ms,
                            delay: Duration(milliseconds: 400 + featureIndex * 100),
                          ),
                          SlideEffect(
                            begin: const Offset(-0.2, 0),
                            duration: 400.ms,
                            delay: Duration(milliseconds: 400 + featureIndex * 100),
                          ),
                        ],
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: page.accentColor,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                feature,
                                style: TextStyle(
                                  color: page.isDark ? Colors.white : Colors.black87,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingScreenData {
  final String title;
  final String description;
  final String image;
  final Color backgroundColor;
  final Color accentColor;
  final bool isDark;
  final IconData icon;
  final List<String> features;
  
  const OnboardingScreenData({
    required this.title,
    required this.description,
    required this.image,
    required this.backgroundColor,
    required this.accentColor,
    required this.isDark,
    required this.icon,
    required this.features,
  });
}

class ParticlePainter extends CustomPainter {
  final double animationValue;
  final Color backgroundColor;
  
  ParticlePainter(this.animationValue, this.backgroundColor);
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;
    
    // Draw floating particles
    for (int i = 0; i < 20; i++) {
      final x = (size.width / 20) * i + math.sin(animationValue * 2 * math.pi + i) * 30;
      final y = (size.height / 10) * (i % 10) + math.cos(animationValue * 2 * math.pi + i) * 20;
      final radius = 2 + math.sin(animationValue * 4 * math.pi + i) * 2;
      
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
    
    // Draw connecting lines
    paint.strokeWidth = 1;
    paint.style = PaintingStyle.stroke;
    paint.color = Colors.white.withOpacity(0.05);
    
    for (int i = 0; i < 10; i++) {
      final startX = math.sin(animationValue * 2 * math.pi + i) * size.width;
      final startY = i * (size.height / 10);
      final endX = math.cos(animationValue * 2 * math.pi + i) * size.width;
      final endY = (i + 1) * (size.height / 10);
      
      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
} 