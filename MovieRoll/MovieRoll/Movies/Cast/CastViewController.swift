//
//  CastViewController.swift
//  MovieRoll
//
//  Created by Júlia oliveira da rocha on 02/03/23.
//

import UIKit

class CastViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    

    @IBOutlet var tableView: UITableView!
    
    var actorList:[Actor]? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "ator")
        self.tableView.backgroundColor = UIColor(named: "background")
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        (self.actorList?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "ator", for: indexPath) as! TableViewCellController
            let actor = self.actorList?[indexPath.row]
            cell.nomeAtor.text = actor?.name
            cell.personagem.text = actor?.asCharacter
            if let url = URL(string: actor!.image){
                cell.imgAtor.load(url: url)
            }
            return cell

    }



}
