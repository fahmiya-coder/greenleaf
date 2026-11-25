import 'package:flutter/material.dart';
import '../models/plant.dart';
import '../theme/app_theme.dart';
import '../widgets/water_celebration_dialog.dart';
import 'plant_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  final PlantCareState state;
  final VoidCallback onNavigateToMyPlants;
  final VoidCallback onNavigateToAddPlant;

  const HomeScreen({
    super.key,
    required this.state,
    required this.onNavigateToMyPlants,
    required this.onNavigateToAddPlant,
  });

  @override
  Widget build(BuildContext context) {
    final todayList = state.todayPlants;
    final upcomingList = state.upcomingPlants;
    final totalToday = todayList.length + state.wateredTodayCount;
    final progress = totalToday > 0 ? (state.wateredTodayCount / totalToday) : 1.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Custom App Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.lightMint,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text('🌿',
                                    style: TextStyle(fontSize: 20)),
                              ),
                              const SizedBox(width: 10),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'greenleaf',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryDarkGreen,
                                        letterSpacing: -0.5,
                                      ),
                                    ),
                                    Text(
                                      'Plant Care Companion',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textMuted,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Quick Add Button
                        IconButton.filled(
                          onPressed: onNavigateToAddPlant,
                          icon: const Icon(Icons.add, size: 20),
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.primaryGreen,
                            foregroundColor: Colors.white,
                          ),
                          tooltip: 'Add Plant',
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Today's Routine Banner Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.warmButterYellow,
                            AppColors.lightMint,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: AppColors.brightYellowAccent.withValues(alpha: 0.4),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryGreen.withValues(alpha: 0.06),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Today's Hydration",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF78350F),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      todayList.isEmpty
                                          ? 'All plants are happy! 💧'
                                          : '${todayList.length} ${todayList.length == 1 ? "plant needs" : "plants need"} water',
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryDarkGreen,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                width: 48,
                                height: 48,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    todayList.isEmpty ? '✨' : '💧',
                                    style: const TextStyle(fontSize: 22),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              value: progress,
                              minHeight: 8,
                              backgroundColor: Colors.white.withValues(alpha: 0.6),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                AppColors.primaryGreen,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            todayList.isEmpty
                                ? '100% completed today • You are doing great!'
                                : '${state.wateredTodayCount} of $totalToday completed today',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),

                    // Section Title
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "Today's Plants to Water",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryDarkGreen,
                              letterSpacing: -0.3,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (todayList.isNotEmpty) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.warmButterYellow,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${todayList.length} Due',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.yellowDark,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Today's Plants List or All Caught Up Empty State
            if (todayList.isEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: AppColors.dividerLight),
                    ),
                    child: Column(
                      children: [
                        const Text('🎉', style: TextStyle(fontSize: 44)),
                        const SizedBox(height: 12),
                        const Text(
                          'All Caught Up!',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryDarkGreen,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Every plant baby has been hydrated today. Relax and enjoy the green vibes!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textMuted,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 16),
                        OutlinedButton(
                          onPressed: onNavigateToMyPlants,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primaryGreen,
                            side: const BorderSide(
                                color: AppColors.primaryGreen),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text('View All My Plants'),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final plant = todayList[index];
                      return _buildPlantCard(context, plant);
                    },
                    childCount: todayList.length,
                  ),
                ),
              ),

            // Upcoming Care Section
            if (upcomingList.isNotEmpty) ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 22, 20, 10),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Upcoming Watering',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryDarkGreen,
                            letterSpacing: -0.3,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      TextButton(
                        onPressed: onNavigateToMyPlants,
                        child: const Text(
                          'See All',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final plant = upcomingList[index];
                      return _buildUpcomingCard(context, plant);
                    },
                    childCount: upcomingList.length > 3 ? 3 : upcomingList.length,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPlantCard(BuildContext context, Plant plant) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.dividerLight),
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
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlantDetailScreen(
                  plant: plant,
                  state: state,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Emoji Icon Container
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.softYellow,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(plant.emoji, style: const TextStyle(fontSize: 26)),
                  ),
                ),
                const SizedBox(width: 12),

                // Plant Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      const SizedBox(height: 3),
                      Wrap(
                        spacing: 4,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Icon(Icons.meeting_room_outlined,
                              size: 13, color: AppColors.textMuted),
                          Text(
                            plant.room,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textMuted,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '• ${plant.waterFrequencyDays}d',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // "Watered" Button that shows happy message
                ElevatedButton(
                  onPressed: () {
                    state.waterPlant(plant.id);
                    WaterCelebrationDialog.show(context, plant);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    minimumSize: const Size(82, 36),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.water_drop, size: 14),
                      SizedBox(width: 3),
                      Text(
                        'Watered',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUpcomingCard(BuildContext context, Plant plant) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.dividerLight),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlantDetailScreen(
                plant: plant,
                state: state,
              ),
            ),
          );
        },
        child: Row(
          children: [
            Text(plant.emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plant.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${plant.room} • Every ${plant.waterFrequencyDays} days',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.paleSage,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                plant.statusText,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryGreen,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
