//
//  ItemCell.swift
//  UdemyCoreDataV1.3
//
//  Created by Miloš Čampar on 3/9/17.
//  Copyright © 2017 Miloš Čampar. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var thumg: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var details: UILabel!
    
    func configureCell(item: Item) {
        
        title.text = item.title
        price.text = "$\(item.price)"
        details.text = item.details
        thumg.image = item.toImage?.image as? UIImage
        
    }
    

}
