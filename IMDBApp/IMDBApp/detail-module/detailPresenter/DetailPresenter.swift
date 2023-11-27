//
//  DetailPresenter.swift
//  IMDBApp
//
//  Created by Murat on 27.11.2023.
//

import Foundation

class DetailPresenter : DetailViewToDetailPresenterProtocol{
    
    var detailInteractor: DetailPresenterToDetailInteractorProtocol?
    
    var detailView: DetailPresenterToDetailViewProtocol?
    
    func toGetDetailMovie(imbdID: String) {
        self.detailInteractor?.getDetailMovie(imbdID: imbdID)
    }
}

extension DetailPresenter:DetailInteractorToDetailPresenterProtocol{
    func sendDataToDetailPresenter(sonuc: MovieDetails) {
        self.detailView?.sendDataToDetailView(sonuc: sonuc)
        //print(sonuc)
    }
    
    
}

