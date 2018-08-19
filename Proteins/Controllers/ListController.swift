//
//  ListController.swift
//  Proteins
//
//  Created by Audrey ROEMER on 8/17/18.
//  Copyright © 2018 Audrey ROEMER. All rights reserved.
//

import UIKit

class ListController: UITableViewController {
    
    private var dictLigand = [String]()
    private var filteredLigands = [String]()
    let searchController = UISearchController(searchResultsController: nil)

    private let reuseId = "reuseId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Topics"
        setupTableView()
//        setupNavBar()
//        handleLogout()
//        LoginService.shared.delegate = self
//        addController.delegate = self
        
        guard let path = Bundle.main.path(forResource: "ligands", ofType: "txt")
            else {
                print("incorrect path")
                return
        }
        
        let filecheck = FileManager.default
        if filecheck.fileExists(atPath: path) {
            do {
                let fullText = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                dictLigand = fullText.components(separatedBy: "\n") as [String]
                dictLigand.removeLast()
            }
            catch let error as NSError {
                print("Error: \(error)")
            }
        }
    }
    
    func setupTableView() {
        
        tableView.backgroundColor = .lightGray
        tableView.register(ProteinCell.self, forCellReuseIdentifier: reuseId)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! ProteinCell
        DispatchQueue.main.async() {
            cell.textLabel?.text = self.dictLigand[indexPath.row]
        }
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictLigand.count
    }
    
}
