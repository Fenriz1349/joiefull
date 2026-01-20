//
//  AccessibilityHandler.swift
//  joiefull
//
//  Created by Julien Cotte on 16/01/2026.
//

import Foundation

/// Centralizes all accessibility labels, hints, and values
/// Provides a single source of truth for VoiceOver text throughout the app
struct AccessibilityHandler {
    
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
    
    struct ClothingCard {

        static func fullLabel(
            itemName: String,
            imageDescription: String,
            price: Double,
            originalPrice: Double,
            rating: Double,
            category: String
        ) -> String {
            let ratingString = String(format: "%.1f", rating).replacingOccurrences(of: ".", with: ",")
            var priceText = "Prix : \(Int(price))€"

            if originalPrice != price {
                priceText += ", anciennement \(Int(originalPrice))€"
            }

            return """
            \(itemName).
            \(imageDescription).
            \(priceText).
            Note : \(ratingString) sur 5.
            Catégorie : \(category).
            """
        }

        static let hint = "Double-tap pour voir les détails de cet article"
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
    
    // MARK: - Rating Label
    
    struct RatingLabel {
        static let label = "Note"
        
        static func value(_ rating: Double) -> String {
            // Replace "." with "virgule" so VoiceOver can read it
            let ratingString = String(format: "%.1f", rating).replacingOccurrences(of: ".", with: ",")
            return "\(ratingString) sur 5"
        }
    }
    
    // MARK: - Description Row
    
    struct DescriptionRow {
        static let priceLabel = "Prix"
        static let originalPriceLabel = "Prix original"
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
        static func backButton(itemName: String) -> String {
            "Retour depuis les détails de \(itemName)"
        }
        
        static let descriptionLabel = "Description du produit"
        static let reviewsLabel = "Avis et notes"
        static let commentsLabel = "Commentaires utilisateurs"
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
    
    // MARK: - Clothing Detail View
    
    struct ClothingDetailView {
        static func title(itemName: String) -> String {
            "Détails de \(itemName)"
        }
        
        static let descriptionSectionLabel = "Description du produit"
        static let pricingLabel = "Tarification"
        static let ratingAndReviewLabel = "Avis et notes"
        static let commentsSectionLabel = "Vos commentaires"
        
        static func backButtonLabel(itemName: String) -> String {
            "Retour depuis \(itemName)"
        }
        
        static let shareButtonLabel = "Partager cet article"
        static let shareButtonHint = "Double-tap pour partager ce produit avec vos amis"
        
        static func priceWithDiscountLabel(
            currentPrice: Int,
            originalPrice: Int
        ) -> String {
            if originalPrice != currentPrice {
                let discount = Int(Double(originalPrice - currentPrice) / Double(originalPrice) * 100)
                return "\(currentPrice)€ au lieu de \(originalPrice)€, économie de \(discount)%"
            }
            return "\(currentPrice)€"
        }
        
        static func fullDescription(
            itemName: String,
            price: Int,
            originalPrice: Int,
            category: String,
            rating: Double
        ) -> String {
            var desc = "\(itemName), catégorie \(category)\n"
            
            if originalPrice != price {
                let discount = Int(Double(originalPrice - price) / Double(originalPrice) * 100)
                desc += "Prix : \(price)€ au lieu de \(originalPrice)€ (-\(discount)%)\n"
            } else {
                desc += "Prix : \(price)€\n"
            }
            
            desc += "Note : \(String(format: "%.1f", rating)) sur 5"
            
            return desc
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
