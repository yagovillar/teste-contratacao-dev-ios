//
//  MoviesVIew.swift
//  MovieRoll
//
//  Created by Júlia oliveira da rocha on 01/03/23.
//

import Foundation
import UIKit

class MoviesVIewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    

    
    

    
    
    @IBOutlet var collectionView: UICollectionView!
    var movies:Movies?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! MoviesCellController
        return cell
    }
    

    
    
    
    
}
