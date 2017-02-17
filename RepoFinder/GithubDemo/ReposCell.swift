//
//  ReposCell.swift
//  GithubDemo
//
//  Created by Enzo Ames on 2/16/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class ReposCell: UITableViewCell {

    @IBOutlet weak var ownerHandlerLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var repoDescriptionLabel: UILabel!
    
    @IBOutlet weak var starsLabel: UILabel!
    
    @IBOutlet weak var forksLabel: UILabel!
    
    @IBOutlet weak var ownerAvatarImageView: UIImageView!
    
    @IBOutlet weak var starsImageView: UIImageView!
    
    @IBOutlet weak var forksImageView: UIImageView!
    
    var repo: GithubRepo!
    {
        didSet
        {
            ownerHandlerLabel.text = repo.ownerHandle
            nameLabel.text = repo.name
            repoDescriptionLabel.text = repo.repoDescription
            ownerAvatarImageView.setImageWith(URL(string: repo.ownerAvatarURL!)!)
            starsLabel.text = "\(repo.stars!)"
            forksLabel.text = "\(repo.forks!)"
            starsImageView.image = #imageLiteral(resourceName: "star")
            forksImageView.image = #imageLiteral(resourceName: "fork")
            
        }
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ownerHandlerLabel.preferredMaxLayoutWidth = ownerHandlerLabel.frame.size.width
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        ownerHandlerLabel.preferredMaxLayoutWidth = ownerHandlerLabel.frame.size.width
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
