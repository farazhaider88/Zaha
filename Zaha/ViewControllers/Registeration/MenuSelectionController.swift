//
//  MenuSelectionController.swift
//  Zaha
//
//  Created by Soomro Shahid on 11/4/18.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit
import ISPageControl

class MenuSelectionController: UIViewController, StoryBoardHandler {

    @IBOutlet weak var pageControl: ISPageControl!
    let images: [UIImage] = [#imageLiteral(resourceName: "login_background.png"),#imageLiteral(resourceName: "login_background"),#imageLiteral(resourceName: "login_background")]
    
    static var myStoryBoard: (forIphone: String, forIpad: String?) =  (Storyboards.registeration.rawValue, nil)
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.numberOfPages = images.count
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool)
    {
        setNavBar()
    }
    
    func setNavBar()
    {
        self.title = ""
        self.navigationController?.isNavigationBarHidden = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
class PagingCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imgPaging: UIImageView!
}

extension MenuSelectionController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pagingCell", for: indexPath) as! PagingCollectionCell
        cell.imgPaging.image = images[indexPath.item]
        return cell
    }
}

extension MenuSelectionController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
}

extension MenuSelectionController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
//        pageControl.currentPage = Int(pageNumber)
    }
}
