//
//  MainRouter.swift
//  IMDBApp
//
//  Created by Murat on 27.11.2023.
//

import Foundation

class MainRouter : MainPresenterToMainRouterProtocol{
    
    static func createModule(ref: MainViewController) {
        
        let mainPresenter=MainPresenter()
        
        ref.mainPresenterObject=mainPresenter
        
        ref.mainPresenterObject?.mainInteractor=MainInteractor()
        
        ref.mainPresenterObject?.mainView=ref
        
        ref.mainPresenterObject?.mainInteractor?.mainPresenter=mainPresenter
    }
    
    
}
