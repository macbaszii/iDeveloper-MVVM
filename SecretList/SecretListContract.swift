//
//  SecretListContract.swift
//  SecretList
//
//  Created by Kittinun Vantasin on 6/26/16.
//  Copyright © 2016 Kiattisak Anoochitarom. All rights reserved.
//

import Foundation

protocol SecretListViewType: class {

  //intent
  var addNewItemIntent: Flow<String> { get }
  var completeItemPositionIntent: Flow<Int> { get }
  
}

protocol SecretListViewModelType {

  var title: Flow<String> { get }
  var items: Flow<[Item]> { get }
  
  func itemAt(index: Int) -> Item?
  func itemCount() -> Int
  
  func attributedStringFor(text: String, completed: Bool) -> NSAttributedString
  func stringFrom(date: NSDate) -> String
  
}
