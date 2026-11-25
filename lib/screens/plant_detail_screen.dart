import 'package:flutter/material.dart';
import '../models/plant.dart';
import '../theme/app_theme.dart';
import '../widgets/water_celebration_dialog.dart';

class PlantDetailScreen extends StatefulWidget {
  final Plant plant;
  final PlantCareState state;

  const PlantDetailScreen({
    super.key,
    required this.plant,
    required this.state,
  });

  @override
  State<PlantDetailScreen> createState() => _PlantDetailScreenState();
}

class _PlantDetailScreenState extends State<PlantDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final plant = widget.plant;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(plant.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded,
                color: Colors.redAccent),
            tooltip: 'Remove Plant',
            onPressed: () {
              widget.state.removePlant(plant.id);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${plant.name} removed from your garden.'),
                  backgroundColor: AppColors.primaryDarkGreen,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Big Hero Card with Emoji & Quick Status
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.softYellow, AppColors.lightMint],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: AppColors.dividerLight),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryGreen.withValues(alpha: 0.06),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 104,
                    height: 104,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 14,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        plant.emoji,
                        style: const TextStyle(fontSize: 54),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    plant.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDarkGreen,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.meeting_room_outlined,
                                size: 14, color: AppColors.primaryGreen),
                            const SizedBox(width: 4),
                            Text(
                              plant.room,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: plant.needsWaterToday
                              ? AppColors.warmButterYellow
                              : Colors.white.withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.water_drop_rounded,
                              size: 14,
                              color: plant.needsWaterToday
                                  ? AppColors.yellowDark
                                  : const Color(0xFF0284C7),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              plant.statusText,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: plant.needsWaterToday
                                    ? AppColors.yellowDark
                                    : const Color(0xFF0369A1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),

            // Hydration Level Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.dividerLight),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Hydration Level',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryDarkGreen,
                        ),
                      ),
                      Text(
                        '${(plant.hydrationLevel * 100).toInt()}%',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: plant.needsWaterToday
                              ? Colors.redAccent
                              : AppColors.mediumGreen,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: plant.hydrationLevel,
                      minHeight: 10,
                      backgroundColor: const Color(0xFFE2E8F0),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        plant.needsWaterToday
                            ? const Color(0xFFF97316)
                            : AppColors.leafGreen,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    plant.needsWaterToday
                        ? 'Soil is currently dry. Give this plant a good drink today! 💧'
                        : 'Soil is currently hydrated. Next watering due in ${plant.daysUntilNextWater} days.',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Care Specifications 2x2 Grid
            Row(
              children: [
                Expanded(
                  child: _buildInfoCard(
                    icon: Icons.water_drop_outlined,
                    iconColor: const Color(0xFF0284C7),
                    title: 'Schedule',
                    value: 'Every ${plant.waterFrequencyDays} days',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildInfoCard(
                    icon: Icons.wb_sunny_outlined,
                    iconColor: const Color(0xFFEAB308),
                    title: 'Sunlight',
                    value: plant.sunlight,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildInfoCard(
                    icon: Icons.location_on_outlined,
                    iconColor: AppColors.primaryGreen,
                    title: 'Location',
                    value: plant.room,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildInfoCard(
                    icon: Icons.history_rounded,
                    iconColor: const Color(0xFF8B5CF6),
                    title: 'Last Watered',
                    value: plant.daysSinceWatered == 0
                        ? 'Today'
                        : '${plant.daysSinceWatered} days ago',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Care Tips Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.warmButterYellow.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.brightYellowAccent.withValues(alpha: 0.5),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text('💡', style: TextStyle(fontSize: 18)),
                      SizedBox(width: 8),
                      Text(
                        'Care Tip',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF78350F),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    plant.careTip,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF451A03),
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Big Prominent "Water Plant" Button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    widget.state.waterPlant(plant.id);
                  });
                  WaterCelebrationDialog.show(context, plant);
                },
                icon: const Icon(Icons.water_drop_rounded, size: 22),
                label: Text(
                  plant.needsWaterToday ? 'Water Plant Now' : 'Mark as Watered',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shadowColor: AppColors.primaryGreen.withValues(alpha: 0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.dividerLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
