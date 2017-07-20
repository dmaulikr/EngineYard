//
//  GameConfig.swift
//  EngineYard
//
//  Created by Amarjit on 15/12/2016.
//  Copyright © 2016 Amarjit. All rights reserved.
//

import Foundation

struct GameConfig {
    static var hasTimer : Bool = false
    static var timerSeconds: Float = 60.0
    static var debugMode : Bool = false

    public fileprivate(set) var shouldShuffleTurnOrder: Bool = false  // TODO: Change to true by default; apply UI
    public fileprivate(set) var hasSound: Bool = false {
        didSet {
            // #TODO - update sound
        }
    }
    public fileprivate(set) var hasMusic: Bool = false {
        didSet {
            // #TODO - update music
        }
    }
}

extension GameConfig {

    mutating func toggleShuffleTurnOrder() {
        self.shouldShuffleTurnOrder = !self.shouldShuffleTurnOrder
    }

    mutating func toggleHasSound() {
        self.hasSound = !self.hasSound
    }

    mutating func toggleHasMusic() {
        self.hasMusic = !self.hasMusic
    }

}
