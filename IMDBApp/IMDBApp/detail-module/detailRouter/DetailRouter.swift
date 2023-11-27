//
//  DetailRouter.swift
//  IMDBApp
//
//  Created by Murat on 27.11.2023.
//

import Foundation

class DetailRouter : DetailPresenterToDetailRouterProtocol{
    static func createDetailModule(refD: DetailViewController) {
        
        let detailPresenter = DetailPresenter()
        
        refD.detailPresenterObject = detailPresenter
        refD.detailPresenterObject?.detailInteractor = DetailInteractor()
        refD.detailPresenterObject?.detailView = refD
        refD.detailPresenterObject?.detailInteractor?.detailPresenter=detailPresenter
    }
    
    
}
