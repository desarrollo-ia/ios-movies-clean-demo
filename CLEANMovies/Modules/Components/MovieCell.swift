//
//  MovieCell.swift
//  Cinelopis (CLEAN Demo)
//
//  Created by Eduardo Pacheco on 8/31/19.
//  Copyright © 2019 IA Interactive. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!

    // MARK: - Object Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
