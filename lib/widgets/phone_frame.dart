import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PhoneFrameWrapper extends StatelessWidget {
  final Widget child;

  const PhoneFrameWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // If wider than typical phone viewport (desktop / laptop browser)
        final isDesktopOrLaptop = constraints.maxWidth > 500;

        if (!isDesktopOrLaptop) {
          // Real phone or narrow mobile viewport: full screen
          return child;
        }

        // Laptop / desktop: centered phone frame (390 x 844, rounded corners, notch)
        return Scaffold(
          backgroundColor: AppColors.desktopBackground,
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // App branding header on desktop view
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('🌿', style: TextStyle(fontSize: 18)),
                        SizedBox(width: 8),
                        Text(
                          'greenleaf',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: AppColors.primaryDarkGreen,
                            letterSpacing: -0.3,
                          ),
                        ),
                        SizedBox(width: 6),
                        Text(
                          '• iPhone View (390 × 844)',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Phone Frame Container
                  Container(
                    width: 390,
                    height: 844,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(48),
                      border: Border.all(
                        color: AppColors.phoneFrameBezel,
                        width: 10,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.22),
                          blurRadius: 40,
                          offset: const Offset(0, 18),
                        ),
                        BoxShadow(
                          color: AppColors.primaryGreen.withValues(alpha: 0.08),
                          blurRadius: 60,
                          offset: const Offset(0, 24),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Inner Phone Screen
                        ClipRRect(
                          borderRadius: BorderRadius.circular(38),
                          child: MediaQuery(
                            data: MediaQuery.of(context).copyWith(
                              size: const Size(390, 844),
                              padding: const EdgeInsets.only(
                                top: 44,
                                bottom: 34,
                              ),
                            ),
                            child: child,
                          ),
                        ),

                        // Realistic Notch / Dynamic Island at the top
                        Positioned(
                          top: 8,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              width: 124,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(width: 8),
                                  // Camera lens
                                  Container(
                                    width: 11,
                                    height: 11,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1E293B),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0xFF0F172A),
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Center(
                                      child: Container(
                                        width: 4,
                                        height: 4,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF38BDF8),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Speaker slot
                                  Container(
                                    width: 48,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF262626),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Bottom Home Indicator Bar
                        Positioned(
                          bottom: 8,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              width: 134,
                              height: 4.5,
                              decoration: BoxDecoration(
                                color: Colors.black38,
                                borderRadius: BorderRadius.circular(2.5),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
