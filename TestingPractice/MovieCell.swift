//
//  MovieCell.swift
//  TestingPractice
//
//  Created by C4Q on 4/25/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    public func configureCell(withMovie movie: Movie) {
        titleLabel.text = movie.trackName
        authorLabel.text = movie.artistName
        
        //reset image to prevent flickering
        movieImageView.image = nil
        movieImageView.image = #imageLiteral(resourceName: "placeholder")
        
        //get image
        ImageService.manager.getImage(withURL: movie.imageURL) { (movieImage) in
            self.movieImageView.image = movieImage
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
}
