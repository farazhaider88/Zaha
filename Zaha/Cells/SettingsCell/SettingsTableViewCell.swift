
import UIKit
import MOLH

class SettingsTableViewCell: UITableViewCell {
    

    @IBOutlet weak var viewContainer: BaseUIView!
    @IBOutlet weak var lblTitle: BaseUILabel!
    @IBOutlet weak var imgRightArrow: UIImageView!
    @IBOutlet weak var switchControll: UISwitch!
    @IBOutlet weak var btnLanguge: UIButton!
    var isAnimated = false
    var switchAction : ((_ state : Bool , _ index : Int) -> Void)?
    let selectedColor = UIColor(red: 198/255, green: 0/255, blue: 37/255, alpha: 1)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        switchControll.tag = 0
        lblTitle.tag = -1
        btnLanguge.tag = -1
    }

    
    func configCell(data : CellType) {
       
        lblTitle.text =  GlobalStatic.getLocalizedString(data.rawValue)
        imgRightArrow.image = UIImage.init(named: "right_arrow")?.flipIfNeeded()
        
        switch data {
        case .pushNotification:
            switchControll.isHidden = false
            imgRightArrow.isHidden = true
            btnLanguge.isHidden = true
         switchControll.isOn = CurrentUser.data?.notificationStatus == "1" ? true : false
    
            if switchControll.isOn{
                switchControll.thumbTintColor = selectedColor
                
            }else{
                switchControll.thumbTintColor = .lightGray
            }
            break
        case .changePwd , .logout:
            switchControll.isHidden = true
            imgRightArrow.isHidden = false
            btnLanguge.isHidden = true
            break
        case .language:
            switchControll.isHidden = true
            imgRightArrow.isHidden = true
            btnLanguge.isHidden = false
             btnLanguge.isUserInteractionEnabled = false
            
            let title =  MOLHLanguage.currentAppleLanguage() == "en" ? "English" : "عربي"
            btnLanguge.setTitle(title, for: .normal)
            break
     
       
        }
    }
    
    
    func configCellOrderInfo(data : String) {
       
           lblTitle.fontColorTheme = "darkGray"
            lblTitle.text = data
            switchControll.isHidden = true
            imgRightArrow.isHidden = false
            btnLanguge.isHidden = true
        imgRightArrow.image = UIImage.init(named: "right_arrow")?.flipIfNeeded()
    }
    
    
    
    func configCellPaymentMethod(data : String) {
        
        lblTitle.fontColorTheme = "darkGray"
        lblTitle.text = data
        switchControll.isHidden = true
        imgRightArrow.isHidden = false
        btnLanguge.isHidden = true
        viewContainer.cornerRadius = 10
        viewContainer.borderThemeColor = "grayLight"
        viewContainer.borderWidth = 1
        
    }
    
    
    
    func configCellProvideInstruction(data : (String, Bool) , indexNo : Int) {
        
        switchControll.isOn = data.1
        if switchControll.isOn{
            switchControll.thumbTintColor = selectedColor
            
        }else{
            switchControll.thumbTintColor = .lightGray
        }
        //--ww switchAction!(switchControll.isOn , switchControll.tag)
        lblTitle.fontColorTheme = "darkGray"
        lblTitle.text = data.0
        switchControll.isHidden = false
        imgRightArrow.isHidden = true
        btnLanguge.isHidden = true
        switchControll.tag = indexNo
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didChangeSwitch(_ sender: Any) {
        
        if switchControll.isOn{
             switchControll.thumbTintColor = selectedColor
         
        }else{
            switchControll.thumbTintColor = .lightGray
        }
        switchAction!(switchControll.isOn , switchControll.tag)
    }
    
    
    @IBAction func didTapOnLanguage(_ sender: Any) {
    }
    
}
