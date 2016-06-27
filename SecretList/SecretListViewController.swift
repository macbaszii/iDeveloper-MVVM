//
//  SecretListViewController.swift
//  SecretList
//
//  Created by Kiattisak Anoochitarom on 6/25/2559 BE.
//  Copyright © 2559 Kiattisak Anoochitarom. All rights reserved.
//

import UIKit

private let ItemCellIdentifier = "ItemCell"

class SecretListViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    var items = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchItems { 
            self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
        }
    }
    
    // MARK: - Actions
    @IBAction func addNewItem() {
        showAddNewItemAlert()
    }
}

// MARK: - UITableView Protocol Conformance
extension SecretListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(ItemCellIdentifier, forIndexPath: indexPath)
        
        let item = items[indexPath.row]
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.timeStyle = .ShortStyle
        
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = dateFormatter.stringFromDate(item.createdAt)
        
        return cell
    }
}

extension SecretListViewController {
    // MARK: - Internal Methods
    
    private func showAddNewItemAlert() {
        let alert = UIAlertController(title: "Add New Item", message: "What are you gonna do ?", preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Title here..."
        }
        
        alert.addAction(UIAlertAction(title: "Add", style: .Default, handler: { (action) in
            
            if let field = alert.textFields?.first {
                self.addNewItem(with: field.text)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    private func addNewItem(with title: String?) {
        guard let title = title where title.isEmpty == false else { return }
        
        let newItem = Item(title: title, createdAt: NSDate())
        APIManager.sharedManager.add(item: newItem) { (item, error) in
            if let error = error {
                self.showAlert(with: error)
            } else {
                self.fetchItems(completion: { 
                    let latestIndexPath = NSIndexPath(forRow: self.items.count - 1, inSection: 0)
                    self.tableView.insertRowsAtIndexPaths([latestIndexPath], withRowAnimation: .Automatic)
                })
            }
        }
    }
    
    private func fetchItems(completion completion: () -> ()) {
        APIManager.sharedManager.allItems { (items, error) in
            if let error = error {
                self.showAlert(with: error)
            } else {
                self.items = items
                completion()
            }
        }
    }
}
