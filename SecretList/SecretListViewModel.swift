//
//  SecretListViewModel.swift
//  SecretList
//
//  Created by Kittinun Vantasin on 6/26/16.
//  Copyright © 2016 Kiattisak Anoochitarom. All rights reserved.
//

import Foundation
import UIKit.NSAttributedString

class SecretListViewModel {

  let title = Flow("No Item")
  let items = Flow([Item]())
  
  weak var view: SecretListViewType?
  
  init(view: SecretListViewType) {
    self.view = view
   
    view.addNewItemIntent.subscribe { [unowned self] newTitle in
      let newItem = Item(title: newTitle ?? "", createdAt: NSDate(), completed: false)
      
      var items = self.items.value!
      items.append(newItem)
      self.items.value = items
      self.title.value = self.titleForItems(items)
    }
    
    view.completeItemPositionIntent.subscribe { [unowned self] position in
      guard let position = position else { return }
      
      var items = self.items.value!
      let item = items[position]
      item.completed = !item.completed
      items[position] = item
      
      self.items.value = items
      self.title.value = self.titleForItems(items)
    }
  }
  
  private func titleForItems(items: [Item]) -> String {
    let completed = items.filter { $0.completed }.count
    switch (completed, items.count) {
    case (_, 0):
      return "No Item"
    case let (x, y) where x == y:
      return "All completed"
    case let (x, y):
      return "Items (\(x)/\(y))"
    }
  }
  
}

extension SecretListViewModel : SecretListViewModelType {

  func itemAt(index: Int) -> Item? {
    return items.value?[index]
  }
  
  func itemCount() -> Int {
    return items.value?.count ?? 0
  }
  
  func attributedStringFor(text: String, completed: Bool) -> NSAttributedString {
    let style = completed ? NSUnderlineStyle.StyleSingle.rawValue : NSUnderlineStyle.StyleNone.rawValue
    let color = completed ? UIColor.lightGrayColor() : UIColor.blackColor()
    let attributes = [NSStrikethroughStyleAttributeName : style,
                      NSForegroundColorAttributeName : color]
    return NSAttributedString(string: text, attributes: attributes)
  }
  
  func stringFrom(date: NSDate) -> String {
    struct Instance {
      static let formatter = NSDateFormatter()
    }
    
    Instance.formatter.dateStyle = .MediumStyle
    Instance.formatter.timeStyle = .ShortStyle

    return Instance.formatter.stringFromDate(date)
  }
  
}
