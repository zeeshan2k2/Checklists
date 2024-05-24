//
//  Checklist.swift
//  Checklists
//
//  Created by Zeeshan Waheed on 24/05/2024.
//

import UIKit

class Checklist: NSObject {
    var name  = ""
    
    init(name: String = "") {
        self.name = name
        super.init()
    }
}
