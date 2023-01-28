//
//  CustomHeader.swift
//  infoCrypto
//
//  Created by Алексей Попроцкий on 19.08.2022.
//

import UIKit


class CustomHeader: UITableViewHeaderFooterView {
    
    let titleCurrency: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.text = "USD"
        return label
    }()
    
    let titleCrypto: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.text = "Coin"
        return label
    }()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        set()
    }
    
    func set() {
        contentView.addSubview(titleCurrency)
        contentView.addSubview(titleCrypto)        
        
        contentView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        titleCurrency.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40).isActive = true
        titleCurrency.heightAnchor.constraint(equalToConstant: 20).isActive = true
        titleCurrency.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        titleCrypto.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 35).isActive = true
        titleCrypto.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
