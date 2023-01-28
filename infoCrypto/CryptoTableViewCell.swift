//
//  CryptoTableViewCell.swift
//  infoCrypto
//
//  Created by Алексей Попроцкий on 18.08.2022.
//

import UIKit


struct CryptoTableViewCellViewModel {
    let name: String
    let label: String
    var labelForIcon: String {
        let arrayHelper = label.components(separatedBy: "/")
        return arrayHelper[0]
    }
    let price: Double
}

class CryptoTableViewCell: UITableViewCell {

    static let cellId = "CryptoTableViewCell"
    
    @IBOutlet var labelName: UILabel!
    @IBOutlet var labelSymbol: UILabel!
    @IBOutlet var labelPrice: UILabel!
    @IBOutlet var imageLogoCrypto: WebImageView!
    
    
    func config(with viewModel: CryptoTableViewCellViewModel) {
        labelName.text = viewModel.name
        
        if viewModel.label.contains("/") {
            let arrayHelper = viewModel.label.components(separatedBy: "/")
            labelSymbol.text = arrayHelper[0]
        } else {
            labelSymbol.text = viewModel.label
        }
        
        labelPrice.text =  String(format: "%.3f", viewModel.price)
        
        imageLogoCrypto.layer.cornerRadius = imageLogoCrypto.frame.height/2
        
        let urlStr = "https://coinicons-api.vercel.app/api/icon/\(viewModel.labelForIcon.lowercased())"
        imageLogoCrypto.set(imageURL: urlStr)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
