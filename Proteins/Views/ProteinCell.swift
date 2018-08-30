//
//  ProteinCell.swift
//  Proteins
//
//  Created by Audrey ROEMER on 8/19/18.
//  Copyright © 2018 Audrey ROEMER. All rights reserved.
//

import UIKit

class ProteinCell: UITableViewCell {
    
    var ligand: Ligands? {
        didSet {
            guard let ligand = ligand else { return }
            ligandImage.image = ligand.image
            ligandLabel.text = ligand.name
        }
    }
    
    private let ligandLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let ligandImage : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        addSubview(ligandImage)
        addSubview(ligandLabel)
    }
    
    func setUpConstraints() {
        ligandImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 90, height: 0, enableInsets: false)
        ligandLabel.anchor(top: topAnchor, left: ligandImage.rightAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
    }
}

