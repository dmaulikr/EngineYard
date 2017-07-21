//
//  Obsolescence.swift
//  EngineYard
//
//  Created by Amarjit on 21/07/2017.
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

struct Obsolescence
{
    var trains: [Locomotive] = [Locomotive]()

    init(trains: [Train]) {
        self.trains = trains
    }

    func handler() {
        for engineColorRef in EngineColor.allValues
        {
            guard let generations = self.filterTrainsOnColorWithOrders(engineColor: engineColorRef) else {
                break
            }

            if (generations.count == 0) {
                print ("No generations exist")
            }
            else if (generations.count == 1) {
                print ("1 generations exist")
                handleOneGeneration(trains: generations)
            }
            else if (generations.count == 2) {
                print ("2 generations exist")
                handleTwoGenerations(trains: generations)
            }
            else if (generations.count == 3) {
                print ("3 generations exist")
                handleThreeGenerations(trains: generations)
            }
            else {
                // do nothing
            }
        }
    }

    func handleOneGeneration(trains: [Train]) {
        assert(trains.count == 1)

        guard let firstTrain = trains.first else {
            return
        }

        if (firstTrain.hasMaximumDice()) {
            firstTrain.orderBook.rerollAndTransferCompletedOrders()
            firstTrain.orderBook.add(order: ExistingOrder.init(value: Die.roll()))
        }
    }

    func handleTwoGenerations(trains: [Train]) {
        assert(trains.count == 2)
    }

    func handleThreeGenerations(trains: [Train]) {
        assert(trains.count == 3)
    }

    func filterTrainsOnColorWithOrders(engineColor: EngineColor) -> [Train]? {
        let filteredTrains = trains
            .filter { (loco:Locomotive) -> Bool in
                return ( (loco.engineColor == engineColor) && ((loco.existingOrders.count > 0) || (loco.completedOrders.count > 0)) )
            }
            .sorted { (loco1:Locomotive, loco2:Locomotive) -> Bool in
                return (loco1.cost < loco2.cost)
        }
        return filteredTrains
    }
}
