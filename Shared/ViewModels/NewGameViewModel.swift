//
//  NewGameViewModel.swift
//  EngineYard
//
//  Created by Amarjit on 31/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

protocol StepperProtocol {
    func didUpdateStepperValue()
}

class NewGameViewModel
{
    var delegate: StepperProtocol?

    private(set) var players:[Player] = [Player]()
    private(set) var playersCopy:[Player] = [Player]()

    var oldStepperValue:Int! {
        didSet {
            delegate?.didUpdateStepperValue()
        }
    }

    init(playerCount:Int = Constants.NumberOfPlayers.max) {
        self.oldStepperValue = playerCount

        for idx:Int in 1...playerCount {
            let name = "Player #\(idx)"
            let filename = "avt_\(idx)"

            var isAI: Bool = true
            if (idx == 1) {
                isAI = false
            }

            let playerObj = Player.init(name: name, isAI: isAI, asset: filename)
            self.players.append(playerObj)
        }
    }

    func addPlayer()
    {
        if (self.players.count < Constants.NumberOfPlayers.max) {
            if let lastPlayerCopy = playersCopy.last {
                self.players.append(lastPlayerCopy)
                self.playersCopy.removeLast()
            }
        }
    }

    func removePlayer()
    {
        if (self.players.count > Constants.NumberOfPlayers.min) {
            if let lastPlayer = self.players.last {
                self.playersCopy.append(lastPlayer)
                self.players.removeLast()
            }
        }
    }

    public var stepperLabelText: String {
        return NSLocalizedString("\(players.count) Players", comment: "Label for number of players in game")
    }

    public func setStepperValue(value: Int) {
        if value > self.oldStepperValue {
            self.addPlayer()
        }
        else {
            self.removePlayer()
        }
        self.oldStepperValue = value
    }
}
