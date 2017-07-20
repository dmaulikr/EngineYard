//
//  BaseTests.swift
//  EngineYard
//
//  Created by Amarjit on 20/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import XCTest
import RealmSwift

class BaseTests: XCTestCase {

    override class func setUp() {
        super.setUp()
        // Called once before all tests are run
        var uniqueConfiguration = Realm.Configuration.defaultConfiguration
        uniqueConfiguration.deleteRealmIfMigrationNeeded = true
        uniqueConfiguration.inMemoryIdentifier = "tests"
        Realm.Configuration.defaultConfiguration = uniqueConfiguration
    }

    override func setUp() {
        super.setUp()
        let realm = try! Realm()
        try! realm.write { () -> Void in
            realm.deleteAll()
        }
    }
}
