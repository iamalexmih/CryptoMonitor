//
//  ViewController.swift
//  infoCrypto
//
//  Created by Алексей Попроцкий on 18.08.2022.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    private var cryptoItems: [CryptoTableViewCellViewModel] = []
    let searchController = UISearchController(searchResultsController: nil)
    private var cryptoItemsFiltered: [CryptoTableViewCellViewModel] = []
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFilteringEnable: Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty || searchBarScopeIsFiltering)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableViewConfig()
        searchControllerConfig()
        scopeBarConfig()
        fetchAllCrypto()
        FavoriteData.shared.favoriteList = FavoriteCryptoStorageManager.shared.load()
    }

    
    func fetchAllCrypto() {
        ApiServiceWorldCoinIndex.shared.fetchAllCrypto { [weak self] result in
            switch result {
            case .success(let crypto):
                if let crypto = crypto {
                    let cryptoItemsAll = (crypto.compactMap { cryptoModel in
                        CryptoTableViewCellViewModel.init(name: cryptoModel.name ?? "N/A",
                                                          label: cryptoModel.label ?? "N/A",
                                                          price: cryptoModel.price ?? 0.0)
                    })
                    self?.cryptoItems = cryptoItemsAll.filter { $0.price > 0.1 }
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            case .failure(let failure):
                print("Error ApiCallerWorldCoinIndex: " + failure.localizedDescription)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeader") as! CustomHeader
        return view
    }
}


// MARK: - Search Controller
extension ViewController: UISearchResultsUpdating {
    
    private func searchControllerConfig() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text ?? "", scope: scope)
    }
    
    private func filterContentForSearchText(_ searchText: String, scope: String = "Name") {
        cryptoItemsFiltered = cryptoItems.filter{ item in
            let selectedCategoryLabelCrypto = scope == "Label"
            if selectedCategoryLabelCrypto {
                return item.label.lowercased().contains(searchText.lowercased())
            } else {
                return item.name.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
}

// MARK: - Scope Bar
extension ViewController: UISearchBarDelegate {
    func scopeBarConfig() {
        searchController.searchBar.scopeButtonTitles = ["Name", "Label"]
        searchController.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text ?? "", scope: searchBar.scopeButtonTitles?[selectedScope] ?? "Name")
    }
}


// MARK: - TableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func tableViewConfig() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomHeader.self, forHeaderFooterViewReuseIdentifier: "CustomHeader")
        tableView.sectionHeaderTopPadding = 0
        tableView.rowHeight = 55
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFilteringEnable {
            return cryptoItemsFiltered.count
        } else {
            return cryptoItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoTableViewCell.cellId,
                                                       for: indexPath) as? CryptoTableViewCell else { fatalError() }
        let currentCrypto: CryptoTableViewCellViewModel
        if isFilteringEnable {
            currentCrypto = cryptoItemsFiltered[indexPath.row]
        } else {
            currentCrypto = cryptoItems[indexPath.row]
        }
        
        cell.config(with: currentCrypto)
        
        return cell
    }
}
