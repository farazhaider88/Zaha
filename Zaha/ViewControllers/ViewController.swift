//
//  ViewController.swift
//




import UIKit

class ViewController: BaseViewController , StoryBoardHandler{
    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.main.rawValue, nil)
    
    var closure: (()->())!
    
  
    
    // MARK: - Properties
    
    var titleHeader = "Home Form"
    
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var saveButton: UIButton!
    
    @IBOutlet var textFields: [UITextField]!
    
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = titleHeader
        saveButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        
         closure = { [weak self] in

        self?.capturingSelf()
        }
        
        
    }
    
    
    func capturingSelf()  {
        print("capturingSelf()")
    }
    
    
    deinit {
        print("ViewController dealloc")
    }
    
    @objc func submitTapped() {
        let fv = FormValidator()
        do {
            let fname = try fv.validateFName(text: firstNameTextField.text ?? "")
            let lname = try fv.validateLName(text: lastNameTextField.text ?? "")
            let email = try fv.validateEmail(text: emailTextField.text ?? "")
            let pass = try fv.validatePassword(text: passwordTextField.text ?? "")
         
            let params = "First Name : \(fname) \n Last Name : \(lname) \n Email : \(email) \n Password : \(pass) \n"
           
           Alert.showMsg(msg: params)
            
        } catch {
          
             Alert.showMsg(msg: "\(error)")
            
        }
    }
}




