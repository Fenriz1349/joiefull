# Joyfull 👕📱

![Swift](https://img.shields.io/badge/Swift-5.0-F05138?logo=swift&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-18%2B-000000?logo=apple&logoColor=white)
![SwiftUI](https://img.shields.io/badge/UI-SwiftUI-blue?logo=swift&logoColor=white)
![Architecture](https://img.shields.io/badge/Architecture-MVVM-orange)
![Accessibility](https://img.shields.io/badge/Accessibility-VoiceOver%20%7C%20Dynamic%20Type-4CAF50)

Joyfull est une application iOS développée en **SwiftUI** dont l’objectif principal est de proposer une interface :

- 📱 **Responsive** (iPhone & iPad)
- ♿ **Accessible** (VoiceOver, Dynamic Type, bonnes pratiques UI)

Les données affichées dans l’application proviennent d’une **API distante** et sont structurées selon une architecture **MVVM**.

---

## 🎯 Objectifs pédagogiques

Ce projet a été réalisé dans un cadre pédagogique afin de :

- Concevoir une interface SwiftUI adaptable à plusieurs tailles d’écran
- Mettre en œuvre les bases de l’**accessibilité iOS**
- Charger et afficher des données depuis une API REST
- Structurer un projet avec l’architecture **MVVM**
- Séparer clairement la logique métier et l’interface utilisateur

---

## 🏗️ Architecture

L’application repose sur l’architecture **MVVM (Model – View – ViewModel)** :

### Model
- Représente les données métier issues de l’API
- Exemple : `Clothing`, `Picture`, `Category`

### ViewModel
- Gère le chargement des données depuis le réseau
- Expose des données prêtes à être affichées par les vues
- Utilise `ObservableObject` et `@Published`

### View
- Gère uniquement l’affichage
- S’adapte aux tailles d’écran iPhone / iPad
- Intègre les règles d’accessibilité SwiftUI

---

## 🌐 Source des données

Les données sont récupérées depuis l’API suivante :

https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/api/clothes.json


---

## ♿ Accessibilité

Le projet porte une attention particulière aux points suivants :

- Support de **VoiceOver**
- Utilisation de labels et descriptions accessibles
- Respect du **Dynamic Type**
- Contrastes et tailles de texte adaptés
- Navigation claire et compréhensible

---

## 📱 Responsive Design

L’interface est conçue pour :

- S’adapter automatiquement aux écrans **iPhone** et **iPad**
- Tirer parti des layouts SwiftUI (`Grid`, `ScrollView`, `adaptive`)
- Garantir une expérience utilisateur cohérente quel que soit l’appareil

---

## 🛠️ Technologies utilisées

- Swift
- SwiftUI
- Combine
- async/await
- Architecture MVVM

---

## 🚀 État du projet

- [x] Modèles de données
- [x] ViewModel
- [x] Vues SwiftUI
- [x] Gestion avancée de l’accessibilité
- [x] Optimisation responsive iPad
- [x] Tests unitaires (Modèles, ViewModels, Data, Network, Utils)

---

## 📚 Contexte

Ce projet est destiné à un **usage pédagogique** et ne vise pas une évolution fonctionnelle à long terme.
