//
//  MovieCell.swift
//  Cinelopis (CLEAN Demo)
//
//  Created by Eduardo Pacheco on 8/31/19.
//  Copyright © 2019 IA Interactive. All rights reserved.
//

import UIKit
import Kingfisher

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

    // MARK: - Public Methods
    func setupCell(withModel model: Movies.GetMovieList.MovieCellViewModel) {
        posterImageView.kf.setImage(with: model.posterURL, placeholder: UIImage(named: "default_image"))
        titleLabel.text = model.titleLabel
        dateLabel.text = model.dateLabel
        scoreLabel.text = model.scoreLabel
    }
}
