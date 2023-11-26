//
//  Movie.swift
//  IMDBApp
//
//  Created by Murat on 26.11.2023.
//

import Foundation

struct Movie : Codable{
    var Title:String?
    var Year:String?
    var imdbID:String?
    var `Type`:String?
    var Poster:String?
    
    init(){
        
    }
    
    init(Title:String,Year:String,imdbID:String,Type:String,Poster:String){
        self.Title = Title
        self.Year = Year
        self.imdbID = imdbID
        self.Type = Type
        self.Poster = Poster
    }
}
