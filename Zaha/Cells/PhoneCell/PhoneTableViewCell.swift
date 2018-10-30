

import UIKit

class PhoneTableViewCell: UITableViewCell {

    @IBOutlet weak var txtCode: BaseUITextField!
    @IBOutlet weak var txtNumber: BaseUITextField!
    
    var indexNo = 0
     var data:NSMutableDictionary?
    var codeAction : (( _ data:NSMutableDictionary? , _ atIndex : Int)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        txtCode.isUserInteractionEnabled = false
        txtNumber.delegate = self
        txtNumber.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtNumber.keyboardType = .asciiCapableNumberPad
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:Any?) {
        
        if let dict = data as? NSMutableDictionary  {
            self.data = dict
            
            if let imgName:String = self.data!["image"] as? String  {
                self.txtCode.leftImage = UIImage.init(named: imgName)
            }
            
            
            if let placeholder:String = self.data!["placeholder"] as? String {
                self.txtCode.placeholder = placeholder
            }
            
            if let placeholder:String = self.data!["placeholderNo"] as? String {
                self.txtNumber.placeholder = placeholder
            }
            if let text:String = self.data!["text"] as? String {
                self.txtCode.text = text
            }
            
            if let text:String = self.data!["textNo"] as? String {
                self.txtNumber.text = text
            }
        }
    }
    
    
    @IBAction func showCountryCodePicker(_ sender: UIButton) {
        codeAction!(self.data, self.indexNo)
    }
}

extension PhoneTableViewCell : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        /* if (self.data != nil){
         self.data!["text"] = textField.text;
         }
         */
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if let typedText = textField.text {
            if (self.data != nil){
                self.data!["textNo"] = typedText
            }
        }
        }
}
