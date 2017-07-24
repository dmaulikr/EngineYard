//
//  Helpers.swift
//  EngineYard
//
//  Created by Amarjit on 15/12/2016.
//  Copyright © 2016 Amarjit. All rights reserved.
//

import Foundation

protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

struct ObjectCache {
    static let currencyRateFormatter: NumberFormatter = {
        var numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "en_US")
        numberFormatter.numberStyle = .currency
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.alwaysShowsDecimalSeparator = false
        return numberFormatter
    }()
}
