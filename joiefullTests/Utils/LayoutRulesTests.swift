//
//  LayoutRulesTests.swift
//  joiefullTests
//
//  Created by Julien Cotte on 02/02/2026.
//

import XCTest
import SwiftUI
@testable import joiefull

@MainActor
final class LayoutRulesTests: XCTestCase {

    override func tearDown() {
        Task { @MainActor in
            DeviceType.debugOverride = nil
        }
        super.tearDown()
    }

    // MARK: - isLandscape

    /// Detects landscape-like sizes.
    func test_isLandscape_returnsTrueOnlyWhenWidthGreaterThanHeight() {
        XCTAssertTrue(LayoutRules.isLandscape(CGSize(width: 800, height: 400)))
        XCTAssertFalse(LayoutRules.isLandscape(CGSize(width: 300, height: 700)))
        XCTAssertFalse(LayoutRules.isLandscape(CGSize(width: 400, height: 400)))
    }

    // MARK: - splitLayout

    /// Uses an HStack layout in landscape.
    func test_splitLayout_landscape_usesHStackLayout() {
        let layout = LayoutRules.splitLayout(for: CGSize(width: 800, height: 400))
        XCTAssertTrue(String(describing: layout).contains("HStackLayout"))
    }

    /// Uses a VStack layout in portrait.
    func test_splitLayout_portrait_usesVStackLayout() {
        let layout = LayoutRules.splitLayout(for: CGSize(width: 300, height: 700))
        XCTAssertTrue(String(describing: layout).contains("VStackLayout"))
    }

    // MARK: - listFrame

    /// Returns full size when split is disabled.
    func test_listFrame_whenSplitDisabled_returnsFullSize() {
        let size = CGSize(width: 300, height: 600)
        XCTAssertEqual(LayoutRules.listFrame(in: size, allowsSplit: false, hasSelection: true), size)
    }

    /// Returns full size when there is no selection.
    func test_listFrame_whenNoSelection_returnsFullSize() {
        let size = CGSize(width: 300, height: 600)
        XCTAssertEqual(LayoutRules.listFrame(in: size, allowsSplit: true, hasSelection: false), size)
    }

    /// Uses 2/3 width in landscape split mode.
    func test_listFrame_whenSplitEnabled_landscape_usesTwoThirdsWidth() {
        let size = CGSize(width: 900, height: 400)
        let frame = LayoutRules.listFrame(in: size, allowsSplit: true, hasSelection: true)
        XCTAssertEqual(frame.width, 900 * 2 / 3)
        XCTAssertEqual(frame.height, 400)
    }

    /// Uses 2/3 height in portrait split mode.
    func test_listFrame_whenSplitEnabled_portrait_usesTwoThirdsHeight() {
        let size = CGSize(width: 300, height: 900)
        let frame = LayoutRules.listFrame(in: size, allowsSplit: true, hasSelection: true)
        XCTAssertEqual(frame.width, 300)
        XCTAssertEqual(frame.height, 900 * 2 / 3)
    }

    // MARK: - detailFrame

    /// Returns zero when split is disabled.
    func test_detailFrame_whenSplitDisabled_returnsZero() {
        let size = CGSize(width: 300, height: 600)
        XCTAssertEqual(LayoutRules.detailFrame(in: size, allowsSplit: false, hasSelection: true), .zero)
    }

    /// Returns zero when there is no selection.
    func test_detailFrame_whenNoSelection_returnsZero() {
        let size = CGSize(width: 300, height: 600)
        XCTAssertEqual(LayoutRules.detailFrame(in: size, allowsSplit: true, hasSelection: false), .zero)
    }

    /// Uses 1/3 width in landscape split mode.
    func test_detailFrame_whenSplitEnabled_landscape_usesThirdWidth() {
        let size = CGSize(width: 900, height: 400)
        let frame = LayoutRules.detailFrame(in: size, allowsSplit: true, hasSelection: true)
        XCTAssertEqual(frame.width, 900 / 3)
        XCTAssertEqual(frame.height, 400)
    }

    /// Uses 1/3 height in portrait split mode.
    func test_detailFrame_whenSplitEnabled_portrait_usesThirdHeight() {
        let size = CGSize(width: 300, height: 900)
        let frame = LayoutRules.detailFrame(in: size, allowsSplit: true, hasSelection: true)
        XCTAssertEqual(frame.width, 300)
        XCTAssertEqual(frame.height, 900 / 3)
    }

