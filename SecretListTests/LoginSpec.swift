//
//  LoginSpec.swift
//  SecretList
//
//  Created by Kittinun Vantasin on 6/26/16.
//  Copyright © 2016 Kiattisak Anoochitarom. All rights reserved.
//

@testable import SecretList

import Quick
import Nimble

class LoginSpec : QuickSpec {

  override func spec() {
  
    var v: LoginViewType!
    var vm: LoginViewModelType!
    
    class LoginView : LoginViewType {
      let username = Flow("")
      let password = Flow("")
      let loginDidTap = Flow<Void>()
      
      var success: (() -> Void)?
      var failure: (() -> Void)?
      
      private func handleLoginSuccess() {
        success?()
      }
      
      private func handleLoginFailure(error: NSError) {
        failure?()
      }
    }
    
    beforeEach {
      v = LoginView()
      vm = LoginViewModel(view: v)
    }
    
    describe("login is disable") {
      it("initial state") {
        expect(vm.isCredentialValid.value).to(equal(false))
      }
    
      it("input only username") {
        v.username.value = "hello"
        expect(vm.isCredentialValid.value).to(equal(false))
      }
    
      it("input only password") {
        v.password.value = "passwd"
        expect(vm.isCredentialValid.value).to(equal(false))
      }
      
      it("input both but not a valid email") {
        v.username.value = "hello"
        v.password.value = "123456"
        expect(vm.isCredentialValid.value).to(equal(false))
      }
      
      it("input both but not a valid password") {
        v.username.value = "hello@gmail.com"
        v.password.value = "11"
        expect(vm.isCredentialValid.value).to(equal(false))
      }
    }
    
    describe("login is enabled") {
      it("input both with valid username and password") {
        v.username.value = "hello@gmail.com"
        v.password.value = "123456"
        expect(vm.isCredentialValid.value).to(equal(true))
      }
      
      describe("while login is underway") {
        it("input incorrect credential, resulting in failure") {
          v.username.value = "hello@gmail.com"
          v.password.value = "123456"
          v.loginDidTap.value = Void()
        
          waitUntil(timeout: 1) { done in
            let _v = v as! LoginView
            _v.failure = { done() }
          }
        }
      
        it("input correct credential, resulting in success") {
          v.username.value = "bas@apple.com"
          v.password.value = "abcd1234"
          v.loginDidTap.value = Void()
        
          waitUntil(timeout: 1) { done in
            let _v = v as! LoginView
            _v.success = { done() }
          }
        }
        
        it("network progress is false, then true") {
          v.username.value = "test"
          v.password.value = "testtest"
          
          expect(vm.isNetworkInProgress.value).to(equal(false))
          
          v.loginDidTap.value = Void()
          
          expect(vm.isNetworkInProgress.value).to(equal(true))
          expect(vm.isNetworkInProgress.value).toEventually(equal(false), timeout: 1)
        }
      }
    }
    
    afterEach {
      v = nil
      vm = nil
    }
  }
  
}
