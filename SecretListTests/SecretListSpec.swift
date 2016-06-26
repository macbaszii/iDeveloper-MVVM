//
//  SecretListSpec.swift
//  SecretList
//
//  Created by Kittinun Vantasin on 6/26/16.
//  Copyright © 2016 Kiattisak Anoochitarom. All rights reserved.
//

@testable import SecretList

import Quick
import Nimble

class SecretListSpec : QuickSpec {

  override func spec() {
    var v: SecretListViewType!
    var vm: SecretListViewModelType!
    
    class SecretListView : SecretListViewType {
      var addNewItemIntent = Flow<String>()
      var completeItemPositionIntent = Flow<Int>()
    }
    
    beforeEach {
      v = SecretListView()
      vm = SecretListViewModel(view: v)
    }
    
    describe("initial state") {
      it("list is empty") {
        expect(vm.items.value).to(beEmpty())
      }
      
      it("title is no item") {
        expect(vm.title.value).to(equal("No Item"))
      }
    }
    
    describe("after add item") {
      beforeEach {
        v.addNewItemIntent.value = "Hello"
      }
      
      it("list is added") {
        expect(vm.items.value).to(haveCount(1))
      }
      
      it("title is updated") {
        expect(vm.title.value).to(equal("Items (0/1)"))
      }
      
      describe("complete an item") {
        it("such item is completed") {
          v.addNewItemIntent.value = "Another Hello"
          v.completeItemPositionIntent.value = 1
          
          expect(vm.items.value![1].completed).to(equal(true))
        }
      }
      
      describe("complete all items") {
        beforeEach {
          v.completeItemPositionIntent.value = 0
        }
        
        it("such item is completed") {
          expect(vm.items.value).to(allPass { $0?.completed == true })
        }
        
        it("title is updated") {
          expect(vm.title.value).to(equal("All completed"))
        }
      }
    }
    
    afterEach {
      v = nil
      vm = nil
    }
  }
  
}

