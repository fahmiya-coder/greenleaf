# 🌿 greenleaf — Plant Care Companion

A Flutter plant care web & mobile application designed to help you keep your house plants thriving with watering reminders, room tracking, and care tips.

---

## ✨ Features

- **Home Screen (Today's Hydration)**:
  - Real-time hydration completion progress ring (`X of Y completed`).
  - Prioritized list of plants needing water today with quick-water actions.
  - Celebratory empty-state when all plants are watered.
  - Upcoming watering preview.
- **My Plants Screen**:
  - Filter plants by room (*Living Room*, *Bedroom*, *Balcony*, *Kitchen*, *Windowsill*, *Office*).
  - Real-time search bar.
  - 2-column grid showing plant emoji, room tag, schedule, and status pills.
- **Plant Details Screen**:
  - Detailed hydration meter and days elapsed.
  - 2x2 specification matrix (Schedule, Sunlight requirement, Location, and Last Watered).
  - Tailored care tips for each plant.
  - Prominent "Water Plant Now" action.
- **Add Plant Screen**:
  - Interactive emoji picker with 14+ plant emojis (`🪴`, `🌱`, `🌿`, `🌵`, `🌹`, `🍃`, `🌸`, etc.).
  - Room selector chips.
  - Watering frequency slider (1 to 30 days).
  - Sunlight requirement selector.
- **Watered Celebration**:
  - Bouncing emoji celebration dialog with delightful quotes and next watering dates.
- **Responsive Phone Frame**:
  - On desktop/laptop browsers: centered inside an iPhone frame (390 × 844, rounded corners, dynamic island / notch, home indicator bar) over a soft grey background.
  - On mobile browsers and native devices: full screen.

---

## 🪴 The 8 Sample Plants

1. **Money Plant** (🪴) — Living Room • Water every 7 days
2. **Aloe Vera** (🌵) — Bedroom • Water every 14 days
3. **Snake Plant** (🌱) — Living Room • Water every 10 days
4. **Tulsi** (🍃) — Balcony • Water every 2 days
5. **Rose** (🌹) — Balcony • Water every 3 days
6. **Mint** (🌿) — Kitchen • Water every 2 days
7. **Peace Lily** (🌸) — Office • Water every 5 days
8. **Cactus** (🌵) — Windowsill • Water every 21 days

---

## 🎨 Color Palette

- **Greens**: Deep Forest (`#1B4332`, `#2D6A4F`), Leaf Green (`#52B788`), Light Mint (`#D8F3DC`)
- **Soft Yellows**: Warm Butter (`#FEF3C7`), Soft Yellow Glow (`#FFF9DB`), Honey Accent (`#F6C845`)
- **Whites & Neutrals**: Card White (`#FFFFFF`), Soft Page Background (`#F8FAF7`)

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev) (v3.50+ or stable)
- Chrome / Modern Web Browser

### Run Locally
```bash
# Clone the repository
git clone https://github.com/fahmiya-coder/greenleaf.git
cd greenleaf

# Get packages
flutter pub get

# Run in Chrome
flutter run -d chrome
```
