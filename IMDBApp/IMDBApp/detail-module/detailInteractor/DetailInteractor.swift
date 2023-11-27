//
//  DetailInteractor.swift
//  IMDBApp
//
//  Created by Murat on 27.11.2023.
//

import Foundation
import Alamofire

class DetailInteractor : DetailPresenterToDetailInteractorProtocol{
    var detailPresenter: DetailInteractorToDetailPresenterProtocol?
    
    func getDetailMovie(imbdID : String){
            
        let headers: HTTPHeaders = ["content-type":"application/json","authorization":"apikey 6WHJk9djzrq85r3YgEeqX5:0ObsI1Fq3zveaOGaKOkZuH"]
        let url = "https://api.collectapi.com/imdb/imdbSearchById"
            
        let params:Parameters = ["movieId":imbdID]
            
        AF.request(url,method: .get,parameters: params,headers: headers).validate().responseDecodable(of:MovieDetailsResponse.self){ response in
                
            switch response.result{
                    
            case .success(let answer):
                let gotDetailMovie = answer.result
                self.detailPresenter?.sendDataToDetailPresenter(sonuc: gotDetailMovie)
                    
            case .failure(let error):
                print("Error \(error.localizedDescription)")
            }}}
    
    
}
