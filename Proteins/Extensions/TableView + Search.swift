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
        isSearching = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredLigands.removeAll(keepingCapacity: false)
        let searchPredicate = searchBar.text!
        filteredLigands = dictLigand.filter( {$0.name.range(of: searchPredicate) != nil})
//        filteredLigands = dictLigand.filter( { $0.name.contains(searchPredicate)})

//        filteredLigands.sort {$0.name < $1.name}
        isSearching = (filteredLigands.count == 0) ? false: true
        tableView?.reloadData()
    }
}
