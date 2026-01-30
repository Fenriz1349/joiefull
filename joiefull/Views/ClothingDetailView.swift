//
//  ClothingDetailView.swift
//  joiefull
//
//  Created by Julien Cotte on 18/12/2025.
//

import SwiftUI

/// Displays detailed information about a clothing item
/// Adapts layout based on device size and orientation (portrait/landscape)
struct ClothingDetailView: View {

    @EnvironmentObject private var container: ClothingContainerViewModel
    @AccessibilityFocusState var focusOnSummary: Bool
    let externalFocus: FocusState<Bool>.Binding?

    let item: Clothing
    let onClose: (() -> Void)?

    var body: some View {
        GeometryReader { geo in
            // Use horizontal layout for landscape, vertical for portrait
            let layout = LayoutRules.getDetailViewLayout(geo.size)
            ScrollView {
                layout {
                    ProductImageContainer(
                        item: item,
                        displayedLikes: container.getdisplayedLikes(for: item),
                        isLiked: container.isLiked(item),
                        rating: container.getCalculatedRating(item),
                        basePriority: 1000,
                        onLikeTapped: { container.toggleLike(for: item) },
                        onShareTapped: { container.isShareComposerPresented = true },
                        onClose: onClose,
                        isSummaryFocused: $focusOnSummary)
                    .accessibilityFocused($focusOnSummary)
                    .onAppear {
                       focusSummary()
                    }
                    .onChange(of: container.selectedItem) {
                        focusSummary()
                        externalFocus?.wrappedValue = false
                    }
                    .onDisappear {
                        focusOnSummary = false
                    }

                    VStack(alignment: .leading, spacing: 20) {
                        DescriptionRow(isDetail: true, rating: container.getCalculatedRating(item), item: item)
                            .accessibilityHidden(true)

                        Text(item.descriptionText)
                            .accessibilityHidden(true)
                            .font(.subheadline)

                        RatingRow(rating: container.getRating(for: item),
                                  starPressed: { index in
                            container.setNewRating(for: item, rating: index)
                        })
                        ReviewInputView(text: container.commentTextBinding(for: item), externalFocus: externalFocus)
                    }
                }
                .padding()
            }
            .contentShape(Rectangle())
            .onTapGesture {
                externalFocus?.wrappedValue = false
            }
        }
        .sheet(isPresented: $container.isShareComposerPresented) {
            ShareComposerView(
                itemName: item.name,
                text: $container.shareNoteDraft,
                onShare: {
                    container.makeSharePayload(for: item, shareNote: container.shareNoteDraft)
                    container.isShareComposerPresented = false
                },
                onCancel: {
                    container.isShareComposerPresented = false
                }
            )
        }
        .sheet(item: $container.sharePayload) { payload in
            ShareSheet(items: payload.items)
        }
    }
}

#Preview {
    ClothingDetailView(externalFocus: nil, item: PreviewItems.item, onClose: {})
        .environmentObject(PreviewContainer.containerViewModel)
}
