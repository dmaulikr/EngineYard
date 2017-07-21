//
//  DataManager.swift
//  EngineYard
//
//  Created by Amarjit on 18/05/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation
import ObjectMapper

final class DataManager {

    public static func loadJSON(taskCallback: @escaping (Bool, Error?, Array<Dictionary<String, AnyObject>>?) -> ()) {
        // request file
        DataManager.requestLocalJSONFile { (success, error, data) -> Void in
            if (success) {
                // Get JSON response
                let json = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as!  Array<Dictionary<String, AnyObject>>
                taskCallback(true, nil, json)
            }
            else {
                taskCallback(false, error, nil)
            }
        }
    }

    fileprivate static func requestLocalJSONFile(taskCallback: @escaping (Bool, Error?, Data?) -> ()) {
        // Get the file path for the file "data.json" in the bundle
        let filePath = Bundle.main.path(forResource: "data", ofType: "json")

        do {
            let url:URL = URL(fileURLWithPath: filePath!)
            print("Attempting URL: \(url)")

            let allData = try Data(contentsOf: url)
            taskCallback(true, nil, allData)
        }
        catch {
            print ("** Error in reading JSON **")
            let err = NSError(domain: "** Error in reading JSON **", code: 0, userInfo: nil)
            taskCallback(false, err, nil)
            
        }
    }
}

extension DataManager {

    // #TODO
    public static func saveToPersitenceLayer() {

    }

    public static func loadFromPersistenceLayer() {

    }

}

