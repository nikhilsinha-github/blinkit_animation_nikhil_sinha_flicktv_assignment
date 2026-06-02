import 'package:flutter/material.dart';
import 'package:nikhil_sinha/core/constants/app_strings.dart';

class AnimatedWallet extends StatelessWidget {
  const AnimatedWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.15,
      child: Container(
        width: 100,
        height: 80,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFA5D610), Color(0xFF7CB305)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFA5D610).withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Center(
          child: const Text(
            AppStrings.rupee,
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
