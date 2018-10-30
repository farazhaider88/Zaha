//
//  HomeViewController.swift
//

import UIKit

class HomeViewController: BaseViewController , StoryBoardHandler{
    
    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.setting.rawValue, nil)

    @IBOutlet weak var colVIewHome: UICollectionView!
    
    var headerView : ParallaxHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        colVIewHome.delegate = self
        colVIewHome.dataSource = self
   
        colVIewHome.register(UINib.init(nibName: "HeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionReusableView")
    
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden =  true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension HomeViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        cell.backgroundColor = .red
        
        return cell
    }
    
    
}
extension HomeViewController : UICollectionViewDelegate {
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      
        if headerView != nil {
        headerView.scrollViewDidScroll(scrollView: scrollView)
         
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router.goToSettingsVC(from: self)
    }
}
extension HomeViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //  return CGSize(width:self.colViewOptions.frame.width / 3 - DesignUtility.getValueFromRatio(10), height:self.colViewOptions.frame.height - DesignUtility.getValueFromRatio(10))
        
        return CGSize(width: DesignUtility.getValueFromRatio(110), height: DesignUtility.getValueFromRatio(105))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return  DesignUtility.getValueFromRatio(15)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind.isEqual(UICollectionView.elementKindSectionHeader) {
            let header  = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as! HeaderCollectionReusableView
       
            let parallaxViewFrame = CGRect(x: 0, y: 0, width: self.colVIewHome.bounds.width, height: DesignUtility.getValueFromRatio(257))
            let homeView = HomeTopView.init(frame: parallaxViewFrame)
            headerView  = ParallaxHeaderView.init(frame: parallaxViewFrame, view: homeView)
            header.addSubview(headerView)
            
            // This is neccessary to set header.clipToBounds to false for sticky header.
            header.clipsToBounds = false
            return header
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: DesignUtility.getValueFromRatio(257)) //add your height here
    }
}
