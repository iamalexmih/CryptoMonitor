//
//  ViewController.swift
//  infoCrypto
//
//  Created by Алексей Попроцкий on 18.08.2022.
//

import UIKit


class ViewController: UIViewController {

    
    @IBOutlet var tableView: UITableView!
    
    private var cryptoItems = [CryptoTableViewCellViewModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        NomicsAPICaller.shared.getAllCryptoData { [weak self] crypto in
            if let crypto = crypto {
                self?.cryptoItems = crypto.compactMap({ cryptoModel in
                    CryptoTableViewCellViewModel.init(name: cryptoModel.name,
                                                      symbol: cryptoModel.symbol,
                                                      price: cryptoModel.price)
                })

                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
        
        tableView.dataSource = self
        tableView.delegate = self
    }  

}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoTableViewCell.cellId, for: indexPath) as? CryptoTableViewCell else { fatalError() }
        let currentCrypto = cryptoItems[indexPath.row]
        cell.config(with: currentCrypto)
        
        return cell
    }
}
