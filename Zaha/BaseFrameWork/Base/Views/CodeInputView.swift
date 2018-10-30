import UIKit

open class CodeInputView: UIView, UIKeyInput {
     weak var delegate: CodeInputViewDelegate?
    private var nextTag = 1
    public var countCode = 0

    
    let dash = ""
    // MARK: - UIResponder

    open override var canBecomeFirstResponder : Bool {
        return true
    }

    // MARK: - UIView

    public override init(frame: CGRect) {
        super.init(frame: frame)

        // Add four digitLabels
        
        
        var frame = CGRect(x: 15, y: 10, width: 35, height: 40)
        var frameLine = CGRect(x: 15, y: self.frame.size.height - 1, width: 35, height: 1)
        for index in 1...4 {
            let digitLabel = UILabel(frame: frame)
            digitLabel.font = .systemFont(ofSize: 30)
            digitLabel.tag = index
            digitLabel.text = dash
            digitLabel.textAlignment = .center
            addSubview(digitLabel)
            
            let bottomLine = UIView.init(frame: frameLine)
            bottomLine.backgroundColor = UIColor.darkGray
            addSubview(bottomLine)
            
            frame.origin.x += 35 + 15
            frameLine.origin.x += 35 + 15
        }
        
        self.showKeyboardWhenTappedAround()
    }
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") } // NSCoding

    // MARK: - UIKeyInput

    public var hasText : Bool {
        return nextTag > 1 ? true : false
    }

    open func insertText(_ text: String) {
        if nextTag < 5 {
            (viewWithTag(nextTag)! as! UILabel).text = text
            countCode += 1
            nextTag += 1

            if nextTag == 5 {
                countCode = 4
                var code = ""
                for index in 1..<nextTag {
                    code += (viewWithTag(index)! as! UILabel).text!
                }
                delegate?.codeInputView(self, didFinishWithCode: code)
            }
        }
    }

    open func deleteBackward() {
        if nextTag > 1 {
            countCode -= 1
            nextTag -= 1
            (viewWithTag(nextTag)! as! UILabel).text = dash
        }
    }

    open func clear() {
        while nextTag > 1 {
            deleteBackward()
        }
    }

    // MARK: - UITextInputTraits

    open var keyboardType: UIKeyboardType { get { return .numberPad } set { } }
}

public protocol CodeInputViewDelegate : class{
    func codeInputView(_ codeInputView: CodeInputView, didFinishWithCode code: String)
   //--ww  func codeInputView(_ codeInputView: CodeInputView, didTypeCharcter code: String)
}

extension CodeInputView {
    func showKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.showKeyboard))
        tap.cancelsTouchesInView = true
        self.addGestureRecognizer(tap)
    }
    
    @objc func showKeyboard() {
        self.clear()
        self.becomeFirstResponder()
    }
}
