//
//  DetailViewController.swift
//  IMDBApp
//
//  Created by Murat on 26.11.2023.
//

import UIKit
import Alamofire
import QuartzCore

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
    var DetailMovie :MovieDetails?
    
    var detailPresenterObject : DetailViewToDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Router
        
        DetailRouter.createDetailModule(refD: self)
        
        // Do any additional setup after loading the view.
        if let controlID = imbdID{
            detailPresenterObject?.toGetDetailMovie(imbdID: controlID)
        }
    }
    @IBAction func toIMDbPage(_ sender: Any) {
        if let url = URL(string: "https://www.imdb.com/title/\(imbdID!)/") {
            UIApplication.shared.open(url)
        }
    }
    
}

extension DetailViewController: DetailPresenterToDetailViewProtocol{
    func sendDataToDetailView(sonuc: MovieDetails) {
        self.DetailMovie=sonuc
        if let ControlDetailMovie = DetailMovie{
            self.movieTitleLabel.text = ControlDetailMovie.Title ?? " "
            self.movieTitleLabel.layer.backgroundColor  = UIColor.red.cgColor
            self.movieTitleLabel.layer.cornerRadius = 16
            self.movieTitleLabel.layer.masksToBounds = true
            self.movieTitleLabel.textColor = UIColor.white
            if let url = URL(string: (ControlDetailMovie.Poster)!){
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url)
                    DispatchQueue.main.async {
                        self.movieImageView.image = UIImage(data: data!)
                    }
                }
            }
            if ControlDetailMovie.Ratings?.count == 3 {
                if let ratings = ControlDetailMovie.Ratings{
                    self.movieTomatoRatingLabel.text = "\(ratings[1].Source ?? "0") : \(ratings[1].Value ?? "0")"
                    self.movieTomatoRatingLabel.layer.backgroundColor  = UIColor.orange.cgColor
                    self.movieTomatoRatingLabel.layer.cornerRadius = 16
                    self.movieTomatoRatingLabel.layer.masksToBounds = true
                    self.movieTomatoRatingLabel.textColor = UIColor.white
                    
                }
                if let ratings = ControlDetailMovie.Ratings{
                    self.movieMetacriticLabel.text = "\(ratings[2].Source!) : \(ratings[2].Value!)"
                    self.movieMetacriticLabel.layer.backgroundColor  = UIColor.orange.cgColor
                    self.movieMetacriticLabel.layer.cornerRadius = 16
                    self.movieMetacriticLabel.layer.masksToBounds = true
                    self.movieMetacriticLabel.textColor = UIColor.white
                    
                    
                }}
            self.imdbRatingLabel.text = "IMBd Rating: \(ControlDetailMovie.imdbRating ?? " ")"
            self.imdbRatingLabel.layer.backgroundColor  = UIColor.yellow.cgColor
            self.imdbRatingLabel.layer.cornerRadius = 8
            self.imdbRatingLabel.layer.masksToBounds = true
            self.imdbRatingLabel.textColor = UIColor.darkGray
            
            
            self.imdbVotesLabel.text = "Voters: \(ControlDetailMovie.imdbVotes ?? " ")"
            self.imdbVotesLabel.layer.backgroundColor  = UIColor.yellow.cgColor
            self.imdbVotesLabel.layer.cornerRadius = 8
            self.imdbVotesLabel.layer.masksToBounds = true
            self.imdbVotesLabel.textColor = UIColor.darkGray

            
            self.movieActorsLabel.text = "Actors: \(ControlDetailMovie.Actors ?? " ")"
            self.movieDriectorLabel.text = "Director:\(ControlDetailMovie.Director ?? " ")"
            self.movieReleasedLabel.text = "Released: \(ControlDetailMovie.Released ?? " ")"
            self.movieTypeLabel.text = "Country: \(ControlDetailMovie.Country ?? " ")"
            self.movieGenreLabel.text = "Genre: \(ControlDetailMovie.Genre ?? " ")"
            self.moviePlotLabel.text = "Plot: \(ControlDetailMovie.Plot ?? " ")"
            self.movieAwardsLabel.text = "Awards: \(ControlDetailMovie.Awards ?? " ")"
            
            self.movieRuntimeLabel.text = ControlDetailMovie.Runtime ?? " "
            self.movieRuntimeLabel.layer.backgroundColor  = UIColor.systemIndigo.cgColor
            self.movieRuntimeLabel.layer.cornerRadius = 16
            self.movieRuntimeLabel.layer.masksToBounds = true
            self.movieRuntimeLabel.textColor = UIColor.white
            
            
            self.movieLanguageLabel.text = "Language: \(ControlDetailMovie.Language ?? " ")"
            
        }}
    
    
}
