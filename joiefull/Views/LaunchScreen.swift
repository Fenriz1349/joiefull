//
//  LaunchScreen.swift
//  joiefull
//
//  Created by Julien Cotte on 29/01/2026.
//

import SwiftUI

/// Launch screen shown during app startup (before views load)
/// Displays only the logo and background color
struct LaunchScreen: View {

    var body: some View {
        BrandingContentView()
    }
}

#Preview {
    LaunchScreen()
}
