//
//  MainInteractor.swift
//  IMDBApp
//
//  Created by Murat on 27.11.2023.
//

import Foundation
import Alamofire

class MainInteractor : MainPresenterToMainInteractorProtocol{
    
    var mainPresenter: MainInteractorToMainPresenterProtocol?

    func getMovie(searchedMovie:String){
            print("it works")
            let headers: HTTPHeaders = ["content-type":"application/json","authorization":"apikey 6WHJk9djzrq85r3YgEeqX5:0ObsI1Fq3zveaOGaKOkZuH"]
            let url = "https://api.collectapi.com/imdb/imdbSearchByName"
            
            let params : Parameters = ["query":searchedMovie]
            
            AF.request(url,method: .get,parameters: params,headers: headers).validate().responseDecodable(of: MovieResponse.self){ response in
                
                switch response.result{
                case .success(let cevap):
                    if let results = cevap.result?.filter({ $0.Type == "movie" }) {
                        //filter is used to create a new array (self.gotList) that only includes items where the Type is "movie".
                        //print(results)
                        self.mainPresenter?.sendDataToPresenter(sonuc: results)
                        
                    }
                case .failure(let error):
                    print("Error \(error.localizedDescription)")}
                }
            
        }
    }
    
    

