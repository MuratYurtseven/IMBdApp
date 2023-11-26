//
//  DetailViewController.swift
//  IMDBApp
//
//  Created by Murat on 26.11.2023.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTomatoRatingLabel: UILabel!
    @IBOutlet weak var movieMetacriticLabel: UILabel!
    @IBOutlet weak var imdbRatingLabel: UILabel!
    @IBOutlet weak var imdbVotesLabel: UILabel!
    @IBOutlet weak var movieActorsLabel: UILabel!
    @IBOutlet weak var movieDriectorLabel: UILabel!
    @IBOutlet weak var movieReleasedLabel: UILabel!
    @IBOutlet weak var movieTypeLabel: UILabel!
    @IBOutlet weak var movieGenreLabel: UILabel!
    @IBOutlet weak var moviePlotLabel: UILabel!
    @IBOutlet weak var movieAwardsLabel: UILabel!
    @IBOutlet weak var movieRuntimeLabel: UILabel!
    @IBOutlet weak var movieLanguageLabel: UILabel!
    
    var imbdID:String?
    var gotDetailList :MovieDetails?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let controlID = imbdID{
            getDetailMovie(imbdID: controlID)
        }
    }
    func getDetailMovie(imbdID : String){
        
        let headers: HTTPHeaders = ["content-type":"application/json","authorization":"apikey 6WHJk9djzrq85r3YgEeqX5:0ObsI1Fq3zveaOGaKOkZuH"]
        let url = "https://api.collectapi.com/imdb/imdbSearchById"
        
        let params:Parameters = ["movieId":imbdID]
        
        AF.request(url,method: .get,parameters: params,headers: headers).validate().responseDecodable(of:MovieDetailsResponse.self){ response in
            
            switch response.result{
                
            case .success(let answer):
                self.gotDetailList = answer.result
                self.movieTitleLabel.text = self.gotDetailList?.Title ?? " "
                if let url = URL(string: (self.gotDetailList?.Poster)!){
                    DispatchQueue.global().async {
                        let data = try? Data(contentsOf: url)
                        DispatchQueue.main.async {
                            self.movieImageView.image = UIImage(data: data!)
                        }
                    }
                }
                if self.gotDetailList?.Ratings?.count == 3 {
                    if let ratings = self.gotDetailList?.Ratings{
                        self.movieTomatoRatingLabel.text = "\(ratings[1].Source ?? "0") : \(ratings[1].Value ?? "0")"
                    }
                    if let ratings = self.gotDetailList?.Ratings{
                        self.movieMetacriticLabel.text = "\(ratings[2].Source!) : \(ratings[2].Value!)"
                    }}
                self.imdbRatingLabel.text = "IMBd Rating: \(self.gotDetailList?.imdbRating ?? " ")"
                self.imdbVotesLabel.text = "Voters: \(self.gotDetailList?.imdbVotes ?? " ")"
                self.movieActorsLabel.text = "Actors: \(self.gotDetailList?.Actors ?? " ")"
                self.movieDriectorLabel.text = "Director:\(self.gotDetailList?.Director ?? " ")"
                self.movieReleasedLabel.text = "Released: \(self.gotDetailList?.Released ?? " ")"
                self.movieTypeLabel.text = "Country: \(self.gotDetailList?.Country ?? " ")"
                self.movieGenreLabel.text = "Genre: \(self.gotDetailList?.Genre ?? " ")"
                self.moviePlotLabel.text = "Plot: \(self.gotDetailList?.Plot ?? " ")"
                self.movieAwardsLabel.text = "Awards: \(self.gotDetailList?.Awards ?? " ")"
                self.movieRuntimeLabel.text = self.gotDetailList?.Runtime ?? " "
                self.movieLanguageLabel.text = "Language: \(self.gotDetailList?.Language ?? " ")"
                
                
            case .failure(let error):
                print("Error \(error.localizedDescription)")
            }

            
        }
        
        
        
    }
    

    @IBAction func toIMDbPage(_ sender: Any) {
        if let url = URL(string: "https://www.imdb.com/title/\(imbdID!)/") {
            UIApplication.shared.open(url)
        }
    }
    
}
