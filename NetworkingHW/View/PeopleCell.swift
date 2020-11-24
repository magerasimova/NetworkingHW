//
//  PeopleCell.swift
//  NetworkingHW
//
//  Created by Майя Герасимова on 24.11.2020.
//

import UIKit

class PeopleCell: UITableViewCell {
    
    static let identifier = "PeopleCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var peopleImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}