    // MARK: - getDetailViewLayout

    /// Returns an HStack layout on iPhone in landscape.
    func test_getDetailViewLayout_iPhoneLandscape_usesHStackLayout() {
        DeviceType.debugOverride = .iPhone
        let layout = LayoutRules.getDetailViewLayout(CGSize(width: 800, height: 400))
        XCTAssertTrue(String(describing: layout).contains("HStackLayout"))
    }

    /// Returns a VStack layout on iPhone in portrait.
    func test_getDetailViewLayout_iPhonePortrait_usesVStackLayout() {
        DeviceType.debugOverride = .iPhone
        let layout = LayoutRules.getDetailViewLayout(CGSize(width: 300, height: 700))
        XCTAssertTrue(String(describing: layout).contains("VStackLayout"))
    }

    /// Returns an HStack layout on iPad in landscape.
    func test_getDetailViewLayout_iPadLandscape_usesHStackLayout() {
        DeviceType.debugOverride = .iPad
        let layout = LayoutRules.getDetailViewLayout(CGSize(width: 1200, height: 600))
        XCTAssertTrue(String(describing: layout).contains("HStackLayout"))
    }

    /// Returns a VStack layout on iPad in portrait.
    func test_getDetailViewLayout_iPadPortrait_usesVStackLayout() {
        DeviceType.debugOverride = .iPad
        let layout = LayoutRules.getDetailViewLayout(CGSize(width: 600, height: 1200))
        XCTAssertTrue(String(describing: layout).contains("VStackLayout"))
    }

    // MARK: - itemCount

    /// Returns expected values for iPhone portrait thresholds.
    func test_itemCount_iPhonePortrait_thresholds() {
        DeviceType.debugOverride = .iPhone

        // availableWidth = width - 48
        // portrait: availableWidth < 300 ? 1 : 2
        XCTAssertEqual(LayoutRules.itemCount(for: CGSize(width: 347, height: 800), isSplitted: false), 1) // 299
        XCTAssertEqual(LayoutRules.itemCount(for: CGSize(width: 348, height: 800), isSplitted: false), 2) // 300
    }

    /// Returns expected values for iPhone landscape thresholds.
    func test_itemCount_iPhoneLandscape_thresholds() {
        DeviceType.debugOverride = .iPhone

        // landscape: availableWidth < 500 ? 2 : 3
        XCTAssertEqual(LayoutRules.itemCount(for: CGSize(width: 547, height: 300), isSplitted: false), 2) // 499
        XCTAssertEqual(LayoutRules.itemCount(for: CGSize(width: 548, height: 300), isSplitted: false), 3) // 500
    }

    /// Returns expected values for iPad landscape when not split.
    func test_itemCount_iPadLandscape_notSplit_thresholds() {
        DeviceType.debugOverride = .iPad

        // landscape && !isSplitted: availableWidth < 900 ? 3 : 5
        XCTAssertEqual(LayoutRules.itemCount(for: CGSize(width: 947, height: 600), isSplitted: false), 3) // 899
        XCTAssertEqual(LayoutRules.itemCount(for: CGSize(width: 948, height: 600), isSplitted: false), 5) // 900
    }

    /// Returns expected values for iPad portrait thresholds.
    func test_itemCount_iPadPortrait_thresholds() {
        DeviceType.debugOverride = .iPad

        // portrait: availableWidth < 600 ? 2 : 3
        XCTAssertEqual(LayoutRules.itemCount(for: CGSize(width: 647, height: 1200), isSplitted: false), 2) // 599
        XCTAssertEqual(LayoutRules.itemCount(for: CGSize(width: 648, height: 1200), isSplitted: false), 3) // 600
    }

    /// Uses the non-landscape-not-split branch when iPad is split in landscape.
    func test_itemCount_iPadLandscape_splitMode_usesPortraitBranchThresholds() {
        DeviceType.debugOverride = .iPad

        // landscape but split => else branch: availableWidth < 600 ? 2 : 3
        XCTAssertEqual(LayoutRules.itemCount(for: CGSize(width: 647, height: 400), isSplitted: true), 2) // 599
        XCTAssertEqual(LayoutRules.itemCount(for: CGSize(width: 648, height: 400), isSplitted: true), 3) // 600
    }
}
