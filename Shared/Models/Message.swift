//
//  Message.swift
//  EngineYard
//
//  Created by Amarjit on 03/08/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

// Generic message struct used for in-game messages, game-logs, etc

protocol MessageProtocol {
    var title: String? { get set }
    var message: String? { get set }
}

struct Message : MessageProtocol {
    var title: String?
    var message: String?
    private let dateCreated: Date = Date.init(timeIntervalSinceNow: 0)

    init(title: String?, message: String?) {
        if let hasTitle = title {
            self.title = hasTitle
        }
        if let hasMessage = message {
            self.message = hasMessage
        }
    }
}
