import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedPlantCard extends StatefulWidget {
  final String? imagePath;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final double height;
  final double width;
  final double borderRadius;
  final bool isNew;

  const AnimatedPlantCard({
    super.key,
    this.imagePath,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.height = 200,
    this.width = double.infinity,
    this.borderRadius = 20,
    this.isNew = false,
  });

  @override
  State<AnimatedPlantCard> createState() => _AnimatedPlantCardState();
}

class _AnimatedPlantCardState extends State<AnimatedPlantCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: widget.height,
          width: widget.width,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(38),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background image with parallax effect
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                top: _isHovered ? -10 : 0,
                bottom: _isHovered ? 0 : -10, 
                left: _isHovered ? -10 : 0,
                right: _isHovered ? 0 : -10,
                child: widget.imagePath != null
                  ? Image.asset(
                      widget.imagePath!,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: Colors.green.shade200,
                      child: Icon(
                        Icons.spa,
                        size: 60,
                        color: Colors.green.shade800,
                      ),
                    ),
              ),
              
              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withAlpha(77),
                      Colors.black.withAlpha(51),
                    ],
                  ),
                ),
              ),
              
              // Content
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.isNew)
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Text(
                            'NEW',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ).animate(
                          onPlay: (controller) => controller.repeat(reverse: true),
                        ).shimmer(
                          duration: 2000.ms,
                          color: Colors.white.withAlpha(38),
                        ),
                      ),
                    const Spacer(),
                    Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.subtitle,
                      style: TextStyle(
                        color: Colors.white.withAlpha(204),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
      .animate(target: _isHovered ? 1 : 0)
      .scale(
        begin: const Offset(1, 1),
        end: const Offset(1.05, 1.05),
        duration: 300.ms,
        curve: Curves.easeOutCubic,
      )
      .elevation(
        begin: 5, 
        end: 15,
        duration: 300.ms,
        curve: Curves.easeOut,
      ),
    );
  }
} 