//
//  AcceptCheckboxTableViewCell.swift
//  Test
//

//

import UIKit

class AcceptCheckboxTableViewCell: UITableViewCell {

    @IBOutlet weak var btnAccept: BaseUIButton!
     var isAccepted = false
    var showTermsPage : (()->())?
    var data:NSMutableDictionary?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func checkBoxAction(_ sender: Any) {
        if isAccepted == false {
             isAccepted = true
            btnAccept .setImage(UIImage.init(named: "checkbox-sel"), for: .normal)
        }else{
            isAccepted = false
            btnAccept .setImage(UIImage.init(named: "checkbox"), for: .normal)
        }
        
        if (self.data != nil){
            self.data!["isAccept"] = isAccepted
        }
    }
    
    @IBAction func showTerms(_ sender: Any) {
        
        showTermsPage!()
    }
}
