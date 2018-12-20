//
//  WikiSearchResultTableViewCell.swift
//  MediaWiki
//
//  Created by Raunak Choudhary on 18/12/18.
//  Copyright © 2018 Raunak. All rights reserved.
//

import UIKit
import Nuke

class WikiSearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var wikiSearchImageView: UIImageView!
    @IBOutlet weak var wikiSearchTitleLabel: UILabel!
    @IBOutlet weak var wikiSearchDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /// Set Cell Data
    ///
    /// - Parameter wikiSearch: WikiSearchResult Object
    func setCellData(wikiSearch: WikiSearchResult) {
        self.wikiSearchTitleLabel.text = wikiSearch.title ?? ""
        self.wikiSearchDescriptionLabel.text = wikiSearch.wikieDescription ?? ""
        self.wikiSearchImageView.image = UIImage()
        if let imageView = self.wikiSearchImageView, let _ = wikiSearch.thumbnailUrl {
            let imageUrl = URL(string: wikiSearch.thumbnailUrl!)
            if imageUrl != nil && UIApplication.shared.canOpenURL(imageUrl!) {
                Nuke.loadImage(with: imageUrl!, into: imageView)
            } else {
                self.wikiSearchImageView.image = UIImage(named: "ic_default")
            }
        } else {
            self.wikiSearchImageView.image = UIImage(named: "ic_default")
        }
    }

}
