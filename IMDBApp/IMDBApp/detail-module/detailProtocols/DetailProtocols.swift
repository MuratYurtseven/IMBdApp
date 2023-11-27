//
//  DetailProtocols.swift
//  IMDBApp
//
//  Created by Murat on 27.11.2023.
//

import Foundation

//Ana Protocols

protocol DetailPresenterToDetailInteractorProtocol{
    var detailPresenter:DetailInteractorToDetailPresenterProtocol?{get set}
    
    func getDetailMovie(imbdID : String)
}

protocol DetailViewToDetailPresenterProtocol{
    var detailInteractor:DetailPresenterToDetailInteractorProtocol?{get set}
    var detailView:DetailPresenterToDetailViewProtocol?{get set}
    
    func toGetDetailMovie(imbdID : String)
}

//Taşıyıcı Protocols

protocol DetailInteractorToDetailPresenterProtocol{
    func sendDataToDetailPresenter(sonuc:MovieDetails)
}

protocol DetailPresenterToDetailViewProtocol{
    func sendDataToDetailView(sonuc:MovieDetails)
}

//Router

protocol DetailPresenterToDetailRouterProtocol{
    static func createDetailModule(refD:DetailViewController)
}
