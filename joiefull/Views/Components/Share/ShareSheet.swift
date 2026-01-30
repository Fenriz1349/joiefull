//
//  ShareSheet.swift
//  joiefull
//
//  Created by Julien Cotte on 16/01/2026.
//

import SwiftUI
import UIKit

/// SwiftUI wrapper around iOS Share Sheet (UIActivityViewController)
struct ShareSheet: UIViewControllerRepresentable {

    let items: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
