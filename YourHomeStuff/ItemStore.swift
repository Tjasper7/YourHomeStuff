//
//  ItemStore.swift
//  YourHomeStuff
//
//  Created by Tyler Jasper on 8/5/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import UIKit

class ItemStore {
    var allItems = [Item]()
    
    let itemArchiveURL: URL = {
       let documentsDirectories = FileManager.default().urlsForDirectory(.documentDirectory, inDomains: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
       return try! documentDirectory.appendingPathComponent("items.archive")
    }()
    
    init() {
        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path!) as? [Item] {
            allItems += archivedItems
        }
    }
    
    func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    
    func removeItem(item: Item) {
        if let index = allItems.index(of: item) {
            allItems.remove(at: index)
        }
    }
    
    func moveItemAtIndex(fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        // get reference to object being moved so you can reinsert it 
        let movedItem = allItems[fromIndex]
        
        // remove item from array 
        allItems.remove(at: fromIndex)
        
        // insert item in array at new location
        allItems.insert(movedItem, at: toIndex)
        
    }
    
    func saveChanges() -> Bool {
        print("Saving items to: \(itemArchiveURL.path)")
        if itemArchiveURL.path != nil {
        return NSKeyedArchiver.archiveRootObject(allItems, toFile: itemArchiveURL.path!)
        } else {
            print("Error saving items to: \(itemArchiveURL.path)")
            return false
        }
    }
}
