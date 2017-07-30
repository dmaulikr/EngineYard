//
//  LocomotiveCard.swift
//  EngineYard
//
//  Created by Amarjit on 20/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation
import ObjectMapper

//typealias Locomotive = LocomotiveCard

final class LocomotiveCard : NSObject {
    weak var parent: Train?
    weak var owner: Player?
    //lazy var production = Production.init(parent: self)

    override var description: String {
        return ("Engine.parent: \(self.parent?.name), Owner: \(self.owner?.name) - Production: \(self.production.description)")
    }
}

extension LocomotiveCard {
    /*
    func assignOwner(player: Player) {
        self.production.setDefaultProduction()
        self.owner = player
    }
    */
}


/**
final class Locomotive : NSObject, TrainProtocol {
    let uuid: String = UUID().uuidString
    public private(set) var name: String = ""
    public private(set) var generation: Generation = .first
    public private(set) var engineColor: EngineColor = .green
    public private(set) var cost: Int = 0
    public private(set) var productionCost: Int = 0
    public private(set) var income: Int = 0

    lazy var orderBook: OrderBook = OrderBook(parent: self) // order book & completedOrders book
    var existingOrders: [Int] {
        return orderBook.existingOrders.flatMap({ (e:ExistingOrder) -> Int in
            return e.value
        })
    }
    var completedOrders: [Int] {
        return orderBook.completedOrders.flatMap({ (c:CompletedOrder) -> Int in
            return c.value
        })
    }

    public private(set) var capacity: Int = 0
    public private(set) var numberOfChildren: Int = 0

    var engines: [Engine] = [Engine]()
    var owners: [Player]? {
        let filtered = self.engines.filter { (eng:Engine) -> Bool in
            return (eng.owner != nil)
            }
            .sorted { (engA:Engine, engB:Engine) -> Bool in
                return ((engA.owner?.turnOrder)! < (engB.owner?.turnOrder)!)
            }.flatMap { (eng:Engine) -> Player? in
                return (eng.owner)
        }

        return filtered
    }

    // # Obsolescence variables
    public fileprivate(set) var isRusting : Bool = false {
        didSet {
            print ("\(self.name) is rusting")
        }
    }
    public fileprivate(set) var hasRusted: Bool = false {
        didSet {
            print ("\(self.name) has rusted - OBSOLETE")
        }
    }

    var isUnlocked: Bool {
        return ((self.existingOrders.count > 0) || (self.completedOrders.count > 0))
    }

    override var description: String {
        var returnString = "Train: \(self.name), orders: \(self.existingOrders), completedOrders: \(self.completedOrders)"
        if (self.isRusting) {
            returnString = returnString.appending(" - OLD -")
        }
        if (self.hasRusted) {
            returnString = returnString.appending(" ** OBSOLETE **")
        }
        if (self.isUnlocked) {
            returnString = returnString.appending(" [Unlocked]")
        }
        returnString = returnString.appending("\(self.cost), \(self.productionCost) \(self.income)")
        return returnString
    }

    // MARK: - Initializer

    init(name:String, cost: Int, generation:Generation, engineColor:EngineColor, capacity:Int, numberOfChildren:Int) {
        super.init()
        assert(cost % 4 == 0, "Cost must be modulus of 4")

        self.name = name
        self.cost = cost
        self.productionCost = Int(cost / 2)
        self.income = Int(productionCost / 2)
        self.generation = generation
        self.engineColor = engineColor
        self.capacity = capacity
        self.numberOfChildren = numberOfChildren

        EngineAPI.createEnginesFor(train: self)
    }

}

extension Locomotive {

    // The maximum number of dice for a locomotive type and generation is determined by the number of boxes in the Customer Base.
    func hasMaximumDice() -> Bool {
        return (self.orderBook.completedOrders.count >= self.capacity)
    }

    func markAsOld() {
        self.isRusting = true
    }

    func markAsObsolete() {
        self.hasRusted = true
    }

    func purchase(buyer: Player) {
        if (LocomotiveAPI.canPurchase(train: self, player: buyer).0) {

            let remainingEngines = self.engines.filter({ (eng: Engine) -> Bool in
                return (eng.owner == nil) && (eng.parent == self)
            })

            print ("There are \(remainingEngines.count) remaining unowned engines in \(self.name)")

            guard let firstUnownedEngine = remainingEngines.first else {
                print("No engine found")
                assertionFailure()
                return
            }

            buyer.account.debit(amount: self.cost)
            firstUnownedEngine.assignOwner(player: buyer)

            print ("\(buyer.name) purchased \(self.name) for $\(self.cost). Remaining cash: \(buyer.account.balance)")

            // only unlock the next one if possible
            if ( (remainingEngines.count == self.numberOfChildren) && (remainingEngines.count == self.engines.count) ) {

                // Post notification
                print ("Firing notification")
                NotificationCenter.default.post(name: .boughtTrainNotificationId, object: nil)
            }
        }
    }
}
**/
