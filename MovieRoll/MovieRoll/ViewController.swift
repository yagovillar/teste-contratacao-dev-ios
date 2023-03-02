//
//  ViewController.swift
//  MovieRoll
//
//  Created by Júlia oliveira da rocha on 01/03/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.loadMovies()
    }
    
    
    func loadMovies(){
        MovieService().getMovies { movies in
            if !movies.items.isEmpty{
                self.navigationController?.pushViewController(LoginViewController(), animated: true)
            }
        }
    }


}

