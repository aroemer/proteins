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
    
    let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: 40))
    let topOffset: CGFloat = 64 // a modifier avec autolayout
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        createLigandArray()
        setupTableView()

        self.clearsSelectionOnViewWillAppear = true
        view.backgroundColor = .white
        title = "Ligands"
    
        view.addSubview(searchBar)
        searchBar.delegate = self
    }
    
    func setupTableView() {
        tableView.contentInset = UIEdgeInsets(top: self.searchBar.frame.size.height, left: 0, bottom: 0, right: 0)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: self.searchBar.frame.size.height, left: 0, bottom: 0, right: 0)
        tableView.register(ProteinCell.self, forCellReuseIdentifier: reuseId)
        
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
        DispatchQueue.main.async() {
            if self.isSearching && self.filteredLigands.count != 0 {
                cell.ligand = self.filteredLigands[indexPath.row]
            }
            else {
                cell.ligand = self.dictLigand[indexPath.row]
            }
        }
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = .listDarkBlue
        }
        else {
            cell.backgroundColor = .listLighterBlue
        }
        let backgroundView = UIView()
        backgroundView.backgroundColor = .listSelectedGray
        cell.selectedBackgroundView = backgroundView
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
        let ligandController = LigandController()
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = .listSelectedGray
        if isSearching && self.filteredLigands.count != 0 {
            ligandController.record = filteredLigands[indexPath.row]
        }
        else {
            ligandController.record = dictLigand[indexPath.row]
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        navigationController?.pushViewController(ligandController, animated: true)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var frame = self.searchBar.frame
        frame.origin.y = scrollView.contentOffset.y + topOffset
        self.searchBar.frame = frame
    }
    
    override func viewDidDisappear(_ animated: Bool) {
//        searchBar.text = ""
//        isSearching = false
    }
    
}
