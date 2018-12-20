//
//  BaseViewController.swift
//  MediaWiki
//
//  Created by Raunak Choudhary on 20/12/18.
//  Copyright © 2018 Raunak. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Toast Methods
    
    /// Show Toast, one like in Andorid
    ///
    /// - Parameter message: Message to show in Toast
    func showToast(message: String) {
        
        let toastLbl = UILabel(frame: CGRect(x: self.view.center.x - 130, y: self.view.frame.size.height-50, width: 250, height: 20))
        toastLbl.textColor = UIColor.white
        toastLbl.textAlignment = .center;
        toastLbl.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        toastLbl.font = UIFont(name: "Helvetica Neue-Regular", size: 10.0)
        toastLbl.text = message
        toastLbl.alpha = 1.0
        toastLbl.layer.cornerRadius = 4
        toastLbl.clipsToBounds = true
        self.view.addSubview(toastLbl)
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when) {
            toastLbl.alpha = 0.0
            toastLbl.removeFromSuperview()
        }
    }

}
