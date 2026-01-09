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
    @EnvironmentObject private var containerVM: ClothingContainerViewModel
    
    let item: Clothing

    @Environment(\.horizontalSizeClass) private var hSizeClass

    var body: some View {
        GeometryReader { geo in
            // Detect if in landscape mode on iPhone
            let isPhoneLandscape = hSizeClass == .compact && geo.size.width > geo.size.height

            // Adjust image ratio based on orientation
            let imageRatio: CGFloat = isPhoneLandscape ? 1 : 3/4

            // Use horizontal layout for landscape, vertical for portrait
            let layout = isPhoneLandscape
            ? AnyLayout(HStackLayout(alignment: .top, spacing: 20))
            : AnyLayout(VStackLayout(alignment: .leading, spacing: 20))
            ScrollView {
                layout {
                    ProductImageContainer(
                        imageURL: item.picture.url,
                        likes: item.likes + (containerVM.isLiked(item) ? 1 : 0),
                        isLiked: containerVM.isLiked(item),
                        onLikeTapped: { containerVM.toggleLike(for: item) },
                        aspectRatio: imageRatio,
                        showsShareButton: true
                    )

                    VStack(alignment: .leading, spacing: 20) {
                        DescriptionRow(isDetail: true, item: item)

                        Text(item.descriptionText)
                            .font(.subheadline)

                        ReviewRow()
                        ReviewInputView()
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    ClothingDetailView(item: PreviewItems.item)
        .environmentObject(PreviewContainer.containerViewModel)
}
