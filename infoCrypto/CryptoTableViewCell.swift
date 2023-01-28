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
        labelSymbol.text = viewModel.label
        labelPrice.text =  String(format: "%.3f", viewModel.price)
        
        imageLogoCrypto.layer.cornerRadius = imageLogoCrypto.frame.height/2
        
        let urlStr = "https://coinicons-api.vercel.app/api/icon/\(viewModel.labelForIcon.lowercased())"
        imageLogoCrypto.set(imageURL: urlStr)
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
}
