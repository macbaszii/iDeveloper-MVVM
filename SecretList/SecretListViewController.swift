//
//  SecretListViewController.swift
//  SecretList
//
//  Created by Kiattisak Anoochitarom on 6/25/2559 BE.
//  Copyright © 2559 Kiattisak Anoochitarom. All rights reserved.
//

import UIKit

private let ItemCellIdentifier = "ItemCell"

class SecretListViewController: UIViewController
{
    @IBOutlet var tableView: UITableView!
    
    var items: [Item] = [] {
        didSet {
            DispatchQueue.main.async() { [weak self] in
                self?.tableView?.reloadData() } } }
}

extension SecretListViewController
{
    // MARK: - Actions
    
    @IBAction func addNewItem()
    {
        showAddNewItemAlert()
    }
}

extension SecretListViewController: UITableViewDataSource
{
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemCellIdentifier, for: indexPath)
        
        let item = items[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .mediumStyle
        dateFormatter.timeStyle = .shortStyle
        
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = dateFormatter.string(from: item.createdAt)
        
        return cell
    }
}

extension SecretListViewController: UITableViewDelegate
{
    // MARK: - UITableViewDelegate
}

extension SecretListViewController
{
    // MARK: - Alert
    
    private func showAddNewItemAlert()
    {
        let alert = UIAlertController(
            title: "Add New Item",
            message: "What are you gonna do ?",
            preferredStyle: .alert)
        
        alert.addTextField { $0.placeholder = "Title here..." }
        
        let addAlertAction = UIAlertAction(
            title: "Add",
            style: .default) { _ in
                _ = alert.textFields?
                    .first
                    .map() { Item(title: $0.text ?? "", createdAt: Date()) }
                    .map() { self.items.append($0) } }
        
        alert.addAction(addAlertAction)
        
        let cancelAlertAction = UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil)
        
        alert.addAction(cancelAlertAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}
