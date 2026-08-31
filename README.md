# Joiefull 👕📱

![Swift](https://img.shields.io/badge/Swift-5.0-F05138?logo=swift&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-18%2B-000000?logo=apple&logoColor=white)
![SwiftUI](https://img.shields.io/badge/UI-SwiftUI-blue?logo=swift&logoColor=white)
![Architecture](https://img.shields.io/badge/Architecture-MVVM-orange)
![Accessibility](https://img.shields.io/badge/Accessibility-VoiceOver%20%7C%20Dynamic%20Type-4CAF50)

Application iOS de catalogue de vêtements développée en SwiftUI, avec un focus fort sur l'**accessibilité** (VoiceOver, Dynamic Type) et le **responsive design** iPhone & iPad. Données chargées depuis une API REST distante.

---

## 🏗️ Architecture

Architecture **MVVM** avec séparation stricte des responsabilités :

- **Model** — données métier issues de l'API (`Clothing`, `Picture`, `Category`)
- **ViewModel** — chargement réseau, exposition des données via `ObservableObject` / `@Published`
- **View** — affichage uniquement, adaptation multi-écrans, règles d'accessibilité SwiftUI

---

## ♿ Accessibilité

Point central du projet, rarement traité en profondeur :

- Support complet **VoiceOver** avec labels et descriptions sémantiques
- Respect du **Dynamic Type** sur l'ensemble des vues
- Contrastes et tailles de texte conformes aux guidelines Apple
- Navigation claire et logique pour les utilisateurs d'assistance

---

## 📱 Responsive Design

- Adaptation automatique iPhone & iPad
- Layouts SwiftUI natifs (`Grid`, `ScrollView`, `adaptive`)
- Expérience cohérente sur tous les formats d'écran

---

## 🛠️ Stack technique

- Swift / SwiftUI / Combine / async-await
- Architecture MVVM
- Tests unitaires : Modèles, ViewModels, Data, Network, Utils

---

## 🌐 Source des données

API REST OpenClassrooms :
`https://raw.githubusercontent.com/OpenClassrooms-Student-Center/...`
