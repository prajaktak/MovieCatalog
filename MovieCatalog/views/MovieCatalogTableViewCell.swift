//
//  MovieCatalogTableViewCell.swift
//  MovieViewer
//
//  Created by Prajakta Kulkarni on 07/05/2019.
//  Copyright © 2019 Prajakta Kulkarni. All rights reserved.
//

import UIKit

class MovieCatalogTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
