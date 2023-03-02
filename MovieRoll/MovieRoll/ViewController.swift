//
//  ViewController.swift
//  MovieRoll
//
//  Created by Júlia oliveira da rocha on 02/03/23.
//

import Foundation
import UIKit

class ViewController: UIViewController{
    
    var imageView:UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 200))
        imageView.image = UIImage(named: "appLogo")
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
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
            let size = self.view.frame.size.width * 2
            let xposition = size - self.view.frame.width
            let yposition = self.view.frame.height - size
            
            self.imageView.frame = CGRect(x: -xposition/2, y: yposition/2, width: size, height: size)
            self.imageView.alpha = 0
        }
    }
}
