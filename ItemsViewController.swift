//
//  ItemsViewController.swift
//  YourHomeStuff
//
//  Created by Tyler Jasper on 8/5/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController , UITextFieldDelegate{
    
    @IBOutlet var addButton: UIButton!
    @IBOutlet var editButton: UIButton! 
    
    var itemStore: ItemStore!
    var imageStore: ImageStore! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = 65
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationItem.leftBarButtonItem = editButtonItem()
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowItem" {
            if let row = tableView.indexPathForSelectedRow?.row {
                let item = itemStore.allItems[row]
                let detailViewController = segue.destinationViewController as! ItemDetailViewController
                detailViewController.item = item
                detailViewController.imageStore = imageStore
            }
        }
    }
        
    @IBAction func addNewItem(_ sender: AnyObject) {
        // create item
        let newItem = itemStore.createItem()
        
        // figure out where that item is in the array
        if let index = itemStore.allItems.index(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        cell.updateLabels()
        let item = itemStore.allItems[indexPath.row]
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "$ \(item.valueInDollars)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove"
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // If table view is asking to commit a delete command....
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            
            let title = "Remove \(item.name)"
            let message = "Are you sure you want to remove this item?"
            
            let alertControl = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            let cancelControl = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alertControl.addAction(cancelControl)
            let deleteAction = UIAlertAction(title: "Remove", style: .destructive, handler: {
                (action) -> Void in
                self.itemStore.removeItem(item: item)
                self.imageStore.deleteImageForKey(key: item.itemKey)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            alertControl.addAction(deleteAction)
            present(alertControl, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // update model
        itemStore.moveItemAtIndex(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
}
