//
//  ButtonTableViewCell.swift
//  Test
//
//

import UIKit

class ButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var btnSignUp: CustomButton!
    var signupAction : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func doSignUp(_ sender: CustomButton) {
        signupAction!()
    }
}
