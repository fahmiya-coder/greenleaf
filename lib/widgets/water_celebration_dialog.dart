import 'dart:math';
import 'package:flutter/material.dart';
import '../models/plant.dart';
import '../theme/app_theme.dart';

class WaterCelebrationDialog extends StatelessWidget {
  final Plant plant;

  const WaterCelebrationDialog({super.key, required this.plant});

  static void show(BuildContext context, Plant plant) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'WateredCelebration',
      barrierColor: Colors.black.withValues(alpha: 0.45),
      transitionDuration: const Duration(milliseconds: 320),
      pageBuilder: (context, anim1, anim2) {
        return WaterCelebrationDialog(plant: plant);
      },
      transitionBuilder: (context, anim1, anim2, child) {
        final curvedValue = Curves.easeOutBack.transform(anim1.value);
        return Transform.scale(
          scale: curvedValue,
          child: Opacity(
            opacity: anim1.value.clamp(0.0, 1.0),
            child: child,
          ),
        );
      },
    );
  }

  static final List<String> _happyQuotes = [
    '“Gulp gulp! That was refreshing! Thank you, best plant parent! 💚”',
    '“Ahhh, pure hydration! My leaves are perking up and smiling! 🌿✨”',
    '“Photosynthesis power activated! Ready to grow lush and green! ☀️🌱”',
    '“My roots are doing a happy dance right now! 💃💧”',
    '“You remembered! I feel loved and well cared for today! 🌸💛”',
  ];

  @override
  Widget build(BuildContext context) {
    final randomQuote =
        _happyQuotes[Random().nextInt(_happyQuotes.length)];

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Container(
        padding: const EdgeInsets.all(26),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: AppColors.lightMint, width: 2),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryGreen.withValues(alpha: 0.18),
              blurRadius: 30,
              offset: const Offset(0, 14),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Joyful Plant Emoji with Water Drop Badge
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 96,
                  height: 96,
                  decoration: const BoxDecoration(
                    color: AppColors.softYellow,
                    shape: BoxShape.circle,
                  ),
                ),
                Text(
                  plant.emoji,
                  style: const TextStyle(fontSize: 48),
                ),
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF38BDF8),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withValues(alpha: 0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Text('💧', style: TextStyle(fontSize: 14)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // Headline
            Text(
              'Yay! ${plant.name} is Happy!',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDarkGreen,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 10),

            // Soft Yellow Quote Container
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.warmButterYellow,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.brightYellowAccent.withValues(alpha: 0.4),
                ),
              ),
              child: Text(
                randomQuote,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF78350F),
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Next Due Schedule pill
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.paleSage,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.calendar_today_rounded,
                    size: 15,
                    color: AppColors.primaryGreen,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Next watering in ${plant.waterFrequencyDays} days',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryGreen,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),

            // Action Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Keep Growing',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(width: 6),
                    Text('🌿', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
