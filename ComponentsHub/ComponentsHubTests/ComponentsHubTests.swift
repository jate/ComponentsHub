//
//  ComponentsHubTests.swift
//  ComponentsHubTests
//
//  Created by JateXu on 2020/6/2.
//  Copyright © 2020 JateXu IOS Team. All rights reserved.
//

import XCTest
@testable import ComponentsHub

protocol TestProtocol {
    var name : String { get }
}
class TestClass: TestProtocol {
    var name : String = "DefaultName"
}

protocol TestProtocolNotRegister {
}

class ComponentsHubTests: XCTestCase {

    var hub = ComponentsHub.shared

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.

        hub.unregister(protocol: TestProtocol.self)
    }

    // Duplicate Register Test
    func testDuplicateRegister() throws {
        XCTAssertTrue(hub.register(protocol: TestProtocol.self) { TestClass() })

        XCTAssertFalse(hub.register(protocol: TestProtocol.self) { TestClass() })
    }

    // Duplicate Unregister Test
    func testDuplicateUnRegister() throws {
        hub.register(protocol: TestProtocol.self) { TestClass() }

        XCTAssertTrue(hub.unregister(protocol: TestProtocol.self))
        XCTAssertFalse(hub.unregister(protocol: TestProtocol.self))
    }

    func testEmptyProtocolUnregister() throws  {
        XCTAssertFalse(hub.unregister(protocol: TestProtocolNotRegister.self))
    }

    func testGetNotRegistered() throws  {
        XCTAssertNil(hub.get(protocol: TestProtocolNotRegister.self))
    }

    func testGetAlreadyHasRegistered() throws {
        hub.register(protocol: TestProtocol.self) {
            let test = TestClass()
            test.name = "Ready"
            return test
        }

        let got = hub.get(protocol: TestProtocol.self)
        XCTAssertNotNil(got)
        XCTAssertEqual(got?.name, "Ready")

        // Got Again
        let gotgot = hub.get(protocol: TestProtocol.self)
        XCTAssertFalse(got! as AnyObject === gotgot! as AnyObject)
    }

    func testGetAlreadyHasRegisteredTester() throws {
        let tester = TestClass()
        tester.name = "Testerrrr"
        hub.register(protocol: TestProtocol.self) {
            return tester
        }

        let got = hub.get(protocol: TestProtocol.self)!
        XCTAssertTrue(tester === got as AnyObject)
    }

    func testGetAfterUnregister() throws {
        hub.register(protocol: TestProtocol.self) {
            TestClass()
        }

        XCTAssertNotNil(hub.get(protocol: TestProtocol.self))

        hub.unregister(protocol: TestProtocol.self)

        let got = hub.get(protocol: TestProtocol.self)
        XCTAssertNil(got)
    }

    func testSingletonRegister() throws {
        hub.register(protocol: TestProtocol.self, singleton: true) {
            TestClass()
        }

        let got = hub.get(protocol: TestProtocol.self)
        let gotgot = hub.get(protocol: TestProtocol.self)
        XCTAssertNotNil(gotgot)
        XCTAssertNotNil(got)
        XCTAssertTrue(got! as AnyObject === gotgot! as AnyObject)
    }

    func testSingletonUnRegister() throws {
        hub.register(protocol: TestProtocol.self, singleton: true) {
            TestClass()
        }

        var got = hub.get(protocol: TestProtocol.self)
        XCTAssertNotNil(got)

        // Unregister
        hub.unregister(protocol: TestProtocol.self)

        got = hub.get(protocol: TestProtocol.self)
        XCTAssertNil(got)
    }
}
