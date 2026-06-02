import 'package:flutter/material.dart';
import 'package:nikhil_sinha/core/constants/app_strings.dart';
import 'package:nikhil_sinha/features/blinkit_money/presentation/widgets/feature_tile.dart';

class BottomFeatures extends StatelessWidget {
  final AnimationController listController;

  const BottomFeatures({super.key, required this.listController});

  Widget _buildStaggeredItem(Widget child, int index) {
    final double startTimeInMs = index * 500.0;
    final double start = startTimeInMs / 2500.0;

    final double fadeEnd = (startTimeInMs + 10.0) / 2500.0;

    final double slideDurationInMs = 300.0;
    final end = ((startTimeInMs + slideDurationInMs) / 2500.0).clamp(0.0, 1.0);

    final slideAnim =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: listController,
            curve: Interval(start, end, curve: Curves.easeOutBack),
          ),
        );

    final fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: listController,
        curve: Interval(start, fadeEnd.clamp(0.0, 1.0), curve: Curves.linear),
      ),
    );

    return SlideTransition(
      position: slideAnim,
      child: FadeTransition(opacity: fadeAnim, child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          _buildStaggeredItem(
            const FeatureTile(
              icon: Icons.touch_app_rounded,
              title: AppStrings.singleTapPaymentTitle,
              subtitle: AppStrings.singleTapPaymentDescription,
            ),
            0,
          ),
          const SizedBox(height: 12),
          _buildStaggeredItem(
            const FeatureTile(
              icon: Icons.phonelink_erase_rounded,
              title: AppStrings.zeroFailuresTitle,
              subtitle: AppStrings.zeroFailuesDescription,
            ),
            1,
          ),
          const SizedBox(height: 12),
          _buildStaggeredItem(
            const FeatureTile(
              icon: Icons.currency_rupee_rounded,
              title: AppStrings.realTimeRefundsTitle,
              subtitle: AppStrings.realTimeRefundsDescription,
            ),
            2,
          ),
          const SizedBox(height: 24),
          _buildStaggeredItem(
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E8234),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  AppStrings.addMoney,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            3,
          ),
          const SizedBox(height: 16),
          _buildStaggeredItem(
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white10),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(
                      Icons.card_giftcard,
                      color: Colors.orange,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.claimGiftCard,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          AppStrings.claimGiftCardDescription,
                          style: TextStyle(fontSize: 12, color: Colors.white54),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Colors.white54,
                  ),
                ],
              ),
            ),
            4,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
