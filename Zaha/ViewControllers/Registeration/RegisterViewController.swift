

import UIKit
import MICountryPicker
import MOLH

class RegisterViewController: BaseViewController, StoryBoardHandler {
    static var myStoryBoard: (forIphone: String, forIpad: String?) =  (Storyboards.registeration.rawValue, nil)
    
    @IBOutlet weak var btnGoBack: UIButton!
    @IBOutlet weak var tblSignup: UITableView!
   
    var isAccepted = false
    var dataArray:NSMutableArray?
    let manager = RegisterManager()
    
    lazy var  picker = { () -> MICountryPicker in
        let pick = MICountryPicker()
         pick.showCallingCodes = true
        return pick
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        // Do any additional setup after loading the view.
    
//        if let path = Bundle.main.path(forResource: "FormData", ofType: "plist") {
//            dataArray = NSMutableArray(contentsOfFile: path);
//
//            for data:NSMutableDictionary in (dataArray as? [NSMutableDictionary])! {
//                if let cellId:String = data["cellIdentifier"] as? String {
//                    tblSignup.register(UINib.init(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
//                }
//            }
//        }
//        tblSignup.delegate = self
//        tblSignup.dataSource = self
//        tblSignup.separatorColor = .clear
        
        
        
        
    }
    func setNavBar()
    {
        self.title = "SIGNUP"
        self.navigationController?.isNavigationBarHidden = false
        
        //        let img = UIImage.init(named: "home_backArrow")?.flipIfNeeded()
        //self.addBarButtonItemWithImage(img!,CustomNavBarEnum.CustomBarButtonItemPosition.BarButtonItemPositionLeft, self, #selector(actionMenuButton))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.isNavigationBarHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        print("\(self) deallocated")
    }
    
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
  func showCountryPicker( codeData : NSMutableDictionary? , atIndex : Int) {
        
        //--ww let dataDict:NSMutableDictionary = dataArray?[atIndex] as? NSMutableDictionary
    if codeData != nil {
        picker.didSelectCountryWithCallingCodeClosure = { [weak self] name, code, dialCode in
            print(dialCode)
            codeData!["text"] = dialCode
            self?.tblSignup.reloadRows(at: [IndexPath.init(row: atIndex, section: 0)], with: .automatic)
            self?.dismiss(animated: true, completion: {
            })
        }
        
        let vc = UINavigationController.init(rootViewController: picker)
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(dismissPicker))
        picker.navigationItem.leftBarButtonItem = backButton
        self.present(vc, animated: true) {}
        }
    }
    
    @objc func dismissPicker() {
        self.dismiss(animated: true, completion: {
        })
    }
     func signupBtnTapped() {
         self.showImagePicker()
       //--ww  validateSignupForm()
   }
}


extension RegisterViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell  = UITableViewCell()
       if let dataDict:NSMutableDictionary = dataArray?[indexPath.row] as? NSMutableDictionary {
        guard let type  =  dataDict["type"] as? String , let cellID =  dataDict["cellIdentifier"] as? String  else { return cell}
        
        switch type {
        case "img" :
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! ImageTableViewCell
           return cell
        case "txt" :
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! TextFieldTableViewCell
               cell.setData(data: dataDict)
            return cell
        case "phone" :
              let cell  = tableView.dequeueReusableCell(withIdentifier: cellID) as! PhoneTableViewCell
                cell.setData(data: dataDict)
               cell.indexNo = indexPath.row
               cell.codeAction = {  [weak self] cellData , indexNo in
                
                self?.showCountryPicker(codeData: cellData , atIndex : indexNo)
              }
            return cell
            
        case "btn" :
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! ButtonTableViewCell
            cell.signupAction = { [weak self] in
               self?.signupBtnTapped()
            }
            return cell
            
        case "checkbox" :
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! AcceptCheckboxTableViewCell
            cell.showTermsPage = {[weak self] in
                guard let strongSelf = self else {return}
                router.goToTerms(from: strongSelf)
                
            }
            cell.data = dataDict
            return cell
        default:
            break
        }
    }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row  == 0{
        return DesignUtility.getValueFromRatio(180)
        }
        if indexPath.row == 6 {
           return DesignUtility.getValueFromRatio(90)
        }
        
        if indexPath.row == 7 {
            return DesignUtility.getValueFromRatio(50)
        }
        return DesignUtility.getValueFromRatio(60)
    }
}

extension RegisterViewController : UITableViewDelegate {
    
}

extension RegisterViewController: ImagePickerPresentable {
    
    func getImage(img: UIImage?) {
        
        print(img)
    }
    
    func selectedImage(data: Data?) {
        //here is your image data...
        print(data)
    }
    
    
}
