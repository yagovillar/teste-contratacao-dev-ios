//
//  MoviewViewController.swift
//  MovieRoll
//
//  Created by Júlia oliveira da rocha on 01/03/23.
//

import UIKit

class MoviewViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {

   
    @IBOutlet var logoutBt: UIView!
    @IBOutlet var btSearch: UIButton!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    
    
    var movies:Movies? = nil
    var filteredMovies:Movies? = nil
    let loader = ImageLoader()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        self.filteredMovies = movies
        
        self.searchBar.layer.cornerRadius = 14
        self.searchBar.layer.masksToBounds = true
        self.logoutBt.layer.cornerRadius = 25
        self.logoutBt.layer.masksToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.logoutPinUp(_:)))
        self.logoutBt.addGestureRecognizer(tap)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let movie = filteredMovies?.items[indexPath.row]
        cell.title.text = movie?.title
        cell.info.text = movie!.year + "  |  #" + movie!.rank
        
        if let rate = Float(movie!.imDbRating){
            if rate > 1{
                cell.star2.image = UIImage(systemName: "star.fill")
            }
            if rate > 2{
                cell.star3.image = UIImage(systemName: "star.fill")
            }
            if rate > 3{
                cell.star4.image = UIImage(systemName: "star.fill")
            }
            if rate > 4{
                cell.star5.image = UIImage(systemName: "star.fill")
            }
        }
        
        if let url = URL(string: movie!.image){
            // 1
            let token = loader.loadImage(url) { result in
              do {
                // 2
                let image = try result.get()
                // 3
                DispatchQueue.main.async {
                  cell.img.image = image
                }
              } catch {
                // 4
                print(error)
              }
            }

            // 5
            cell.onReuse = {
              if let token = token {
                self.loader.cancelLoad(token)
              }
            }
        }
        
        
        
        
        return cell
    }
    
    @IBAction func showSearchBar(_ sender: Any) {
        if searchBar.isHidden{
            self.searchBar.alpha = 0
            UIView.animate(withDuration: 0.5, delay: 0) {
                self.searchBar.alpha = 1
                self.btSearch.setImage(UIImage(systemName: "xmark"), for: .normal)
                self.searchBar.isHidden = false
            }
        }else{
            self.searchBar.alpha = 1
            UIView.animate(withDuration: 0.5, delay: 0) {
                self.searchBar.alpha = 0
                self.btSearch.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
                self.searchBar.isHidden = true
            }
        }
    }
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        (filteredMovies?.items.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let con = DetailViewController()
        let movie = self.filteredMovies?.items[indexPath.row]
        con.id = movie?.id
        con.rate = movie?.imDbRating
        self.navigationController?.pushViewController(con, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty{
            self.filteredMovies?.items = (self.movies?.items.filter({$0.title.contains(searchText)}))!
        }else{
            self.filteredMovies?.items = (self.movies?.items)!
        }
        
        self.collectionView.reloadData()
    }
    

    
    @objc func logoutPinUp(_ sender: Any){
        let refreshAlert = UIAlertController(title: "Are you login out?", message: "", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            self.navigationController?.popToRootViewController(animated: false)
        }))

        refreshAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
            refreshAlert.dismiss(animated: true)
        }))

        present(refreshAlert, animated: true, completion: nil)
    }
}


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
    func loadIfNeed(url: URL, movie:Movie) {
        let initialUrl = url
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        if initialUrl == url{
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
}
