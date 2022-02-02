//
//  OverviewViewController.swift
//  collectionViewDemo
//
//  Created by 李都 on 2021/10/22.
//

import UIKit

class OverviewViewController: UIViewController {

    @IBOutlet weak var overviewText: UILabel!
    var labelString: String = ""
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overviewText.text = labelString
    }
    
}
