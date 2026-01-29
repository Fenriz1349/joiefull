//
//  AccessibilityHandler.swift
//  joiefull
//
//  Created by Julien Cotte on 16/01/2026.
//

import Foundation

/// Centralizes all accessibility labels, hints, and values
/// Provides a single source of truth for VoiceOver text throughout the app
enum AccessibilityHandler {

    // MARK: - Loading

    struct Loading {
        static var label: String { "Chargement en cours" }
        static var hint: String { "Veuillez patienter" }
    }

    // MARK: - Like Button

    struct LikeButton {
        static func label(isLiked: Bool) -> String {
            isLiked ? "Retirer des favoris" : "Aimer cet article"
        }

        static func hint(isLiked: Bool) -> String {
            "Double-tap pour \(isLiked ? "retirer" : "ajouter") aux favoris"
        }

        static func value(likes: Int) -> String {
            let count = likes == 1 ? "personne" : "personnes"
            return "\(likes) \(count) aime\(likes > 1 ? "nt" : "") cet article"
        }
    }

    // MARK: - Star Button

    struct StarButton {
        static func label(index: Int) -> String {
            "Donner \(index) étoile\(index > 1 ? "s" : "")"
        }

        static func hint(index: Int) -> String {
            "Double-tap pour attribuer \(index) étoile\(index > 1 ? "s" : "")"
        }

        static func value(isSelected: Bool) -> String {
            isSelected ? "Sélectionnée" : ""
        }
    }

    // MARK: - Clothing Card

    struct Clothing {
        static func itemSummary(
            itemName: String,
            imageDescription: String? = nil,
            itemDescription: String? = nil,
            price: Double,
            originalPrice: Double,
            rating: Double,
            category: String? = nil
        ) -> String {

            let ratingString = String(format: "%.1f", rating).replacingOccurrences(of: ".", with: ",")
                .replacingOccurrences(of: ",0", with: "")
            var priceText = "Prix : \(Int(price))€"

            if originalPrice != price {
                priceText += ", anciennement \(Int(originalPrice))€"
            }

            var parts: [String] = []
            parts.append("\(itemName).")
            parts.append("\(priceText).")
            parts.append("Note : \(ratingString) sur 5.")

            if let imageDescription, !imageDescription.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                parts.append("\(imageDescription).")
            }

            if let itemDescription, !itemDescription.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                parts.append("\(itemDescription).")
            }

            if let category, !category.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                parts.append("Catégorie : \(category).")
            }

            return parts.joined(separator: "\n")
        }

        static let hintCard = "Double-tap pour voir les détails de cet article"
    }

    // MARK: - Review Input (Comment)

    struct ReviewInput {
        static let label = "Votre commentaire"

        static func hint(maxCharacters: Int) -> String {
            "Tapez jusqu'à \(maxCharacters) caractères pour partager votre avis"
        }

        static let placeholder = "Partagez ici vos impressions sur cette pièce"
    }

    // MARK: - Share Button

    struct ShareButton {
        static let label = "Partager"
        static let hint = "Double-tap pour partager cet article avec vos amis"
    }

    // MARK: - Close Button

    struct CloseButton {
        static let label = "Fermer"
        static let hint = "Double-tap pour fermer le detail de cet article"
    }

    // MARK: - Product Image Container

    struct ProductImageContainer {
        static let imageHidden = true  // Image are described by view, avoid double double description
    }

    // MARK: - Clothing Category Row

    struct CategoryRow {
        static func sectionLabel(_ categoryTitle: String) -> String {
            "\(categoryTitle) - Section"
        }

        static let hint = "Scroll horizontalement pour voir plus d'articles"
    }

    // MARK: - Share Composer

    struct ShareComposer {
        static func title(itemName: String) -> String {
            "Partager \(itemName)"
        }

        static let messageFieldLabel = "Message personnalisé"
        static let messageFieldHint = "Optionnel - Ajoutez un commentaire personnel"
        static let cancelButton = "Annuler"
        static let shareButton = "Partager"
    }

    // MARK: - Detail View

    struct DetailView {
        static func backButton(itemName: String) -> String { "Retour depuis les détails de \(itemName)" }

        static func detailOpen(itemName: String) -> String { "Détail ouvert pour \(itemName)" }
    }

    // MARK: - Clothing List View

    struct ClothingListView {
        static let loadingLabel = "Chargement des articles"
        static let loadingHint = "Patientez pendant que les articles se chargent"

        static func categoryLabel(_ categoryTitle: String) -> String {
            "Section \(categoryTitle)"
        }

        static func categoryHint(_ categoryTitle: String) -> String {
            "Articles de la catégorie \(categoryTitle). Scroll horizontalement pour voir plus"
        }
    }

    // MARK: - Clothing Category Row

    struct ClothingCategoryRow {
        static func sectionLabel(_ categoryTitle: String) -> String {
            "Articles - \(categoryTitle)"
        }

        static let scrollHint = "Scroll horizontalement pour voir plus d'articles dans cette catégorie"
    }
}
