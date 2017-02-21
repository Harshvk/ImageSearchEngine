//
//  ImagesCell.swift
//  ImageSearchEngine
//
//  Created by appinventiv on 21/02/17.
//  Copyright © 2017 appinventiv. All rights reserved.
//

import UIKit
import AlamofireImage

class ImagesCell: UICollectionViewCell {

    //MARK: IBOutlets
    /*---------------*/
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    //MARK: Cell LifeCycle
    /*-------------------*/
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureData(withData data: ImageInfo){
        
        let url = URL(string: data.previewURL)
        thumbnailImageView.af_setImage(withURL: url!)
        
    }
}
