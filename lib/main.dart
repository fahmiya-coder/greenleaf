import 'package:flutter/material.dart';
import 'screens/main_navigation_screen.dart';
import 'theme/app_theme.dart';
import 'widgets/phone_frame.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const GreenleafApp());
}

class GreenleafApp extends StatelessWidget {
  const GreenleafApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'greenleaf',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const PhoneFrameWrapper(
        child: MainNavigationScreen(),
      ),
    );
  }
}
