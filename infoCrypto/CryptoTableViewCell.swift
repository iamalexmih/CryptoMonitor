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
    @IBOutlet var buttonFavorite: UIButton!
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
        
        if FavoriteData.shared.favoriteList.contains(viewModel.name) {
            buttonFavorite.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            buttonFavorite.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func buttonFavoritePress(_ sender: UIButton) {
        if FavoriteData.shared.favoriteList.contains(labelName.text!) {
            buttonFavorite.setImage(UIImage(systemName: "star"), for: .normal)
            if let index = FavoriteData.shared.favoriteList.firstIndex(of: labelName.text!) {
                FavoriteData.shared.favoriteList.remove(at: index)
            }
        } else {
            FavoriteData.shared.favoriteList.append(labelName.text!)
            buttonFavorite.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        FavoriteCryptoStorageManager.shared.save(favoriteList: FavoriteData.shared.favoriteList)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
