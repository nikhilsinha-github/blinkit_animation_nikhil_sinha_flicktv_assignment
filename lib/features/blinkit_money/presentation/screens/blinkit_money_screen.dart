import 'dart:math';
import 'package:flutter/material.dart';
import 'package:nikhil_sinha/core/constants/app_strings.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/animated_wallet.dart';
import '../widgets/bottom_features.dart';
import '../widgets/confetti_painter.dart';

class BlinkitMoneyScreen extends StatefulWidget {
  const BlinkitMoneyScreen({super.key});

  @override
  State<BlinkitMoneyScreen> createState() => _BlinkitMoneyScreenState();
}

class _BlinkitMoneyScreenState extends State<BlinkitMoneyScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _confettiController;
  late AnimationController _listController;

  late Animation<double> _walletScaleAnim;
  late Animation<Offset> _walletSlideAnim;
  late Animation<double> _textFadeAnim;
  late Animation<Offset> _textSlideAnim;
  late Animation<Offset> _bottomSheetSlideAnim;
  late Animation<double> _bottomSheetFadeAnim;

  final List<ConfettiParticle> particles = [];

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );
    _confettiController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );
    _listController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    _setupAnimations();
    _generateParticles();

    _mainController.forward();
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _confettiController.forward();
    });

    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted) _listController.forward();
    });
  }

  void _setupAnimations() {
    _walletScaleAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOutBack),
      ),
    );
    _walletSlideAnim =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _mainController,
            curve: const Interval(0.0, 0.4, curve: Curves.easeOutCubic),
          ),
        );

    _textFadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.3, 0.6, curve: Curves.easeIn),
      ),
    );
    _textSlideAnim =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _mainController,
            curve: const Interval(0.3, 0.6, curve: Curves.easeOutCubic),
          ),
        );

    _bottomSheetSlideAnim =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _mainController,
            curve: const Interval(0.5, 1.0, curve: Curves.easeOutCubic),
          ),
        );
    _bottomSheetFadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.5, 0.8, curve: Curves.easeIn),
      ),
    );
  }

  void _generateParticles() {
    final random = Random();
    for (int i = 0; i < 100; i++) {
      particles.add(
        ConfettiParticle(
          color: AppColors
              .confettiColors[random.nextInt(AppColors.confettiColors.length)],
          size: random.nextDouble() * 5 + 4,

          speedX: (random.nextDouble() - 0.5) * 1500,

          speedY: -(random.nextDouble() * 1500 + 1000),

          rotationSpeed: (random.nextDouble() - 0.5) * 20,
        ),
      );
    }
  }

  @override
  void dispose() {
    _mainController.dispose();
    _confettiController.dispose();
    _listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topCenter,
                radius: 1.5,
                colors: [AppColors.backgroundTop, AppColors.backgroundBottom],
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _confettiController,
            builder: (context, child) {
              return CustomPaint(
                size: Size.infinite,
                painter: ConfettiPainter(
                  progress: _confettiController.value,
                  particles: particles,
                ),
              );
            },
          ),
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 2),
                SlideTransition(
                  position: _walletSlideAnim,
                  child: ScaleTransition(
                    scale: _walletScaleAnim,
                    child: const AnimatedWallet(),
                  ),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: _textSlideAnim,
                  child: FadeTransition(
                    opacity: _textFadeAnim,
                    child: Column(
                      children: [
                        Text(
                          AppStrings.kAppName,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        const Text(
                          AppStrings.featureName,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(flex: 2),
                SlideTransition(
                  position: _bottomSheetSlideAnim,
                  child: FadeTransition(
                    opacity: _bottomSheetFadeAnim,
                    child: BottomFeatures(listController: _listController),
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
