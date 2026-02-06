//
//  DeviceTypeTests.swift
//  joiefullTests
//
//  Created by Julien Cotte on 06/02/2026.
//

import XCTest
@testable import joiefull

@MainActor
final class DeviceTypeTests: XCTestCase {

    override func tearDown() {
        DeviceType.debugOverride = nil
        super.tearDown()
    }

    // MARK: - current

    /// Returns the overridden device type when override is set.
    func test_current_whenOverridden_returnsOverride() {
        DeviceType.debugOverride = .iPad
        XCTAssertEqual(DeviceType.current, .iPad)

        DeviceType.debugOverride = .iPhone
        XCTAssertEqual(DeviceType.current, .iPhone)
    }

    /// Returns the real device type when no override is set.
    func test_current_whenNoOverride_returnsSystemDevice() {
        DeviceType.debugOverride = nil

        let systemValue: DeviceType =
            UIDevice.current.userInterfaceIdiom == .pad ? .iPad : .iPhone

        XCTAssertEqual(DeviceType.current, systemValue)
    }

    // MARK: - isSplitViewEnabled

    /// Enables split view on iPad.
    func test_isSplitViewEnabled_whenIPad_returnsTrue() {
        DeviceType.debugOverride = .iPad
        XCTAssertTrue(DeviceType.isSplitViewEnabled)
    }

    /// Disables split view on iPhone.
    func test_isSplitViewEnabled_whenIPhone_returnsFalse() {
        DeviceType.debugOverride = .iPhone
        XCTAssertFalse(DeviceType.isSplitViewEnabled)
    }

    /// Reflects changes when device type changes.
    func test_isSplitViewEnabled_updatesWithCurrentDevice() {
        DeviceType.debugOverride = .iPad
        XCTAssertTrue(DeviceType.isSplitViewEnabled)

        DeviceType.debugOverride = .iPhone
        XCTAssertFalse(DeviceType.isSplitViewEnabled)
    }
}
