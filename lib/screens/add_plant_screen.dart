import 'package:flutter/material.dart';
import '../models/plant.dart';
import '../theme/app_theme.dart';

class AddPlantScreen extends StatefulWidget {
  final PlantCareState state;
  final VoidCallback onPlantAdded;

  const AddPlantScreen({
    super.key,
    required this.state,
    required this.onPlantAdded,
  });

  @override
  State<AddPlantScreen> createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _careTipController = TextEditingController();

  String _selectedEmoji = '🪴';
  String _selectedRoom = 'Living Room';
  int _waterFrequencyDays = 5;
  String _selectedSunlight = 'Bright Indirect';

  final List<String> _availableEmojis = [
    '🪴', '🌱', '🌿', '🌵', '🌹', '🍃', '🌸',
    '🌾', '🌴', '🌻', '🌺', '🍀', '🎋', '🎍',
  ];

  final List<String> _availableRooms = [
    'Living Room',
    'Bedroom',
    'Balcony',
    'Kitchen',
    'Office',
    'Windowsill',
    'Bathroom',
  ];

  final List<String> _sunlightOptions = [
    'Low Light',
    'Partial Sun',
    'Bright Indirect',
    'Direct Sun',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _careTipController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final newPlant = Plant(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text.trim(),
      emoji: _selectedEmoji,
      room: _selectedRoom,
      waterFrequencyDays: _waterFrequencyDays,
      sunlight: _selectedSunlight,
      careTip: _careTipController.text.trim().isNotEmpty
          ? _careTipController.text.trim()
          : 'Likes consistent care and love! 💚',
      lastWatered: DateTime.now(),
    );

    widget.state.addPlant(newPlant);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Text(_selectedEmoji, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '${newPlant.name} added to your garden!',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.primaryGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );

    widget.onPlantAdded();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Add New Plant'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Emoji Selector Showcase
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 86,
                      height: 86,
                      decoration: BoxDecoration(
                        color: AppColors.softYellow,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.brightYellowAccent,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryGreen.withValues(alpha: 0.08),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          _selectedEmoji,
                          style: const TextStyle(fontSize: 44),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Choose an emoji for your plant',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Horizontal Emoji Picker
              SizedBox(
                height: 48,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _availableEmojis.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final emoji = _availableEmojis[index];
                    final isSelected = emoji == _selectedEmoji;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedEmoji = emoji;
                        });
                      },
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.lightMint
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primaryGreen
                                : AppColors.dividerLight,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Center(
                          child: Text(emoji,
                              style: const TextStyle(fontSize: 22)),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 22),

              // Plant Name Field
              const Text(
                'Plant Name',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDarkGreen,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'e.g., Fiddle Leaf Fig, Pothos...',
                  filled: true,
                  fillColor: Colors.white,
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
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter a plant name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Room Selection Chips
              const Text(
                'Room / Location',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDarkGreen,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _availableRooms.map((room) {
                  final isSelected = room == _selectedRoom;
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
                      fontSize: 12,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w500,
                      color: isSelected ? Colors.white : AppColors.textDark,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: isSelected
                            ? AppColors.primaryGreen
                            : AppColors.dividerLight,
                      ),
                    ),
                    showCheckmark: false,
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Watering Frequency Slider
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.warmButterYellow.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppColors.brightYellowAccent.withValues(alpha: 0.4),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.water_drop_rounded,
                                color: Color(0xFF0284C7), size: 18),
                            SizedBox(width: 6),
                            Text(
                              'Watering Frequency',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF78350F),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Every $_waterFrequencyDays ${_waterFrequencyDays == 1 ? "day" : "days"}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryDarkGreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Slider(
                      value: _waterFrequencyDays.toDouble(),
                      min: 1,
                      max: 30,
                      divisions: 29,
                      activeColor: AppColors.primaryGreen,
                      inactiveColor: const Color(0xFFE2E8F0),
                      onChanged: (val) {
                        setState(() {
                          _waterFrequencyDays = val.toInt();
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Sunlight Requirement Chips
              const Text(
                'Sunlight Needed',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDarkGreen,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _sunlightOptions.map((sun) {
                  final isSelected = sun == _selectedSunlight;
                  return ChoiceChip(
                    label: Text(sun),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedSunlight = sun;
                        });
                      }
                    },
                    selectedColor: AppColors.mediumGreen,
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w500,
                      color: isSelected ? Colors.white : AppColors.textDark,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: isSelected
                            ? AppColors.mediumGreen
                            : AppColors.dividerLight,
                      ),
                    ),
                    showCheckmark: false,
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Care Tips / Notes Field
              const Text(
                'Care Tip or Notes (Optional)',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDarkGreen,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _careTipController,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'e.g., Prefers bottom watering and morning mist...',
                  filled: true,
                  fillColor: Colors.white,
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
              const SizedBox(height: 32),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    foregroundColor: Colors.white,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Add to Garden',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text('🌱', style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
