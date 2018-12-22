//
//  TodoTableViewCell.swift
//  MyTodolist
//
//  Created by Vladislav VOROBYEV on 21/12/2018.
//  Copyright © 2018 Vladislav VOROBYEV. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
//    Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var taskLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
