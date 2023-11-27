//
//  MainProtocols.swift
//  IMDBApp
//
//  Created by Murat on 27.11.2023.
//

import Foundation

//Ana Protocols
protocol MainPresenterToMainInteractorProtocol{
    var mainPresenter : MainInteractorToMainPresenterProtocol?{get set}
    
    func getMovie(searchedMovie:String)
}

protocol MainViewToMainPresenterProtocol{
    var mainView: MainPresenterToMainViewProtocol?{get set}
    var mainInteractor: MainPresenterToMainInteractorProtocol?{get set}
    
    func toGetMovie(searchedMovie:String)
}

//Taşıyıcılar Protocols
protocol MainInteractorToMainPresenterProtocol{
    func sendDataToPresenter(sonuc:Array<Movie>)
}

protocol MainPresenterToMainViewProtocol{
    func sendDataToView(sonuc:Array<Movie>)
}

//Route Protocols

protocol MainPresenterToMainRouterProtocol{
    
    static func createModule(ref:MainViewController)
    
}
