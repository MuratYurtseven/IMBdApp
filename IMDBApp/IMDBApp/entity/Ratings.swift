//
//  Ratings.swift
//  IMDBApp
//
//  Created by Murat on 26.11.2023.
//

import Foundation

struct Ratings : Codable{
    var Source:String?
    var Value:String?
    
    init(){
        
    }
    
    init(Source:String,Value:String){
        self.Source=Source
        self.Value=Value
    }
}
