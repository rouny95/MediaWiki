//
//  WikiDetailPageViewController.swift
//  MediaWiki
//
//  Created by Raunak Choudhary on 18/12/18.
//  Copyright © 2018 Raunak. All rights reserved.
//

import UIKit
import WebKit

class WikiDetailPageViewController: BaseViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webviewContainer: UIView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var errorView: UIView!
    
    var webView: WKWebView!
    var urlString: String?
    
    override func loadView() {
        super.loadView()
        self.setWKWebViewConfiguration()
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if Reachability.isConnectedToNetwork() {
            self.errorView.isHidden = true
            self.loadWKWebView()
        } else {
            self.errorView.isHidden = false
            super.showToast(message: "No Internet Connection")
        }
        // Do any additional setup after loading the view.
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            print(self.webView.estimatedProgress);
            self.progressView.progress = Float(self.webView.estimatedProgress);
        }
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
                self.errorView.isHidden = false
                return
            }
            self.errorView.isHidden = true
            webView.load(URLRequest(url: url))
        } else {
            self.errorView.isHidden = false
        }
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
