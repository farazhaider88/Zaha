//
//  ImagePickerHelper.swift
//

import UIKit

protocol ImagePickerPresentable: class {
    
    func showImagePicker()
    func selectedImage(data: Data?)
    func getImage(img: UIImage?)
   
}

extension ImagePickerPresentable where Self: UIViewController {
    
    fileprivate func pickerControllerActionFor(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            let pickerController           = UIImagePickerController()
            pickerController.delegate      = ImagePickerHelper.shared
            pickerController.sourceType    = type
            pickerController.allowsEditing = true
            self.present(pickerController, animated: true)
        }
    }
    
    func showImagePicker() {
        ImagePickerHelper.shared.delegate = self
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if let action = self.pickerControllerActionFor(for: .camera, title: "Take photo") {
            optionMenu.addAction(action)
        }
        if let action = self.pickerControllerActionFor(for: .photoLibrary, title: "Select from library") {
            optionMenu.addAction(action)
        }
        
        optionMenu.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(optionMenu, animated: true)
    }
}

fileprivate class ImagePickerHelper: NSObject {
    
    weak var delegate: ImagePickerPresentable?
    
    fileprivate struct `Static` {
        fileprivate static var instance: ImagePickerHelper?
    }
    
    fileprivate class var shared: ImagePickerHelper {
        if ImagePickerHelper.Static.instance == nil {
            ImagePickerHelper.Static.instance = ImagePickerHelper()
        }
        return ImagePickerHelper.Static.instance!
    }
    
    fileprivate func dispose() {
        ImagePickerHelper.Static.instance = nil
    }
    
    func picker(picker: UIImagePickerController, selectedImage data: Data?) {
        picker.dismiss(animated: true, completion: nil)
        
        self.delegate?.selectedImage(data: data)
      //  self.delegate = nil
      //  self.dispose()
    }
    
    func picker(picker: UIImagePickerController, choosenImage img: UIImage?) {
        picker.dismiss(animated: true, completion: nil)
        
        self.delegate?.getImage(img: img)
        self.delegate = nil
        self.dispose()
    }
}

extension ImagePickerHelper: UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.picker(picker: picker, selectedImage: nil)
        self.picker(picker: picker, choosenImage: nil)
    }
    

    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let data = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
                    self.picker(picker: picker, selectedImage: nil)
                    self.picker(picker: picker, choosenImage: nil)
                    return  //--ww self.picker(picker: picker, selectedImage: nil)
                }
        
        self.picker(picker: picker, selectedImage: data.pngData())
                self.picker(picker: picker, choosenImage: data)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        self.picker(picker: picker, selectedImage: image.pngData())
         self.picker(picker: picker, choosenImage: image)
    }
}

extension ImagePickerHelper: UINavigationControllerDelegate {
    
}
