//
//  TableView + Search.swift
//  Proteins
//
//  Created by Audrey Roemer on 24/08/2018.
//  Copyright © 2018 Audrey ROEMER. All rights reserved.
//

import UIKit

extension ListController : UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredLigands.removeAll(keepingCapacity: false)
        let searchPredicate = searchBar.text?.uppercased()
        filteredLigands = dictLigand.filter( { $0.name.contains(searchPredicate!)})
        isSearching = searchText != ""
        tableView?.reloadData()
    }
}
