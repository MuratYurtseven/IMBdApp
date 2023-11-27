//
//  MovieDetails.swift
//  IMDBApp
//
//  Created by Murat on 26.11.2023.
//

import Foundation

struct MovieDetails : Codable{
    
    var Title:String?
    var Year:String?
    var Rated:String?
    var Released:String?
    var Runtime:String?
    var Genre:String?
    var Director:String?
    var Actors:String?
    var Plot:String?
    var Language:String?
    var Awards:String?
    var Poster:String?
    var Ratings:[Ratings]?
    var imdbRating:String?
    var imdbVotes:String?
    var imdbID:String?
    var `Type`:String?
    var Country:String?
    
    init(Title: String, Year: String, Rated: String, Released: String, Runtime: String, Genre: String , Director: String, Plot: String, Language: String, Awards: String, Poster: String, Ratings: [Ratings], imdbRating: String, imdbVotes: String, imdbID: String) {
        self.Title = Title
        self.Year = Year
        self.Rated = Rated
        self.Released = Released
        self.Runtime = Runtime
        self.Genre = Genre
        self.Director = Director
        self.Plot = Plot
        self.Language = Language
        self.Awards = Awards
        self.Poster = Poster
        self.Ratings = Ratings
        self.imdbRating = imdbRating
        self.imdbVotes = imdbVotes
        self.imdbID = imdbID
    }
    
    
}
