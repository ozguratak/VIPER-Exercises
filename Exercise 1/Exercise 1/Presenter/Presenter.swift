//
//  Presenter.swift
//  Exercise 1
//
//  Created by Özgür  Atak  on 31.08.2023.
//

//VIPER Pattern için VİewModel gibi davranan kısım.

// Talks to -> interactor, router, view
// class, protocol

import Foundation

enum NetworkError: Error {
    case NetworkFail
    case ParsingFail
    case OptionalErrorForModel
}

protocol AnyPresenter {
    var interactor: AnyIneractor? {get set}
    var router: AnyRouter? {get set}
    var view: AnyView? {get set}
    
    func interactorDidDownloadData(result: Result<[Model], Error>)
}

class Presenter: AnyPresenter {
    
    var interactor: AnyIneractor? {
        didSet {
            interactor?.downloadDataFromUrl()
        }
    }
    
    var router: AnyRouter?
    
    var view: AnyView?
    
    func interactorDidDownloadData(result: Result<[Model], Error>) {
        switch result {
        case .success(let data):
            view?.update(with: data)
        case .failure(let error):
            print(error.localizedDescription)
            view?.update(with: "Try again Later!")
        }
    }
    
    
    
}
