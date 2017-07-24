//
//  EY+Time.swift
//  EngineYard
//
//  Created by Amarjit on 21/06/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation
import SVProgressHUD

func waitFor(duration: TimeInterval, callback: @escaping (Bool) -> ()) {
    SVProgressHUD.show()
    let when = DispatchTime.now() + duration
    DispatchQueue.main.asyncAfter(deadline: when) {
        SVProgressHUD.dismiss()
        callback(true)
    }
}
