//
//  LoginViewController.swift
//  MovieRoll
//
//  Created by Júlia oliveira da rocha on 01/03/23.
//

import Foundation
import UIKit

class LoginViewController: UIViewController{
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var btEbtrar: UIButton!
    @IBOutlet weak var senhaTxt: UITextField!
    @IBOutlet weak var loginTxt: UITextField!
    
    var imageView:UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 200))
        imageView.image = UIImage(named: "appLogo")
        return imageView
    }()
    
    var loadingView:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
        DispatchQueue.main.asyncAfter(deadline: .now()+3){
            self.animation()
        }
    }
    
    func animation(){
        UIView.animate(withDuration: 1) {
            let width = self.view.frame.size.width * 2
            let height = self.view.frame.size.height * 2
            let xposition = width - self.view.frame.width
            let yposition = self.view.frame.height - height
            
            self.imageView.frame = CGRect(x: -xposition/2, y: yposition/2, width: width, height: height)
            self.imageView.alpha = 0
            self.loadingView?.alpha = 0
        }
    }
        
        @IBAction func pinUpEntrar(_ sender: Any) {
            var fail = false
            self.errorLabel.isHidden = true
            
            if loginTxt.text != "admin"{
                self.loginTxt.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 2, revert: false)
                self.errorLabel.isHidden = false
                self.errorLabel.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 2, revert: false)
                fail.toggle()
            }
            
            if senhaTxt.text != "admin"{
                self.senhaTxt.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 2, revert: false)
                self.errorLabel.isHidden = false
                self.errorLabel.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 2, revert: false)
                fail.toggle()
            }
            
            if !fail{
                self.login()
            }
        }
        
        func login(){
            view.displayActivityIndicator(shouldDisplay: true)
            MovieService().getMovies { movies in
                if !movies.items.isEmpty{
                    let con  = MoviewViewController()
                    con.movies = movies
                    self.navigationController?.pushViewController(con, animated: true)
                    self.view.displayActivityIndicator(shouldDisplay: false)
                    self.loginTxt.text = ""
                    self.senhaTxt.text = ""
                }else{
                    self.showToast(message: "Error getting data!")
                    self.view.displayActivityIndicator(shouldDisplay: false)
                }
            }
        }
        
        
        func setViews(){
            
            self.loadingView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
            self.loadingView?.backgroundColor = UIColor(named: "AccentColor")
            self.loadingView?.addSubview(self.imageView)
            self.view.addSubview(self.loadingView!)
            
            self.errorLabel.isHidden = true
            self.loginTxt.layer.cornerRadius = 14
            self.loginTxt.layer.masksToBounds = true
            self.senhaTxt.layer.cornerRadius = 14
            self.senhaTxt.layer.masksToBounds = true
            self.btEbtrar.layer.cornerRadius = 24
            self.btEbtrar.layer.masksToBounds = true
            
        }
        
        
    }

