//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Zeeshan Waheed on 09/04/2024.
//

import Foundation

class ChecklistItem {
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
}


