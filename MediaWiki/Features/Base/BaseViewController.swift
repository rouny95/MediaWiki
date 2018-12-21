//
//  BaseViewController.swift
//  MediaWiki
//
//  Created by Raunak Choudhary on 20/12/18.
//  Copyright © 2018 Raunak. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var loadingView = UIView()
    var dimView = UIView()
    var activityIndicatorWidth : CGFloat = 20
    var OuterView : UIView = UIView()
    var activityIndicatorOne : UIActivityIndicatorView = UIActivityIndicatorView()
    var loaderLabel : UILabel  = UILabel()

    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadingView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        loadingView.backgroundColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.2)
        self.dimView = UIView(frame: view.bounds)
        dimView.backgroundColor = UIColor(white: 0, alpha: 0.2)
        self.view.addSubview(self.dimView)
        self.view.addSubview(self.loadingView)
        self.loadingView.isHidden = true
        self.dimView.isHidden = true
        
        //Properties for Outer View in which we will add Activity Indicator.
        OuterView.frame = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 125, height: 125))
        OuterView.center = self.view.center
        OuterView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.9)
        OuterView.clipsToBounds = true
        OuterView.layer.cornerRadius = 10
        
        
        //Activity Indicator Properties
        activityIndicatorOne.frame = CGRect(origin: CGPoint(x: 0,y : 0), size: CGSize(width: 40, height: 40))
        activityIndicatorOne.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicatorOne.center = CGPoint(x: OuterView.frame.size.width / 2 ,y : (OuterView.frame.size.height / 2 - 20))
        
        //Label to display text as LOADING... below activity Indicator
        loaderLabel = UILabel(frame: CGRect(x: self.OuterView.frame.size.width - 135, y:self.OuterView.frame.height - 50 , width: 150, height: 20))
        loaderLabel.textColor = UIColor.white
        //        loaderLabel.center.x = self.OuterView.center.x
        loaderLabel.textAlignment = .center
        loaderLabel.font = UIFont(name: "SFUIText-Light", size: 12.0)
        // loaderLabel.text = CommmonStringConstants.LOADING_TEXT
        
        // Do any additional setup after loading the view.

    }
    
     //MARK: - Animation Methods
    
    /// Starts Loader Animation
    func startAnimating() {
        
        loaderLabel.text = "Loading"
        OuterView.alpha = 1.0
        //Adding first activity Indicator and then Label to OuterView
        self.OuterView.addSubview(activityIndicatorOne)
        self.OuterView.addSubview(loaderLabel)
        self.view.addSubview(OuterView)
        activityIndicatorOne.startAnimating()
    }
    
    /// Stops Loader Animation
    func stopAnimating() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations:{
            self.OuterView.alpha = 0.0
        }, completion: {(isCompleted) in
            self.activityIndicatorOne.stopAnimating()
            self.OuterView.removeFromSuperview()
        })
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
    
    //MARK: - Alert Methods
    /// Show Alert
    ///
    /// - Parameters:
    ///   - title: Title of Alert
    ///   - message: Alert Description
    func showAlertMessage(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
