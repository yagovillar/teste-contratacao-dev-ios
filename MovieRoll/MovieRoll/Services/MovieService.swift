//
//  MovieService.swift
//  MovieRoll
//
//  Created by Júlia oliveira da rocha on 01/03/23.
//

import Foundation
import Alamofire
import UIKit
import PromiseKit



class MovieService{
    
    private let apiKey = "k_7l7fhipd"
    
    private let urlMovies = "https://imdb-api.com/en/API/Top250Movies/k_2x8ulu63"

    private let urlDetail = "https://imdb-api.com/en/API/Title/k_2x8ulu63/"
    
    

    func getMovies(completion: @escaping (Movies) -> Void) {
        
        AF.request(urlMovies).responseDecodable(
            of: Movies.self) { response in
                switch response.result {
                case .success(_):
                    // Handle successful response
                    completion(response.value!)
                case .failure(let error):
                    // Handle error
                    print(error.localizedDescription)
                       }
            }
    }
    
    func getDetails(id:String, completion: @escaping (TVSeries?) -> Void) {
        let url = urlDetail + id
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                // Cast the JSON response to a dictionary
                if let jsonDict = value as? [String: Any] {
                    // Access the "title" key and print its value
                    guard let title = jsonDict["title"] as? String else {return}
                    guard let date = jsonDict["releaseDate"] as? String else {return}
                    guard let runtime = jsonDict["runtimeStr"] as? String else {return}
                    guard let plot = jsonDict["plot"] as? String else {return}
                    guard let actorlist = jsonDict["actorList"] as? NSArray else {return}
                    guard let image = jsonDict["image"] as? String else {return}
                    
                    if let array = actorlist as? [NSDictionary] {
                        let objects = array.map { dict -> Actor in
                            let name = dict["name"] as? String ?? ""
                            let image = dict["image"] as? String ?? ""
                            let char = dict["asCharacter"] as? String ?? ""
                            return Actor(id: "", image: image, name: name, asCharacter: char)
                        }
                        let show = TVSeries(id: "", title: title, originalTitle: "", fullTitle: "", type: "", year: "", image: image, releaseDate: date, runtimeMins: 0, runtimeStr: runtime, plot: plot, plotLocal: "", plotLocalIsRtl: false, awards: "", directors: "", directorList: [], writers: "", writerList: [], stars: "", starList: [], actorList: objects)
                        completion(show)

                    } else {
                        print("NSArray could not be converted to [NSDictionary]")
                    }

                    

                    
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
}




