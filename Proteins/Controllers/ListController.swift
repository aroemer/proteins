//
//  ListController.swift
//  Proteins
//
//  Created by Audrey ROEMER on 8/17/18.
//  Copyright © 2018 Audrey ROEMER. All rights reserved.
//

import UIKit

class ListController: UITableViewController {
    
    var dictLigand = [Ligands]()
    var filteredLigands = [Ligands]()
    var isSearching: Bool = false

    private let reuseId = "reuseId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = true
        view.backgroundColor = .white
        title = "Ligands"
        
        createLigandArray()
        tableView.register(ProteinCell.self, forCellReuseIdentifier: reuseId)
//        self.navigationController?.setNavigationBarHidden(false, animated: true)

    }
    
    func createLigandArray() {
        guard let path = Bundle.main.path(forResource: "ligands", ofType: "txt")
            else {
                print("incorrect path")
                return
        }
        let filecheck = FileManager.default
        
        if filecheck.fileExists(atPath: path) {
            do {
                let fullText = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                for ligand in fullText.components(separatedBy: "\n") {
                    dictLigand.append(Ligands(ligandName: ligand))
                }
                dictLigand.removeLast()
            }
            catch let error as NSError {
                print("Error: \(error)")
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! ProteinCell
//        DispatchQueue.main.async() {
            if self.isSearching && self.filteredLigands.count != 0 {
                cell.ligand = self.filteredLigands[indexPath.row]
            }
            else {
                cell.ligand = self.dictLigand[indexPath.row]
            }
//        }
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = .listDarkBlue
        }
        else {
            cell.backgroundColor = .listLighterBlue
        }
        tableView.backgroundColor = .listDarkGray
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredLigands.count 
        }
        return dictLigand.count 
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = .listSelectedGray
        let ligandController = LigandController()
        if isSearching && self.filteredLigands.count != 0 {
            ligandController.record = filteredLigands[indexPath.row]
        }
        else {
            ligandController.record = dictLigand[indexPath.row]
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        navigationController?.pushViewController(ligandController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 30))
        let searchBar = UISearchBar()
        v.addSubview(searchBar)
        searchBar.delegate = self
        searchBar.barTintColor = .listSelectedGray
        searchBar.placeholder = "Search"
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = .listSelectedGray
        textFieldInsideSearchBar?.textColor = UIColor.white
        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.textColor = UIColor.white
        
        _ = searchBar.constraint(.leading, to: v, constant: 0)
        _ = searchBar.constraint(.trailing, to: v, constant: 0)
        _ = searchBar.constraint(.top, to: v, constant: 0)
        _ = searchBar.constraint(.bottom, to: v, constant: 0)
        return v
    }
}
