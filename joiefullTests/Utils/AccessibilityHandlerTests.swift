//
//  AccessibilityHandlerTests.swift
//  joiefullTests
//
//  Created by Julien Cotte on 02/02/2026.
//

import XCTest
@testable import joiefull

final class AccessibilityHandlerTests: XCTestCase {

    // MARK: - LikeButton

    /// Updates label based on liked state.
    func test_likeButton_label_changesWithState() {
        XCTAssertEqual(AccessibilityHandler.LikeButton.label(isLiked: true), "Retirer des favoris")
        XCTAssertEqual(AccessibilityHandler.LikeButton.label(isLiked: false), "Aimer cet article")
    }

    /// Updates hint based on liked state.
    func test_likeButton_hint_changesWithState() {
        XCTAssertEqual(AccessibilityHandler.LikeButton.hint(isLiked: true), "Double-tap pour retirer aux favoris")
        XCTAssertEqual(AccessibilityHandler.LikeButton.hint(isLiked: false), "Double-tap pour ajouter aux favoris")
    }

    /// Uses singular form for one like.
    func test_likeButton_value_singularForOne() {
        XCTAssertEqual(AccessibilityHandler.LikeButton.value(likes: 1), "1 personne aime cet article")
    }

    /// Uses plural forms for multiple likes.
    func test_likeButton_value_pluralForMultiple() {
        XCTAssertEqual(AccessibilityHandler.LikeButton.value(likes: 2), "2 personnes aiment cet article")
        XCTAssertEqual(AccessibilityHandler.LikeButton.value(likes: 5), "5 personnes aiment cet article")
    }

    // MARK: - StarButton

    /// Uses singular and plural for labels.
    func test_starButton_label_pluralization() {
        XCTAssertEqual(AccessibilityHandler.StarButton.label(index: 1), "Donner 1 étoile")
        XCTAssertEqual(AccessibilityHandler.StarButton.label(index: 3), "Donner 3 étoiles")
    }

    /// Uses singular and plural for hints.
    func test_starButton_hint_pluralization() {
        XCTAssertEqual(AccessibilityHandler.StarButton.hint(index: 1), "Double-tap pour attribuer 1 étoile")
        XCTAssertEqual(AccessibilityHandler.StarButton.hint(index: 4), "Double-tap pour attribuer 4 étoiles")
    }

    /// Returns a value only when selected.
    func test_starButton_value_isEmptyWhenNotSelected() {
        XCTAssertEqual(AccessibilityHandler.StarButton.value(isSelected: false), "")
        XCTAssertEqual(AccessibilityHandler.StarButton.value(isSelected: true), "Sélectionnée")
    }

    // MARK: - Clothing.itemSummary

    /// Includes name, price and rating.
    func test_clothing_itemSummary_containsNamePriceAndRating() {
        let text = AccessibilityHandler.Clothing.itemSummary(
            itemName: "Pull",
            imageDescription: nil,
            itemDescription: nil,
            price: 29.99,
            originalPrice: 39.99,
            rating: 4.0,
            category: nil
        )

        XCTAssertTrue(text.contains("Pull."))
        XCTAssertTrue(text.contains("Prix : 29€"))
        XCTAssertTrue(text.contains("anciennement 39€"))
        XCTAssertTrue(text.contains("Note : 4 sur 5."))
    }

    /// Does not include original price when unchanged.
    func test_clothing_itemSummary_whenOriginalPriceEqualsPrice_doesNotIncludeFormerPrice() {
        let text = AccessibilityHandler.Clothing.itemSummary(
            itemName: "T-shirt",
            imageDescription: nil,
            itemDescription: nil,
            price: 10,
            originalPrice: 10,
            rating: 5.0,
            category: nil
        )

        XCTAssertTrue(text.contains("Prix : 10€"))
        XCTAssertFalse(text.contains("anciennement"))
        XCTAssertTrue(text.contains("Note : 5 sur 5."))
    }

