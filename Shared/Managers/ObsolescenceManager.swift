//
//  ObsolescenceManager.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

// Relates to Market demands phase

/** Notes
 Procedure is repeated for all locomotives on game board in sequence

 Determine how many generations of that locomotive type currently exist.
 A generation exists if there are dice in either the Existing Orders boxes
 or the Customer Base boxes or in both.

 The maximum number of dice for a locomotive type and generation is
 determined by the number of boxes in the Customer Base.

 There are 4 cases of existing generations:

 a) No generation exists:
 Nothing is done for this type.

 b) 1 generation exists:
 If this locomotive type does not have the maximum number of dice, add
 one die to the Customer Base from the dice pool. Then roll all dice
 in the Customer Base and place them in the empty Existing Order boxes
 for that locomotive type.

 c) 2 generations exist:
 The players begin with the older (lower generation number) locomotive.
 Transfer one of the dice from the Customer Base to the dice pool.

 Then roll any remaining dice in the Customer Base and place them in
 the empty Existing Order boxes for that locomotive.

 This locomotive is considered old.

 The newer generation is now checked. If this loco- motive type does
 not have the maximum number of dice, add 1 die to the Customer Base
 from the dice pool. Then the dice in the Customer Base are rolled
 and placed in the empty Existing Order boxes for that locomotive.

 d) 3 generations exist:
 The players begin with the oldest (lowest generation number) locomotive.
 Place all dice from the Custo- mer Base and Existing Orders areas back
 in the dice pool. This locomotive is obsolete – there is no demand for
 this generation of that locomotive type anymore.

 The players continue with the next (middle genera- tion number)
 locomotive.

 If needed, add enough dice from the dice pool to the Customer Base to
 match the maximum number of dice for that locomotive. Then roll all
 dice in the Customer Base and place them in the empty Existing
 Order boxes for that locomotive.

 Finally, the newest (highest generation number) loco- motive is
 checked.

 If this locomotive does not have the maximum number of dice,
 add 1 die to the Cus- tomer Base from the dice pool. Then all dice
 in the Customer Base are rolled and are placed in the
 empty Existing Order boxes for that locomotive type.

 */

struct ObsolescenceManager
{
    var trains: [Train] = [Train]()

    init(trains: [Train]) {
        self.trains = trains
    }

    func handler() {
        for engineColorRef in EngineColor.allValues
        {
            guard let generations = self.findGenerationsForEngineColor(engineColor: engineColorRef) else {
                break
            }

            if (generations.count == 0) {
                print ("[gens]: No generations exist for \(engineColorRef)")
            }
            else if (generations.count == 1) {
                print ("[gens]: 1 generations exist for \(engineColorRef)")
                handleOneGeneration(trains: generations)
            }
            else if (generations.count == 2) {
                print ("[gens]: 2 generations exist for \(engineColorRef)")
                handleTwoGenerations(trains: generations)
            }
            else if (generations.count == 3) {
                print ("[gens]: 3 generations exist for \(engineColorRef)")
                handleThreeGenerations(trains: generations)
            }
            else {
                // do nothing
            }
        }
    }


    func findGenerationsForEngineColor(engineColor: EngineColor) -> [Train]? {
        let filteredTrains = trains
            .filter { (train: Train) -> Bool in
                return ( (train.engineColor == engineColor) && ((train.existingOrders.count > 0) || (train.completedOrders.count > 0)) )
            }
            .sorted { (train1: Train, train2: Train) -> Bool in
                return (train1.cost < train2.cost)
        }
        return filteredTrains
    }


    // MARK: (Private) functions

    private func handleOneGeneration(trains: [Train]) {
        assert(trains.count == 1)

        guard let firstTrain = trains.first else {
            return
        }

        if (firstTrain.hasMaximumDice == false) {
            firstTrain.orderBook.add(order: CompletedOrder.generate())
        }

        firstTrain.orderBook.rerollAndTransferCompletedOrders()
    }

    private func handleTwoGenerations(trains: [Train]) {
        assert(trains.count == 2)

        for (index, train) in trains.enumerated() {
            if (index == 0) {
                train.orderBook.removeFirstValueFromCompletedOrder()
                train.orderBook.rerollAndTransferCompletedOrders()
                train.markAsOld()
            }
            else {
                if (train.hasMaximumDice == false) {
                    train.orderBook.add(order: CompletedOrder.generate())
                }

                train.orderBook.rerollAndTransferCompletedOrders()
            }
        }
    }

    private func handleThreeGenerations(trains: [Train]) {
        assert(trains.count == 3)

        for (index, train) in trains.enumerated() {
            if (index == 0) {
                train.orderBook.clear()
                train.markAsObsolete()
            }
            else if (index == 1) {
                if (train.hasMaximumDice == false) {
                    train.orderBook.add(order: CompletedOrder.generate())
                }
                train.orderBook.rerollAndTransferCompletedOrders()
            }
            else if (index == 2) {
                if (train.hasMaximumDice == false) {
                    train.orderBook.add(order: CompletedOrder.generate())
                }
                train.orderBook.rerollAndTransferCompletedOrders()
            }
            else {
                // do nothing
            }
        }
        
    }
    
}
