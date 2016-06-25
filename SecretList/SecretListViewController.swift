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
                let item = Item(title: field.text ?? "", createdAt: NSDate())
                self.items.append(item)
                self.tableView.reloadData()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        presentViewController(alert, animated: true, completion: nil)
    }
}
