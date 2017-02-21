//
//  HomePageVC.swift
//  ImageSearchEngine
//
//  Created by appinventiv on 21/02/17.
//  Copyright © 2017 appinventiv. All rights reserved.
//

import UIKit

class HomePageVC: UIViewController {

    //MARK: Properties
    /*---------------*/
    var imagesArray = [ImageInfo]()

    //MARK: IBOutlets
    /*--------------*/

    @IBOutlet weak var imageSearch: UISearchBar!
    @IBOutlet weak var imagesCollection: UICollectionView!
    
    //MARK: View Life Cycle
    /*--------------------*/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //performing initial setup
        self.initialSetup()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: IBActions
    /*--------------*/
 

    //MARK: Private Functions
    /*----------------------*/
    private func initialSetup(){
        
        //setting up datasource and delegates of collection view
        self.imagesCollection.dataSource = self
        self.imagesCollection.delegate = self
        
        //setting up datasource and delegates of search bar
        self.imageSearch.delegate = self
        
        //removing automatic schrool view insets
        self.automaticallyAdjustsScrollViewInsets = false
        
        //registering nib
        let nib = UINib(nibName: "ImagesCell", bundle: nil)
        imagesCollection.register(nib, forCellWithReuseIdentifier: "ImagesCellID")
        
        //calling initial data and displaying
        searchData()
    }
    
    fileprivate func searchData(){
        
        //changing title of navigation bar
        self.navigationItem.title = imageSearch.text!
        
        //hitting webservice and parsing data
        WebServices().fetchDataFromPixabay(withQuery: imageSearch.text!,
                                           success: {(input: [ImageInfo]) -> Void in
                                            
                                            self.imagesArray = input
                                            self.imagesCollection.reloadData()
        },failure: {(error: Error) -> Void in
            
            print(error)
        })    }
}

//MARK: SearchBarDelegate
/*-----------------------*/
extension HomePageVC : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.endEditing(true)
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchData()
    }
    
    
}


//MARK: CollectionViewDelegate ,DataSource ,FlowLayoutDelegate
/*-----------------------------------------------------------*/
extension HomePageVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
    
        return imagesArray.count
    
    }
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesCellID", for: indexPath) as! ImagesCell
        
        cell.configureData(withData : imagesArray[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let enlargedImageVC = self.storyboard?.instantiateViewController(withIdentifier: "OpenImageVC") as! OpenImageVC
        enlargedImageVC.imageURL = URL(string: imagesArray[indexPath.row].webformatURL)
        self.navigationController?.pushViewController(enlargedImageVC, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let measurment = collectionView.frame.width/2-3
        return CGSize(width: measurment, height: measurment)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        
        return 1
    }
}

