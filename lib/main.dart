import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import 'animations/leaf_animation.dart';
import 'components/speech_bubble.dart';
import 'components/custom_button.dart';
import 'components/custom_text_field.dart';
import 'components/social_media_buttons.dart';
import 'components/verification_progress.dart';
import 'components/gradient_overlay.dart';
import 'screens/home_page.dart';
import 'screens/onboarding_page.dart';
import 'screens/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GreenSwap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4CAF50),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4CAF50),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      ),
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _hasSeenOnboarding = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    
    _animationController.forward();
    
    // Check if user has seen onboarding
    _checkOnboardingStatus();
    
    // Navigate to appropriate screen after splash delay
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (_hasSeenOnboarding) {
        _navigateToLogin();
      } else {
        _navigateToOnboarding();
      }
    });
  }
  
  Future<void> _checkOnboardingStatus() async {
    // This would typically check shared preferences
    // For demo purposes, we'll assume user hasn't seen onboarding
    setState(() {
      _hasSeenOnboarding = false;
    });
  }
  
  void _navigateToOnboarding() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => OnboardingPage(
          onComplete: () {
            // Set flag that user has seen onboarding
            // For a real app, you'd store this in SharedPreferences
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const LoginEmailPage(),
              ),
            );
          },
        ),
      ),
    );
  }
  
  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginEmailPage(),
      ),
    );
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo animation
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1.0 + (_animationController.value * 0.2),
                  child: Opacity(
                    opacity: _animationController.value,
                    child: const Icon(
                      Icons.eco,
                      size: 100,
                      color: Color(0xFF388E3C),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            // App name animation
            Animate(
              effects: [
                FadeEffect(
                  delay: 500.ms,
                  duration: 1000.ms,
                ),
                SlideEffect(
                  begin: const Offset(0, 0.5),
                  end: Offset.zero,
                  delay: 500.ms,
                  duration: 1000.ms,
                  curve: Curves.easeOutCubic,
                ),
              ],
              child: const Text(
                'GreenSwap',
                style: TextStyle(
                  color: Color(0xFF388E3C),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Tagline animation
            Animate(
              effects: [
                FadeEffect(
                  delay: 800.ms,
                  duration: 1000.ms,
                ),
              ],
              child: const Text(
                'Keep rivers clean, love our earth',
                style: TextStyle(
                  color: Color(0xFF4CAF50),
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();
  bool _isChecked = false;
  late AnimationController _animationController;
  bool _isLoading = false;
  VerificationStep _verificationStep = VerificationStep.phoneInput;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    
    _animationController.forward();
  }
  
  @override
  void dispose() {
    _phoneController.dispose();
    _smsController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    setState(() => _isLoading = true);
    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
        _verificationStep = VerificationStep.codeVerification;
      });
      
      // For demo purposes, navigate to home page if at final verification step
      if (_verificationStep == VerificationStep.complete) {
        _handleGuestLogin();
      }
    });
  }

  void _handleGuestLogin() {
    // Navigate to home screen as guest
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background 
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFF212121),
            child: Stack(
              children: [
                // Animated background grid
                GridView.builder(
                  itemCount: 150,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 15,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: index % 3 == 0 ? Colors.green.withAlpha(50) : Colors.transparent,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ).animate(
                      onPlay: (controller) => controller.repeat(reverse: true),
                      delay: Duration(milliseconds: index * 20 % 1000),
                    ).fadeIn(
                      duration: 400.ms,
                    ).then().fadeOut(
                      delay: 3000.ms,
                      duration: 600.ms,
                    ).then().fadeIn(
                      duration: 600.ms,
                    );
                  },
                ),
                
                // Subtle gradient overlay
                GradientOverlay.greenTheme(
                  opacity: 0.05,
                ),
              ],
            ),
          ),
          
          // Close button in top right
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () {},
            ).animate()
              .fade(duration: 400.ms, delay: 200.ms)
              .scale(begin: const Offset(0.5, 0.5), duration: 400.ms),
          ),
          
          // Back button in top left
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 25),
              onPressed: () {},
            ).animate()
              .fade(duration: 400.ms, delay: 200.ms)
              .scale(begin: const Offset(0.5, 0.5), duration: 400.ms),
          ),
          
          // Main content
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                
                // Animated Header Text
                Animate(
                  effects: [
                    FadeEffect(
                      duration: 600.ms, 
                      delay: 300.ms,
                      curve: Curves.easeOut
                    ),
                    SlideEffect(
                      begin: const Offset(-0.1, 0), 
                      end: Offset.zero,
                      duration: 600.ms, 
                      delay: 300.ms,
                      curve: Curves.easeOut
                    ),
                  ],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hello,',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          const Text(
                            'Let\'s ',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Shimmer.fromColors(
                            baseColor: const Color(0xFF4CAF50),
                            highlightColor: Colors.white,
                            period: const Duration(seconds: 3),
                            child: const Text(
                              'Green',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4CAF50),
                              ),
                            ),
                          ),
                          const Text(
                            'Swap!',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 15),
                
                // Add verification progress tracker after the header text
                Animate(
                  effects: [
                    FadeEffect(duration: 600.ms, delay: 800.ms),
                    SlideEffect(
                      begin: const Offset(0, 0.1), 
                      end: Offset.zero,
                      duration: 600.ms, 
                      delay: 800.ms
                    ),
                  ],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: VerificationProgress(
                      currentStep: _verificationStep,
                      showLabels: true,
                    ),
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Main content area
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Leaf with Hello bubble
                        Animate(
                          effects: [
                            FadeEffect(duration: 800.ms, delay: 600.ms),
                            SlideEffect(
                              begin: const Offset(0.5, 0.5),
                              end: const Offset(1.0, 1.0),
                              duration: 600.ms,
                              delay: 600.ms,
                              curve: Curves.elasticOut,
                            ),
                          ],
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              // Speech bubble
                              Positioned(
                                right: 120,
                                child: SpeechBubble(
                                  text: 'Hello!',
                                  fontSize: 24,
                                  wave: true,
                                ),
                              ),
                              
                              // Green leaf character with animation
                              Align(
                                alignment: Alignment.centerRight,
                                child: LeafAnimation(
                                  size: 100,
                                  color: const Color(0xFF4CAF50),
                                  icon: Icons.spa,
                                  iconSize: 50,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 40),
                        
                        // Phone field
                        Animate(
                          effects: [
                            FadeEffect(duration: 400.ms, delay: 900.ms),
                            SlideEffect(
                              begin: const Offset(0, 0.1), 
                              end: Offset.zero,
                              duration: 500.ms, 
                              delay: 900.ms
                            ),
                          ],
                          child: CustomTextField(
                            controller: _phoneController,
                            hintText: 'Please enter your phone number',
                            prefixIcon: const Icon(Icons.phone, color: Colors.grey),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          ),
                        ),
                        
                        const SizedBox(height: 15),
                        
                        // SMS verification field
                        Animate(
                          effects: [
                            FadeEffect(duration: 400.ms, delay: 1000.ms),
                            SlideEffect(
                              begin: const Offset(0, 0.1), 
                              end: Offset.zero,
                              duration: 500.ms, 
                              delay: 1000.ms
                            ),
                          ],
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: CustomTextField(
                                  controller: _smsController,
                                  hintText: 'SMS verification code',
                                  prefixIcon: const Icon(Icons.message, color: Colors.grey),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 2,
                                child: CustomButton(
                                  text: 'Get code',
                                  type: ButtonType.secondary,
                                  fontSize: 14,
                                  height: 50,
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 30),
                        
                        // Register button
                        Animate(
                          effects: [
                            FadeEffect(duration: 400.ms, delay: 1100.ms),
                            SlideEffect(
                              begin: const Offset(0, 0.1),
                              end: Offset.zero,
                              duration: 500.ms,
                              delay: 1100.ms
                            ),
                          ],
                          child: CustomButton(
                            text: 'Register',
                            onPressed: _handleRegister,
                            elevation: 5,
                            loading: _isLoading,
                          ),
                        ),
                        
                        const SizedBox(height: 15),
                        
                                                  // Continue as guest button                          Animate(                            effects: [                              FadeEffect(duration: 400.ms, delay: 1200.ms),                              SlideEffect(                                begin: const Offset(0, 0.1),                                end: Offset.zero,                                duration: 500.ms,                                delay: 1200.ms                              ),                            ],                            child: CustomButton(                              text: 'Continue as guest',                              onPressed: _handleGuestLogin,                              elevation: 3,                            ),                          ),
                        
                        const SizedBox(height: 20),
                        
                        // Login with account text and Forgot password
                        Animate(
                          effects: [
                            FadeEffect(duration: 400.ms, delay: 1300.ms),
                          ],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Login with account and password',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: const Text(
                                  'Forget password?',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 25),
                        
                        // Google sign in button
                        Animate(
                          effects: [
                            FadeEffect(duration: 400.ms, delay: 1400.ms),
                          ],
                          child: SocialMediaButtons(
                            showLabels: true,
                            size: 54,
                            spacing: 20,
                          ),
                        ),
                        
                        const SizedBox(height: 25),
                        
                        // Terms and conditions checkbox
                        Animate(
                          effects: [
                            FadeEffect(duration: 400.ms, delay: 1500.ms),
                          ],
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: Checkbox(
                                  value: _isChecked,
                                  shape: const CircleBorder(),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _isChecked = value!;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Expanded(
                                child: Text(
                                  'I have read and agree to the Youxia Ke "User Service Agreement" and "Privacy Policy"',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
