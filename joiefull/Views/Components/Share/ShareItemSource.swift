//
//  ShareItemSource.swift
//  joiefull
//
//  Created by Julien Cotte on 16/01/2026.
//

import UIKit

/// Adapts shared content by activity type (copy, mail, messages, etc.).
/// Copy = text only. Others = text + URL.
final class ShareItemSource: NSObject, UIActivityItemSource {

    private let subject: String
    private let message: String
    private let url: URL?

    init(subject: String, message: String, url: URL?) {
        self.subject = subject
        self.message = message
        self.url = url
    }

    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        message
    }

    func activityViewController(
        _ activityViewController: UIActivityViewController,
        itemForActivityType activityType: UIActivity.ActivityType?
    ) -> Any? {
        // For "Copy", ensure only text is copied
        if activityType == .copyToPasteboard {
            return composedText()
        }

        // Default: share text (apps can also pick URL if present)
        return composedText()
    }

    func activityViewController(
        _ activityViewController: UIActivityViewController,
        subjectForActivityType activityType: UIActivity.ActivityType?
    ) -> String {
        subject
    }

    private func composedText() -> String {
        if let url {
            return "\(message)\n\n\(url.absoluteString)"
        } else {
            return message
        }
    }
}
