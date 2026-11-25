import 'package:flutter/foundation.dart';

class Plant {
  final String id;
  final String name;
  final String emoji;
  final String room;
  final int waterFrequencyDays;
  final String sunlight;
  final String careTip;
  DateTime lastWatered;

  Plant({
    required this.id,
    required this.name,
    required this.emoji,
    required this.room,
    required this.waterFrequencyDays,
    required this.sunlight,
    required this.careTip,
    required this.lastWatered,
  });

  int get daysSinceWatered {
    final now = DateTime.now();
    final difference = now.difference(lastWatered).inDays;
    return difference < 0 ? 0 : difference;
  }

  int get daysUntilNextWater {
    final days = waterFrequencyDays - daysSinceWatered;
    return days;
  }

  bool get needsWaterToday {
    return daysUntilNextWater <= 0;
  }

  double get hydrationLevel {
    if (waterFrequencyDays <= 0) return 0.0;
    final remaining = daysUntilNextWater;
    if (remaining <= 0) return 0.0;
    final ratio = remaining / waterFrequencyDays;
    return ratio.clamp(0.0, 1.0);
  }

  String get statusText {
    if (daysUntilNextWater < 0) {
      final overdue = daysUntilNextWater.abs();
      return 'Overdue by $overdue ${overdue == 1 ? "day" : "days"}';
    } else if (daysUntilNextWater == 0) {
      return 'Needs water today!';
    } else if (daysUntilNextWater == 1) {
      return 'Water tomorrow';
    } else {
      return 'Water in $daysUntilNextWater days';
    }
  }

  void water() {
    lastWatered = DateTime.now();
  }
}

class PlantCareState extends ChangeNotifier {
  final List<Plant> _plants = [
    Plant(
      id: '1',
      name: 'Money Plant',
      emoji: '🪴',
      room: 'Living Room',
      waterFrequencyDays: 7,
      sunlight: 'Bright Indirect',
      careTip: 'Thrives in indirect sunlight. Likes clean leaves and occasional misting.',
      lastWatered: DateTime.now().subtract(const Duration(days: 7)),
    ),
    Plant(
      id: '2',
      name: 'Aloe Vera',
      emoji: '🌵',
      room: 'Bedroom',
      waterFrequencyDays: 14,
      sunlight: 'Direct Sunlight',
      careTip: 'Allow soil to dry out completely between waterings. Great air purifier.',
      lastWatered: DateTime.now().subtract(const Duration(days: 11)),
    ),
    Plant(
      id: '3',
      name: 'Snake Plant',
      emoji: '🌱',
      room: 'Living Room',
      waterFrequencyDays: 10,
      sunlight: 'Low to Bright',
      careTip: 'Hardy and resilient. Perfect for low-light corners and peaceful bedrooms.',
      lastWatered: DateTime.now().subtract(const Duration(days: 10)),
    ),
    Plant(
      id: '4',
      name: 'Tulsi',
      emoji: '🍃',
      room: 'Balcony',
      waterFrequencyDays: 2,
      sunlight: 'Full Sun',
      careTip: 'Holy Basil loves warm morning sun and moist, well-aerated potting soil.',
      lastWatered: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Plant(
      id: '5',
      name: 'Rose',
      emoji: '🌹',
      room: 'Balcony',
      waterFrequencyDays: 3,
      sunlight: 'Direct Sun',
      careTip: 'Water at the base to keep foliage dry. Needs 5+ hours of sunshine to bloom.',
      lastWatered: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Plant(
      id: '6',
      name: 'Mint',
      emoji: '🌿',
      room: 'Kitchen',
      waterFrequencyDays: 2,
      sunlight: 'Partial Sun',
      careTip: 'Loves constant moisture. Snip the top sprigs often for bushy, lush herbs.',
      lastWatered: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Plant(
      id: '7',
      name: 'Peace Lily',
      emoji: '🌸',
      room: 'Office',
      waterFrequencyDays: 5,
      sunlight: 'Medium Shade',
      careTip: 'Leaves gently droop when thirsty. Keep away from harsh heating vents.',
      lastWatered: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Plant(
      id: '8',
      name: 'Cactus',
      emoji: '🌵',
      room: 'Windowsill',
      waterFrequencyDays: 21,
      sunlight: 'Full Sun',
      careTip: 'Needs bright direct light. Soak thoroughly when watering, then let dry.',
      lastWatered: DateTime.now().subtract(const Duration(days: 9)),
    ),
  ];

  List<Plant> get allPlants => List.unmodifiable(_plants);

  List<Plant> get todayPlants =>
      _plants.where((plant) => plant.needsWaterToday).toList();

  List<Plant> get upcomingPlants =>
      _plants.where((plant) => !plant.needsWaterToday).toList()
        ..sort((a, b) => a.daysUntilNextWater.compareTo(b.daysUntilNextWater));

  int get totalCount => _plants.length;
  int get todayNeedWaterCount => todayPlants.length;
  int get wateredTodayCount =>
      _plants.where((p) => p.daysSinceWatered == 0).length;

  void waterPlant(String id) {
    final index = _plants.indexWhere((p) => p.id == id);
    if (index != -1) {
      _plants[index].water();
      notifyListeners();
    }
  }

  void addPlant(Plant plant) {
    _plants.insert(0, plant);
    notifyListeners();
  }

  void removePlant(String id) {
    _plants.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  List<String> get availableRooms {
    final set = {'All', ..._plants.map((p) => p.room)};
    return set.toList();
  }
}