    /// Formats rating with comma and removes trailing ,0.
    func test_clothing_itemSummary_formatsRating() {
        let text1 = AccessibilityHandler.Clothing.itemSummary(
            itemName: "Veste",
            imageDescription: nil,
            itemDescription: nil,
            price: 50,
            originalPrice: 50,
            rating: 3.5,
            category: nil
        )
        XCTAssertTrue(text1.contains("Note : 3,5 sur 5."))

        let text2 = AccessibilityHandler.Clothing.itemSummary(
            itemName: "Jean",
            imageDescription: nil,
            itemDescription: nil,
            price: 60,
            originalPrice: 60,
            rating: 4.0,
            category: nil
        )
        XCTAssertTrue(text2.contains("Note : 4 sur 5."))
        XCTAssertFalse(text2.contains("4,0"))
    }

    /// Appends optional parts when provided.
    func test_clothing_itemSummary_appendsOptionalPartsWhenNotEmpty() {
        let text = AccessibilityHandler.Clothing.itemSummary(
            itemName: "Robe",
            imageDescription: "Photo: robe rouge",
            itemDescription: "Coupe droite",
            price: 25,
            originalPrice: 30,
            rating: 4.2,
            category: "Femmes"
        )

        XCTAssertTrue(text.contains("Photo: robe rouge."))
        XCTAssertTrue(text.contains("Coupe droite."))
        XCTAssertTrue(text.contains("Catégorie : Femmes."))
    }

    /// Ignores optional parts when empty or whitespace.
    func test_clothing_itemSummary_ignoresEmptyOptionalTexts() {
        let text = AccessibilityHandler.Clothing.itemSummary(
            itemName: "Sac",
            imageDescription: "   ",
            itemDescription: "",
            price: 10,
            originalPrice: 10,
            rating: 3.5,
            category: "   "
        )

        XCTAssertFalse(text.contains("Catégorie"))
        XCTAssertFalse(text.contains("\n\n"))
        XCTAssertFalse(text.contains(".."))
    }

    /// Exposes the expected card hint.
    func test_clothing_hintCard_isExpected() {
        XCTAssertEqual(AccessibilityHandler.Clothing.hintCard, "Double-tap pour voir les détails de cet article")
    }

    // MARK: - ReviewInput

    /// Builds a hint using the provided max characters.
    func test_reviewInput_hint_usesMaxCharacters() {
        XCTAssertEqual(
            AccessibilityHandler.ReviewInput.hint(maxCharacters: 140),
            "Tapez jusqu'à 140 caractères pour partager votre avis"
        )
    }

    /// Exposes review input constants.
    func test_reviewInput_constants_areExpected() {
        XCTAssertEqual(AccessibilityHandler.ReviewInput.label, "Votre commentaire")
        XCTAssertEqual(AccessibilityHandler.ReviewInput.placeholder, "Partagez ici vos impressions sur cette pièce")
    }

    // MARK: - ShareComposer

    /// Builds a title including the item name.
    func test_shareComposer_title_includesItemName() {
        XCTAssertEqual(AccessibilityHandler.ShareComposer.title(itemName: "Pull"), "Partager Pull")
    }

    /// Exposes share composer constants.
    func test_shareComposer_constants_areExpected() {
        XCTAssertEqual(AccessibilityHandler.ShareComposer.messageFieldLabel, "Message personnalisé")
        XCTAssertEqual(AccessibilityHandler.ShareComposer.messageFieldHint, "Optionnel - Ajoutez un commentaire personnel")
        XCTAssertEqual(AccessibilityHandler.ShareComposer.cancelButton, "Annuler")
        XCTAssertEqual(AccessibilityHandler.ShareComposer.shareButton, "Partager")
    }

    // MARK: - Buttons / Labels constants

