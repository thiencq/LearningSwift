//
//  ImageListViewController.swift
//  LoadingImageFromBundle
//
//  Created by Thien Chu on 4/1/17.
//  Copyright © 2017 Thien Chu. All rights reserved.
//

import UIKit

enum ImageType {
    case imageNamed
    case contentOfFile
}

struct CellConfiguration {
    var width: CGFloat = 80
    var height: CGFloat = 80
    var spacing: CGFloat = 5
}

class ImageListViewController: UIViewController {
    
    var imageType: ImageType = .imageNamed
    let cellConfig = CellConfiguration()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ImageListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 200
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageViewCell", for: indexPath) as! ImageViewCell
        
        cell.imageView.image = loadImage(with: imageType)
        
        return cell
    }
    
    func loadImage(with type: ImageType) -> UIImage? {
        if type == .contentOfFile {
            let bundle = Bundle.main
            guard let imagePath = bundle.path(forResource: "placeholder", ofType: "png") else {
                return nil
            }
            return UIImage(contentsOfFile: imagePath)
        }
        return UIImage(named: "placeholder")
    }
}

extension ImageListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellConfig.width, height: cellConfig.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellConfig.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellConfig.spacing
    }
}
