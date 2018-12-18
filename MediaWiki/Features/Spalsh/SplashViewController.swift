//
//  SplashViewController.swift
//  MediaWiki
//
//  Created by Raunak Choudhary on 17/12/18.
//  Copyright © 2018 Raunak. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.presentWikiSearchVC()
    }
    

    //MARK: - Navigation Methods
    
    /// Presents Movie List View Controller
    func presentWikiSearchVC() {
        
        let wikiSearchVC = self.storyboard?.instantiateViewController(withIdentifier: "WikiSearchViewController") as! WikiSearchViewController
        self.present(wikiSearchVC, animated: true, completion: nil)
    }

}
