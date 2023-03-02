//
//  DetailViewController.swift
//  MovieRoll
//
//  Created by Júlia oliveira da rocha on 01/03/23.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet var tableCast: UITableView!
    @IBOutlet var synopsis: UILabel!
    @IBOutlet var rating: UILabel!
    @IBOutlet var star5: UIImageView!
    @IBOutlet var star4: UIImageView!
    @IBOutlet var star3: UIImageView!
    @IBOutlet var star2: UIImageView!
    @IBOutlet var star1: UIImageView!
    @IBOutlet var genre: UILabel!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var info: UILabel!
    @IBOutlet var img: UIImageView!
    @IBOutlet var background: UIImageView!
    
    var show:TVSeries? = nil
    var rate:String? = ""
    var id:String? = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableCast.delegate = self
        self.tableCast.dataSource = self
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        self.tableCast.register(nib, forCellReuseIdentifier: "ator")
        self.tableCast.backgroundColor = UIColor(named: "background")
        self.view.displayActivityIndicator(shouldDisplay: true)
        self.getData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func getData(){
        MovieService().getDetails(id: self.id!) { response in
            if let show = response{
                self.show = show
                self.setupInfos()
                self.setupRating()
                self.tableCast.reloadData()
                self.setupImages()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.show != nil {
            let cell = self.tableCast.dequeueReusableCell(withIdentifier: "ator", for: indexPath) as! TableViewCellController
            let actor = show?.actorList[indexPath.row]
            cell.nomeAtor.text = actor?.name
            cell.personagem.text = actor?.asCharacter
            if let url = URL(string: actor!.image){
                cell.imgAtor.load(url: url)
            }
            return cell
        }else{
            let cell = self.tableCast.dequeueReusableCell(withIdentifier: "ator", for: indexPath) as! TableViewCellController
            return cell
        }
    }
    
    func setupRating(){
        let rate = Float(self.rate!)
        let formattedNumber = String(format: "%.1f", rate!/2)
        self.rating.text = (formattedNumber) + "/5"
        if let rate = Float(self.rate!){
            if rate > 1{
                self.star2.image = UIImage(systemName: "star.fill")
            }
            if rate > 2{
                self.star3.image = UIImage(systemName: "star.fill")
            }
            if rate > 3{
                self.star4.image = UIImage(systemName: "star.fill")
            }
            if rate > 4{
                self.star5.image = UIImage(systemName: "star.fill")
            }
        }
    }
    
    func setupImages(){
        if let url = URL(string: show!.image){
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.img.image = image
                            self?.background.image = image
                            self?.view.displayActivityIndicator(shouldDisplay: false)
                        }
                    }
                }
            }
            let blurEffect = UIBlurEffect(style: .regular)
            let blurEffectView = UIVisualEffectView()
            blurEffectView.frame = CGRect(x: 0, y: 0, width: self.background.frame.width, height: 400)
            blurEffectView.center = self.background.center
            blurEffectView.layer.opacity = 0.75
            self.background.addSubview(blurEffectView)
            blurEffectView.effect = blurEffect
        }
    }
    
    func setupInfos(){
        self.synopsis.text = show?.plot
        self.movieTitle.text = show?.title
        self.info.text = show?.runtimeStr
        let dateString = (show?.releaseDate) ?? "0000-00-00"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date)
            self.genre.text = String(year)
        }
        
    }


    

     @IBAction func viewMore(_ sender: Any) {
         let con = CastViewController()
         con.actorList = self.show?.actorList
         self.navigationController?.pushViewController(con, animated: true)
     }
     

}
