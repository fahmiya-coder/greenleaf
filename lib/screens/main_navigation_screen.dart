import 'package:flutter/material.dart';
import '../models/plant.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';
import 'my_plants_screen.dart';
import 'add_plant_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  final PlantCareState _state = PlantCareState();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _state,
      builder: (context, _) {
        final todayCount = _state.todayNeedWaterCount;

        final screens = [
          HomeScreen(
            state: _state,
            onNavigateToMyPlants: () {
              setState(() {
                _currentIndex = 1;
              });
            },
            onNavigateToAddPlant: () {
              setState(() {
                _currentIndex = 2;
              });
            },
          ),
          MyPlantsScreen(
            state: _state,
            onNavigateToAddPlant: () {
              setState(() {
                _currentIndex = 2;
              });
            },
          ),
          AddPlantScreen(
            state: _state,
            onPlantAdded: () {
              setState(() {
                _currentIndex = 1; // switch to My Plants to see newly added plant
              });
            },
          ),
        ];

        return Scaffold(
          body: IndexedStack(
            index: _currentIndex,
            children: screens,
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: AppColors.dividerLight, width: 1),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              backgroundColor: Colors.white,
              selectedItemColor: AppColors.primaryGreen,
              unselectedItemColor: AppColors.textMuted,
              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                  icon: Badge(
                    isLabelVisible: todayCount > 0,
                    label: Text(
                      '$todayCount',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: AppColors.brightYellowAccent,
                    textColor: AppColors.yellowDark,
                    child: const Icon(Icons.water_drop_outlined),
                  ),
                  activeIcon: Badge(
                    isLabelVisible: todayCount > 0,
                    label: Text(
                      '$todayCount',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    backgroundColor: AppColors.brightYellowAccent,
                    textColor: AppColors.yellowDark,
                    child: const Icon(Icons.water_drop_rounded),
                  ),
                  label: 'Today',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.yard_outlined),
                  activeIcon: Icon(Icons.yard_rounded),
                  label: 'My Plants',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle_outline_rounded),
                  activeIcon: Icon(Icons.add_circle_rounded),
                  label: 'Add Plant',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
