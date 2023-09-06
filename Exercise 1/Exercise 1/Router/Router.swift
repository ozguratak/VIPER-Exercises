//
//  Router.swift
//  Exercise 1
//
//  Created by Özgür  Atak  on 31.08.2023.
//

// Uygulamanın AppDelegate işlemlerini yaptığımız kısımlar, router hangi router, entitiy hangi entitiy gibi tanımlamaları yapcağımız kısım burası olacak. 
// Class, protocol
// Entrypoint

import Foundation
import UIKit

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry: EntryPoint? {get}
    static func startExecution() -> AnyRouter
}

class MainRouter : AnyRouter {
    
    var entry: EntryPoint?
    
    static func startExecution() -> AnyRouter {
        
        let router = MainRouter()
        var view : AnyView = View()
        var presenter : AnyPresenter = Presenter()
        var interactor : AnyIneractor = Interactor()
        
        view.presenter = presenter
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        
        interactor.presenter = presenter
        
        router.entry = view as? EntryPoint
        
        return router
    }
    
    
}
