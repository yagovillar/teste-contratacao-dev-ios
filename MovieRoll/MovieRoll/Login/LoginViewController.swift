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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
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
        self.errorLabel.isHidden = true
        self.loginTxt.layer.cornerRadius = 14
        self.loginTxt.layer.masksToBounds = true
        self.senhaTxt.layer.cornerRadius = 14
        self.senhaTxt.layer.masksToBounds = true
        self.btEbtrar.layer.cornerRadius = 24
        self.btEbtrar.layer.masksToBounds = true

    }
    
  
}





extension UITextField {
    func isError(baseColor: CGColor, numberOfShakes shakes: Float, revert: Bool) {
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "shadowColor")
        animation.fromValue = baseColor
        animation.toValue = UIColor.red.cgColor
        animation.duration = 0.4
        if revert { animation.autoreverses = true } else { animation.autoreverses = false }
        self.layer.add(animation, forKey: "")

        let shake: CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.07
        shake.repeatCount = shakes
        if revert { shake.autoreverses = true  } else { shake.autoreverses = false }
        shake.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        shake.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(shake, forKey: "position")
    }
}

extension UILabel {
    func isError(baseColor: CGColor, numberOfShakes shakes: Float, revert: Bool) {
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "shadowColor")
        animation.fromValue = baseColor
        animation.toValue = UIColor.red.cgColor
        animation.duration = 0.4
        if revert { animation.autoreverses = true } else { animation.autoreverses = false }
        self.layer.add(animation, forKey: "")

        let shake: CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.07
        shake.repeatCount = shakes
        if revert { shake.autoreverses = true  } else { shake.autoreverses = false }
        shake.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        shake.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(shake, forKey: "position")
    }
}
