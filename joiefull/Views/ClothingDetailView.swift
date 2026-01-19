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
    let item: Clothing

    @Environment(\.horizontalSizeClass) private var hSizeClass

    var body: some View {
        GeometryReader { geo in
            // Detect if in landscape mode on iPhone
            let isPhoneLandscape = hSizeClass == .compact && geo.size.width > geo.size.height

            // Use horizontal layout for landscape, vertical for portrait
            let layout = isPhoneLandscape
            ? AnyLayout(HStackLayout(alignment: .top, spacing: 20))
            : AnyLayout(VStackLayout(alignment: .leading, spacing: 20))
            ScrollView {
                layout {
                    ZStack(alignment: .topTrailing) {
                        ProductImageContainer(
                            imageURL: item.picture.url
                        )
                        ButtonsOverlay(likes: item.likes ,
                                       isLiked: container.isLiked(item),
                                       onLikeTapped: { container.toggleLike(for: item) },
                                       onShareTapped: { container.isShareComposerPresented = true })
                    }
                    VStack(alignment: .leading, spacing: 20) {
                        DescriptionRow(isDetail: true, rating: container.getCalculatedRating(item), item: item)

                        Text(item.descriptionText)
                            .font(.subheadline)

                        ReviewRow(rating: container.getRating(for: item),
                                  starPressed: { index in
                            container.setNewRating(for: item, rating: index)
                        })
                        ReviewInputView(text: container.commentTextBinding(for: item))
                    }
                }
                .padding()
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
    ClothingDetailView(item: PreviewItems.item)
        .environmentObject(PreviewContainer.containerViewModel)
}
