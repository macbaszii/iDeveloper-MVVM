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
  var addNewItemDidTap: Flow<String> { get }
  
}

protocol SecretListViewModelType {

  var title: Flow<String> { get }
  var items: Flow<[Item]> { get }
  
  func itemAt(index: Int) -> Item?
  func itemCount() -> Int
  
  func stringFrom(date: NSDate) -> String
  
}
