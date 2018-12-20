//
//  WikiDetailPageViewController.swift
//  MediaWiki
//
//  Created by Raunak Choudhary on 18/12/18.
//  Copyright © 2018 Raunak. All rights reserved.
//

import UIKit
import WebKit

class WikiDetailPageViewController: BaseViewController {
    
    @IBOutlet weak var webviewContainer: UIView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var shareButton: UIButton!
    
    var webView: WKWebView!
    var urlString: String?
    
    //MARK: - Lifecyle Methods
    
    override func loadView() {
        super.loadView()
        self.setWKWebViewConfiguration()
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if Reachability.isConnectedToNetwork() {
            self.errorView.isHidden = true
            self.shareButton.isHidden = false
            self.loadWKWebView()
        } else {
            self.errorView.isHidden = false
            self.shareButton.isHidden = true
            super.showToast(message: "No Internet Connection")
        }
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Observer Methods
    
    /// ProgressBar for Webview
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            print(self.webView.estimatedProgress);
            self.progressView.progress = Float(self.webView.estimatedProgress);
        }
    }
    
    
    //MARK: - Utility Methods
    
    /// Configure WKWebView
    func setWKWebViewConfiguration() {
        
        let webConfiguration = WKWebViewConfiguration()
        self.webView = WKWebView(frame: webviewContainer.bounds, configuration: webConfiguration)
        self.webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.webView.navigationDelegate = self
        self.webviewContainer.addSubview(self.webView)
    }
    
   
    /// WebView Load Request
    func loadWKWebView() {
        
        if let urlString = self.urlString {
            guard let url = URL(string: urlString) else {
                self.shareButton.isHidden = true
                self.errorView.isHidden = false
                return
            }
            self.errorView.isHidden = true
            self.shareButton.isHidden = false
            webView.load(URLRequest(url: url))
        } else {
            self.errorView.isHidden = false
            self.shareButton.isHidden = true
        }
    }
    
    
    //MARK: - IBAction Methods
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /// Share the url with friends
    ///
    /// - Parameter sender: Button
    @IBAction func shareButtonClicked(_ sender: Any) {
        
        if let urlString = self.urlString {
            guard let url = URL(string: urlString) else {
                return
            }
            let shareText = " Wikipedia- \(url)"
            let objectsToShare = [shareText]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }
    }

}

//MARK: - WKNavigationDelegate Methods

extension WikiDetailPageViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        webView.evaluateJavaScript( "document.getElementsByClassName('header')[0].style.display='none'", completionHandler: nil)
    }
    
}
