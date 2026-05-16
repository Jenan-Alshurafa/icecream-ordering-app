# Ice Cream Ordering App

> A playful Flutter & Dart app for browsing and ordering ice cream — with a warm pastel UI, category browsing, interactive cart, and smooth checkout.

---

## 📱 Overview

**Scoops** (`ice_cream_app`) is a mobile ordering app built with **Flutter** and **Dart**. It lets users explore four categories of ice cream, pick their size, add items to a live cart, and complete their order with payment details — all wrapped in a soft pink aesthetic using the **Poppins** and **Pacifico** Google Fonts.

---

## ✨ Features

- Browse ice cream by category: **Cups, Rolls, Sandwiches, and Cakes**
- Select size (S / M / L) with live price updates
- Add and remove items from an interactive cart
- Enter payment details and confirm your order
- Your Favorites section for quick re-ordering

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `>=3.8.1`
- Dart SDK `^3.8.1`
- Android Studio or VS Code with the Flutter plugin
- An emulator or physical device

### Installation

```bash
# Clone the repository
git clone https://github.com/Jenan-Alshurafa/icecream-ordering-app.git

# Navigate into the Flutter project
cd icecream-ordering-app/my_flutter_app

# Install dependencies
flutter pub get

# Run the app
flutter run
```

---

## 📂 Project Structure

```
my_flutter_app/
├── pubspec.yaml
├── assets/
│   └── images/              # All ice cream product images
└── lib/
    ├── main.dart            # App entry point
    ├── explore.dart         # Home/browse screen with categories & product cards
    ├── pick.dart            # Product detail page (size picker, add to cart)
    ├── cart.dart            # Cart screen (items, quantities, total)
    └── cartmodel.dart       # CartItem data model
```

---

## 🔮 Planned Improvements

- [ ] Connect favorites to real user preferences with local storage
- [ ] Add search and notifications functionality
- [ ] Persist cart across sessions
- [ ] Add backend or Firebase integration for live ordering
- [ ] Add animations on add-to-cart action

---
