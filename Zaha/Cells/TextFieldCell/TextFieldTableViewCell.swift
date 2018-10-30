
import UIKit

class TextFieldTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var txtField: BaseUITextField!
    var data:NSMutableDictionary?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        txtField.delegate = self
        txtField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:Any?) {
        
        if let dict = data as? NSMutableDictionary  {
            self.data = dict
            
            if let imgName:String = self.data!["image"] as? String  {
                self.txtField.leftImage = UIImage.init(named: imgName)
               //--ww  self.txtField.leftImage = nil
            }
            
            
            if let placeholder:String = self.data!["placeholder"] as? String {
              self.txtField.placeholder = placeholder
            }
            if let text:String = self.data!["text"] as? String {
               self.txtField.text = text
            }
            
            if let kind:String = self.data!["kind"] as? String {
                
                switch kind{
                case "email" :
                    txtField.keyboardType = .emailAddress
                default:
                    txtField.keyboardType = .default
                }
           
            }
        }
    }

}
extension TextFieldTableViewCell : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       /* if (self.data != nil){
            self.data!["text"] = textField.text;
        }
     */
}
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if let typedText = textField.text {
          if (self.data != nil){
                    self.data!["text"] = typedText
            }
         }
        
    }
}

