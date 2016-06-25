//
//  SecretListViewModel.swift
//  SecretList
//
//  Created by Kittinun Vantasin on 6/26/16.
//  Copyright © 2016 Kiattisak Anoochitarom. All rights reserved.
//

import Foundation

class SecretListViewModel : SecretListViewModelType {

  let title = Flow("No Item")
  let items = Flow([Item]())
  
  weak var view: SecretListViewType?
  
  init(view: SecretListViewType) {
    self.view = view
   
    view.addNewItemDidTap.subscribe { [unowned self] newTitle in
      let newItem = Item(title: newTitle ?? "", createdAt: NSDate())
      
      var items = self.items.value
      items?.append(newItem)
      self.items.value = items
      
      self.title.value = "Items (\(items!.count))"
    }
  }
  
  func itemAt(index: Int) -> Item? {
    return items.value?[index]
  }
  
  func itemCount() -> Int {
    return items.value?.count ?? 0
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
