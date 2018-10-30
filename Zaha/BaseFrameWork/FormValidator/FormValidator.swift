//
//  FormValidator.swift


import UIKit
public class FormValidator {
    
    func validateForm() {
        
    }
    
    
    func validateText(_ text : String? , rules : [FormError]) throws -> String {
        
        for rule in rules{
            
            switch rule {
            case .empty( let name):
                guard let tx = text , !tx.isEmptyStr() else {
                    throw FormError.empty(name: name)
                }
                break
            case .onlyAlphabets(let name):
                guard let tx = text , tx.isAlphabetOnly else {
                    throw FormError.onlyAlphabets(name: name)
                }
                break
            case .minimumLength(let name, let value):
                print(name, value)
                guard let tx = text , tx.count >= value else {
                    throw FormError.minimumLength(name: name, len: value)
                }
                break
            case .maximumLength(let name , let value):
                print(name ,value)
                guard let tx = text , tx.count <= value else {
                    throw FormError.maximumLength(name: name, len: value)
                }
                break
            case .validEmail:
               guard let tx = text , tx.isValidEmail() else {
                    throw FormError.validEmail
                }
                break
                
            case .onlyNumbers:
                guard let tx = text , tx.isNumeric() else {
                    throw FormError.onlyNumbers
                }
                break
                
            case .shouldAlphaNumeric(let name):
                guard let tx = text , tx.isContainNumbers , tx.isContainsLetters else {
                    throw FormError.shouldAlphaNumeric(name: name)
                }
                break
                
            case .isContainsWhitespace(let name):
                guard let tx = text , !tx.isContainsWhitespace else {
                    throw FormError.isContainsWhitespace(name: name)
                }
                break
            default:
                break
            }
            
            
        }
        
        return text ?? ""
    }
    
    
    func validateName(title: String , text : String) -> (Bool , String) {
        do {
        let name = try validateText(text, rules: [.empty(name:title),.onlyAlphabets(name: text), .minimumLength(name: title, len: 3), .maximumLength(name : title , len: 10)])
             return (true,name)
        }catch{
          return (false,"\(error)")
        }
    }
    
    
    
    func validateEmail(title: String = "Email", text : String) -> (Bool , String) {
          do {
         let email = try validateText(text, rules: [.empty(name:title), .validEmail])
             return (true, email)
          }catch{
          return (false,"\(error)")
        }
    }
    
    func validateCode(title: String = "Code", text : String) -> (Bool , String) {
        do {
            let code = try validateText(text, rules: [.empty(name:title)])
            return (true, code)
        }catch{
            return (false,"\(error)")
        }
    }
    
    
    func validatePhoneNo(title: String = "Phone No", text : String) -> (Bool , String) {
        do {
            let phone = try validateText(text, rules: [.empty(name:title), .onlyNumbers , .minimumLength(name: title, len: Constants.minimumLengthNumber) , .maximumLength(name: title, len: Constants.maximumLengthNumber)])
            return (true, phone)
        }catch{
            return (false,"\(error)")
        }
    }
    
    
    func validatePassword(title: String = "Password", text : String) -> (Bool , String) {
        do {
            let pwd = try validateText(text, rules: [.empty(name:title), .minimumLength(name: title, len: Constants.minimumLengthPwd) , .maximumLength(name: title, len: Constants.maximumLengthPwd), .shouldAlphaNumeric(name: title), .isContainsWhitespace(name: title)])
            return (true, pwd)
        }catch{
            return (false,"\(error)")
        }
    }
    
    
    func validateConfirmPassword(title: String = "Confirm Password", pwd : String , cpwd : String ) -> (Bool , String) {
        if cpwd.isEmptyStr() {
            return (false,"\(title) must not be empty")
        }
        else if !(cpwd.elementsEqual(pwd)) {
             return (false,"Password and confirm password are not same")
         
        } else {
           return (true, cpwd)
        }
    }
    
    
    func validateAcceptTerm(title: String = "Accept Terms", status : Bool) -> (Bool , String) {
        if status == true {
            return (true, "")
        } else {
            return (false,"Kindly accept terms and conditions")
        }
    }
    
    func validateFName(title: String = "First Name" ,text : String) throws -> String {
       return try validateText(text, rules: [.empty(name:title),.onlyAlphabets(name: title), .minimumLength(name: title, len: 3), .maximumLength(name : title , len: 10)])
    }
  
    
    func validateLName(title: String = "Last Name" , text : String) throws -> String {
      return try validateText(text, rules: [.empty(name:title),.onlyAlphabets(name: title), .minimumLength(name: title, len: 3), .maximumLength(name : title , len: 10)])
    }
    
    func validateEmailWithThrow(title: String = "Email", text : String) throws -> String {
        return try validateText(text, rules: [.empty(name:title), .validEmail])
    }
    
    
    func validatePasswordWithThrow(title: String = "Password", text : String) throws -> String {
        return try validateText(text, rules: [.empty(name:title), .minimumLength(name: title, len: 6) , .maximumLength(name: title, len: 12) , .shouldAlphaNumeric(name: title)])
    }
}
