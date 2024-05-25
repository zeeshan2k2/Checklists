//
//  Datamodel.swift
//  Checklists
//
//  Created by Zeeshan Waheed on 24/05/2024.
//

import Foundation

class DataModel {
    var lists = [Checklist]()
    
    var indexOfSelectedCheckList: Int {
        get {
            return UserDefaults.standard.integer(forKey: "ChecklistIndex")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "ChecklistIndex")
            UserDefaults.standard.synchronize()
        }
    }
  
    init() {
        loadChecklists()
        registerDefaults()
        handleFirstTime()
    }
  
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
  
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent(
          "Checklists.plist")
    }
  
    func saveChecklists() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(lists)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
        } catch {
            print("Error encoding item array: \(error.localizedDescription)")
        }
    }
  
    func loadChecklists() {
        let path = dataFilePath()
            if let data = try? Data(contentsOf: path) {
                let decoder = PropertyListDecoder()
                do {
                    lists = try decoder.decode([Checklist].self, from: data)
                } catch {
                    print("Error decoding list array: \(error.localizedDescription)")
                }
            }
    }
    
    func registerDefaults() {
        let dictionary = ["ChecklistIndex": -1, "FirstTime": true] as [String: Any]
        UserDefaults.standard.register(defaults: dictionary)
    }
    
    func handleFirstTime() {
        let userDefaults = UserDefaults.standard
        let firstTime = userDefaults.bool(forKey: "FirstTime")

        if firstTime {
            let checklist = Checklist(name: "List")
            lists.append(checklist)

            indexOfSelectedCheckList = 0
            userDefaults.set(false, forKey: "FirstTime")
            userDefaults.synchronize()
        }
    }
}