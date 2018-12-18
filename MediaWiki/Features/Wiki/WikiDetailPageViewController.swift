//
//  WikiDetailPageViewController.swift
//  MediaWiki
//
//  Created by Raunak Choudhary on 18/12/18.
//  Copyright © 2018 Raunak. All rights reserved.
//

import UIKit
import WebKit

class WikiDetailPageViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webviewContainer: UIView!
    
    var webView: WKWebView!
    var urlString: String?
    
    override func loadView() {
        super.loadView()
        self.setWKWebViewConfiguration()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadWKWebView()
        // Do any additional setup after loading the view.
    }
    
    func setWKWebViewConfiguration() {
        
        let webConfiguration = WKWebViewConfiguration()
        self.webView = WKWebView(frame: webviewContainer.bounds, configuration: webConfiguration)
        self.webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.webView.navigationDelegate = self
        self.webviewContainer.addSubview(self.webView)
    }
    
    func loadWKWebView() {
        if let urlString = self.urlString {
            guard let url = URL(string: urlString) else {
                return
            }
            webView.load(URLRequest(url: url))
        }
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
