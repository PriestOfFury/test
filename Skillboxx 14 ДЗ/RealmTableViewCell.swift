//
//  RealmTableViewCell.swift
//  Skillbox 14 ДЗ
//
//  Created by Алёша on 22.05.2020.
//  Copyright © 2020 Алёша. All rights reserved.
//

import UIKit

class RealmTableViewCell: UITableViewCell {
    
    //var realmViewController = RealmViewController()
    
    
    @IBOutlet var doneTaskOutlet: UIButton!
    @IBOutlet var labelOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func doneTaskAction(_ sender: Any) {
        if doneTaskOutlet.currentImage == UIImage(systemName: "checkmark.circle.fill") {
        doneTaskOutlet.setImage(UIImage(systemName: "circle"), for: .normal)
        } else {
            doneTaskOutlet.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)

        }
    }
    
}
