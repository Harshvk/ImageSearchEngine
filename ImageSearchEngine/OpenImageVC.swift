//
//  OpenImageVC.swift
//  ImageSearchEngine
//
//  Created by appinventiv on 21/02/17.
//  Copyright © 2017 appinventiv. All rights reserved.
//

import UIKit

class OpenImageVC: UIViewController {

    //MARK: Properties
    /*---------------*/
    var imageURL : URL? = nil
    
    //MARK: IBOutlets
    /*--------------*/
    @IBOutlet weak var enlargedImage: UIImageView!
    
    //MARK: View Life Cycle
    /*--------------------*/
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        self.enlargedImage.af_setImage(withURL: imageURL!)
    }

}
