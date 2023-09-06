//
//  Interactor.swift
//  Exercise 1
//
//  Created by Özgür  Atak  on 31.08.2023.
//

// Interactor, internetten veya verisetinden verileri getiren, indirme işlemlerini vs yapan kısımdır. eğer VIPER için olan akış diagramı göz önüne getirilirse; interactor, service aracılığı ile entityle iletişime geçecek ve veriyi getirecek. Veri geldikten sonra presenter'a haber verecek. Presenter ise View'ı güncelleyecek. Olay oldukça basit

// Class, protocol
// Talks to -> Presenter
// link: https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json

import Foundation

protocol AnyIneractor {
    var presenter: AnyPresenter? {get set}
    
    func downloadDataFromUrl()
}

class Interactor: AnyIneractor {
    var presenter: AnyPresenter?
    
    func downloadDataFromUrl() {
        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")
        else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidDownloadData(result: .failure(NetworkError.NetworkFail))
                return
            }
            
            do {
                let model = try JSONDecoder().decode([Model].self, from: data)
                self?.presenter?.interactorDidDownloadData(result: .success(model))
            } catch {
                self?.presenter?.interactorDidDownloadData(result: .failure(NetworkError.ParsingFail))
            }
        }
        task.resume()
    }
    
    
}
