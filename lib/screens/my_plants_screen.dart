import 'package:flutter/material.dart';
import '../models/plant.dart';
import '../theme/app_theme.dart';
import '../widgets/water_celebration_dialog.dart';
import 'plant_detail_screen.dart';

class MyPlantsScreen extends StatefulWidget {
  final PlantCareState state;
  final VoidCallback onNavigateToAddPlant;

  const MyPlantsScreen({
    super.key,
    required this.state,
    required this.onNavigateToAddPlant,
  });

  @override
  State<MyPlantsScreen> createState() => _MyPlantsScreenState();
}

class _MyPlantsScreenState extends State<MyPlantsScreen> {
  String _selectedRoom = 'All';
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final allPlants = state.allPlants;

    // Filter by room and search query
    final filteredPlants = allPlants.where((plant) {
      final matchesRoom =
          _selectedRoom == 'All' || plant.room == _selectedRoom;
      final matchesSearch = _searchQuery.isEmpty ||
          plant.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          plant.room.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesRoom && matchesSearch;
    }).toList();

    final rooms = state.availableRooms;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Screen Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'My Plants',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryDarkGreen,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Text(
                        '${allPlants.length} plants in your collection',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                  IconButton.filled(
                    onPressed: widget.onNavigateToAddPlant,
                    icon: const Icon(Icons.add, size: 20),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      foregroundColor: Colors.white,
                    ),
                    tooltip: 'Add Plant',
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    _searchQuery = val;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search plants or rooms...',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textMuted,
                  ),
                  prefixIcon: const Icon(Icons.search,
                      color: AppColors.textMuted, size: 20),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 18),
                          onPressed: () {
                            setState(() {
                              _searchQuery = '';
                            });
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.dividerLight),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.dividerLight),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                        color: AppColors.primaryGreen, width: 1.5),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Room Filter Chips
            SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: rooms.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final room = rooms[index];
                  final isSelected = _selectedRoom == room;
                  return ChoiceChip(
                    label: Text(room),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedRoom = room;
                        });
                      }
                    },
                    selectedColor: AppColors.primaryGreen,
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      fontSize: 13,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w500,
                      color: isSelected ? Colors.white : AppColors.textDark,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected
                            ? AppColors.primaryGreen
                            : AppColors.dividerLight,
                      ),
                    ),
                    showCheckmark: false,
                  );
                },
              ),
            ),
            const SizedBox(height: 12),

            // Plants Grid
            Expanded(
              child: filteredPlants.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('🔍', style: TextStyle(fontSize: 40)),
                          const SizedBox(height: 12),
                          const Text(
                            'No plants found',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Try a different search term or room filter.',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        childAspectRatio: 0.76,
                      ),
                      itemCount: filteredPlants.length,
                      itemBuilder: (context, index) {
                        final plant = filteredPlants[index];
                        return _buildGridCard(context, plant);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridCard(BuildContext context, Plant plant) {
    final needsWater = plant.needsWaterToday;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: needsWater
              ? AppColors.brightYellowAccent.withValues(alpha: 0.8)
              : AppColors.dividerLight,
          width: needsWater ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlantDetailScreen(
                  plant: plant,
                  state: widget.state,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Emoji Container & Quick Water Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: needsWater
                            ? AppColors.warmButterYellow
                            : AppColors.lightMint,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(plant.emoji,
                            style: const TextStyle(fontSize: 28)),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.water_drop_rounded,
                        size: 20,
                        color: needsWater
                            ? const Color(0xFF0284C7)
                            : AppColors.leafGreen,
                      ),
                      tooltip: 'Watered',
                      onPressed: () {
                        widget.state.waterPlant(plant.id);
                        WaterCelebrationDialog.show(context, plant);
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: needsWater
                            ? const Color(0xFFE0F2FE)
                            : AppColors.paleSage,
                        padding: const EdgeInsets.all(6),
                        minimumSize: const Size(32, 32),
                      ),
                    ),
                  ],
                ),
                const Spacer(),

                // Plant Name
                Text(
                  plant.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),

                // Room
                Text(
                  plant.room,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),

                // Frequency
                Text(
                  'Every ${plant.waterFrequencyDays} days',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 8),

                // Status Badge
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: needsWater
                        ? AppColors.warmButterYellow
                        : AppColors.paleSage,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    plant.statusText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: needsWater
                          ? AppColors.yellowDark
                          : AppColors.primaryGreen,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