    /// Exposes share and close button labels and hints.
    func test_shareAndCloseButton_constants_areExpected() {
        XCTAssertEqual(AccessibilityHandler.ShareButton.label, "Partager")
        XCTAssertEqual(AccessibilityHandler.ShareButton.hint, "Double-tap pour partager cet article avec vos amis")

        XCTAssertEqual(AccessibilityHandler.CloseButton.label, "Fermer")
        XCTAssertEqual(AccessibilityHandler.CloseButton.hint, "Double-tap pour fermer le detail de cet article")
    }

    /// Exposes loading and reload accessibility strings.
    func test_loadingAndReload_constants_areExpected() {
        XCTAssertEqual(AccessibilityHandler.Loading.label, "Chargement en cours")
        XCTAssertEqual(AccessibilityHandler.Loading.hint, "Veuillez patienter")

        XCTAssertEqual(AccessibilityHandler.LoadingError.label, "Erreur de chargement")
        XCTAssertEqual(AccessibilityHandler.LoadingError.hint, "Appuie sur Réessayer pour relancer le chargement")

        XCTAssertEqual(AccessibilityHandler.ReloadButton.label, "Réessayer")
        XCTAssertEqual(AccessibilityHandler.ReloadButton.hint, "Appuie pour relancer le chargement")
    }

    /// Exposes image container configuration.
    func test_productImageContainer_isHidden_isTrue() {
        XCTAssertTrue(AccessibilityHandler.ProductImageContainer.imageHidden)
    }

    // MARK: - Category / List labels

    /// Builds category row section label.
    func test_categoryRow_sectionLabel_includesTitle() {
        XCTAssertEqual(AccessibilityHandler.CategoryRow.sectionLabel("Promos"), "Promos - Section")
        XCTAssertEqual(AccessibilityHandler.CategoryRow.hint, "Scroll horizontalement pour voir plus d'articles")
    }

    /// Builds list view category label and hint.
    func test_clothingListView_categoryLabelAndHint_includeTitle() {
        XCTAssertEqual(AccessibilityHandler.ClothingListView.categoryLabel("Chaussures"), "Section Chaussures")
        XCTAssertEqual(
            AccessibilityHandler.ClothingListView.categoryHint("Chaussures"),
            "Articles de la catégorie Chaussures. Scroll horizontalement pour voir plus"
        )
        XCTAssertEqual(AccessibilityHandler.ClothingListView.loadingLabel, "Chargement des articles")
        XCTAssertEqual(AccessibilityHandler.ClothingListView.loadingHint, "Patientez pendant que les articles se chargent")
    }

    /// Builds clothing category row section label.
    func test_clothingCategoryRow_sectionLabel_includesTitle() {
        XCTAssertEqual(AccessibilityHandler.ClothingCategoryRow.sectionLabel("Vestes"), "Articles - Vestes")
        XCTAssertEqual(
            AccessibilityHandler.ClothingCategoryRow.scrollHint,
            "Scroll horizontalement pour voir plus d'articles dans cette catégorie"
        )
    }

    // MARK: - DetailView

    /// Builds back button label and open announcement.
    func test_detailView_strings_includeItemName() {
        XCTAssertEqual(
            AccessibilityHandler.DetailView.backButton(itemName: "Pull"),
            "Retour depuis les détails de Pull"
        )
        XCTAssertEqual(
            AccessibilityHandler.DetailView.detailOpen(itemName: "Pull"),
            "Détail ouvert pour Pull"
        )
    }

    // MARK: - EmptyState

    /// Exposes empty state labels and hints.
    func test_emptyState_constants_areExpected() {
        XCTAssertEqual(AccessibilityHandler.EmptyState.noResultsLabel, "Aucun résultat")
        XCTAssertEqual(
            AccessibilityHandler.EmptyState.noResultsHint,
            "Aucun article ne correspond à votre recherche. Effacez la recherche pour voir tous les articles."
        )

        XCTAssertEqual(AccessibilityHandler.EmptyState.catalogEmptyLabel, "Catalogue vide")
        XCTAssertEqual(AccessibilityHandler.EmptyState.catalogEmptyHint, "Aucun article n’est disponible pour le moment.")
    }
}

