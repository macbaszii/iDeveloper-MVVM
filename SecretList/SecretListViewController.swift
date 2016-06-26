//
//  SecretListViewController.swift
//  SecretList
//
//  Created by Kiattisak Anoochitarom on 6/25/2559 BE.
//  Copyright © 2559 Kiattisak Anoochitarom. All rights reserved.
//

import UIKit

private let ItemCellIdentifier = "ItemCell"

class SecretListViewController : UIViewController {

  @IBOutlet var tableView: UITableView!
  
  let addNewItemIntent = Flow<String>()
  let completeItemPositionIntent = Flow<Int>()
  
  var viewModel: SecretListViewModelType!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel = SecretListViewModel(view: self)
    
    viewModel.items.subscribe { [unowned self] _ in
      self.tableView.reloadData()
    }
    
    viewModel.title.subscribeWithCache { [unowned self] title in
      self.title = title
    }
  }
    
}

extension SecretListViewController : UITableViewDelegate {
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    completeItemPositionIntent.value = indexPath.row
  }
  
}

extension SecretListViewController :  UITableViewDataSource {

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.itemCount()
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    guard let item = viewModel.itemAt(indexPath.row) else { return UITableViewCell() }
    
    let cell = tableView.dequeueReusableCellWithIdentifier(ItemCellIdentifier, forIndexPath: indexPath)
    cell.textLabel?.attributedText = viewModel.attributedStringFor(item.title, completed: item.completed)
    cell.detailTextLabel?.attributedText = viewModel.attributedStringFor(viewModel.stringFrom(item.createdAt), completed: item.completed)
    return cell
  }
  
}

extension SecretListViewController {

  @IBAction func addNewItem() {
    let alert = UIAlertController(title: "Add New Item", message: "What are you gonna do?", preferredStyle: .Alert)
    alert.addTextFieldWithConfigurationHandler { textField in
      textField.placeholder = "Title here..."
    }
    
    alert.addAction(UIAlertAction(title: "Add", style: .Default) { [unowned self] action in
      guard let textField = alert.textFields?.first else { return }
      self.addNewItemIntent.value = textField.text
    })
    
    alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
    
    presentViewController(alert, animated: true, completion: nil)
  }
  
}

extension SecretListViewController : SecretListViewType {}
