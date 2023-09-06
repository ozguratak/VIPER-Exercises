//
//  View.swift
//  Exercise 1
//
//  Created by Özgür  Atak  on 31.08.2023.
//

// View bildiğimiz View, presenter'dan aldığı veriyi kullanıcıya gösterecek olan kısım. UI design olan kısım yani.
// Talk to -> Presenter
// Class, protocol
// ViewController

import Foundation
import UIKit

protocol AnyView {
    var presenter: AnyPresenter? {get set}
    
    func update(with data: [Model])
    func update(with error: String)
}

class View: UIViewController, AnyView {
    var presenter: AnyPresenter?
    var list : [Model] = []
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true //veri gelene kadar boş cell'leri göstermek istemiyoruz. update fonksiyonu içinde bu hidden fonksiyonunu false yaparak tekrar göstereceğiz.
        return table
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.text = "Downloading ..."
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        
        view.addSubview(tableView)
        view.addSubview(messageLabel)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() { //Ekranda kim nerede duracak, boyutlar ne olacak gibi ayarları yaptığımız kısım. viewDidload sonrasında çalışır.
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
        messageLabel.frame = CGRect(x: view.frame.width / 2 - 100, y: view.frame.height / 2 - 25, width: 200, height: 50)
    }
    
    
    func update(with data: [Model]) {
        DispatchQueue.main.async {
            print(data)
            self.list = data
            self.messageLabel.isHidden = true
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.list = []
            self.tableView.isHidden = true
            self.messageLabel.text = error
            self.messageLabel.isHidden = false
        }
    }
    
    
}
extension View: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = list[indexPath.row].currency
        content.secondaryText = list[indexPath.row].price
        cell.contentConfiguration = content
        cell.backgroundColor = UIColor.systemGray
        return cell
    }
  
    
    
}
