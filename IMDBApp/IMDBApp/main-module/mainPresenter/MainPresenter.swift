//
//  MainPresenter.swift
//  IMDBApp
//
//  Created by Murat on 27.11.2023.
//

import Foundation

class MainPresenter:MainViewToMainPresenterProtocol{
    var mainView: MainPresenterToMainViewProtocol?
    
    var mainInteractor: MainPresenterToMainInteractorProtocol?
    
    func toGetMovie(searchedMovie: String) {
        mainInteractor?.getMovie(searchedMovie: searchedMovie)
    }
 
}

extension MainPresenter:MainInteractorToMainPresenterProtocol{
    func sendDataToPresenter(sonuc: Array<Movie>) {
        self.mainView?.sendDataToView(sonuc:sonuc)
        
    }
    
    
}
