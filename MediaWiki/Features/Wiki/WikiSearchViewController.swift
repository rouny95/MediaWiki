//
//  WikiSearchViewController.swift
//  MediaWiki
//
//  Created by Raunak Choudhary on 17/12/18.
//  Copyright © 2018 Raunak. All rights reserved.
//

import UIKit

class WikiSearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noSearchView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var wikiPediaDescriptionLabel: UILabel!
    @IBOutlet weak var viewRecentHistoryButton: UIButton!
    @IBOutlet weak var noSearchHistoryLabel: UILabel!
    
    var wikieSearchList = [WikiSearchResult]()
    var searchTerm: String = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.initalizeSearchBar()
        self.setInitialscreen()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
    }
    
    func initalizeSearchBar() {
        
        searchBar.delegate = self
        searchBar.placeholder = "Search Wikipedia"
        self.searchBar.backgroundImage = UIImage()
        self.searchBar.showsCancelButton = false
        if #available(iOS 9.0, *) {
           UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        }
    }
    
    func setInitialscreen() {
        
        self.noSearchView.isHidden = false
        self.wikieSearchList = []
        if UserDefaultUtil.sharedInstance.fetchUserSearchHistory().count > 0 {
            self.noSearchHistoryLabel.isHidden = true
            self.viewRecentHistoryButton.isHidden = false
        } else {
            self.noSearchHistoryLabel.isHidden = false
            self.viewRecentHistoryButton.isHidden = true
        }
    }
    
    func updateUI() {
        self.noSearchView.isHidden = true
        self.tableView.reloadData()
    }
    
    @IBAction func viewRcenetHistoryClicked(_ sender: Any) {
        self.wikieSearchList = UserDefaultUtil.sharedInstance.fetchUserSearchHistory()
        self.updateUI()
    }
    
    @objc func detailViewTapped(_ recognizer: UITapGestureRecognizer) {
        
        let tag = recognizer.view?.tag
        if let index = tag, let pageId = self.wikieSearchList[index].pageId {
            UserDefaultUtil.sharedInstance.saveUserSearchHistory(self.wikieSearchList[index])
            let wikiPageUrl = "http://en.wikipedia.org/?curid=\(pageId)"
            let wikiDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "WikiDetailPageViewController") as! WikiDetailPageViewController
            wikiDetailVC.urlString = wikiPageUrl
            self.present(wikiDetailVC, animated: true, completion: nil)
        }
    }

    
    func getWikiSearchresults() {
        
        if self.searchTerm != "" {
            ApiManager.sharedInstance.getSearchListWithSearchTerm(self.searchTerm, completion: {(response) -> Void in
                if let queryDicitionary = (response.object(forKey: "query") as? AnyObject) {
                    self.wikieSearchList = []
                    if let pages: [NSDictionary] = (queryDicitionary["pages"] as? [NSDictionary]) {
                        for page in pages {
                            self.wikieSearchList.append(WikiSearchResult(dictionary: page)!)
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.updateUI()
                }
            }, errorHandler: {(error) -> Void in
            })
        }
    }

}

extension WikiSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.wikieSearchList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WikiSearchResultTableViewCell", for: indexPath) as! WikiSearchResultTableViewCell
        let searchResult = self.wikieSearchList[indexPath.row]
        cell.setCellData(wikiSearch: searchResult)
        cell.borderView.tag = indexPath.row
        let detailTapGesture = UITapGestureRecognizer(target: self, action: #selector(WikiSearchViewController.detailViewTapped(_:)))
        detailTapGesture.view?.tag = indexPath.row
        cell.borderView.addGestureRecognizer(detailTapGesture)
        return cell
    }
    
}

extension WikiSearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.noSearchView.isHidden = true
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.text = nil
        self.setInitialscreen()
        self.tableView.reloadData()
        self.view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            if searchText != "" {
                self.searchTerm = searchText
                self.view.endEditing(true)
                self.getWikiSearchresults()
                self.searchBar.text = nil
            }
        }
        self.searchBar.showsCancelButton = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText != "" {
                self.searchTerm = searchText
                self.getWikiSearchresults()
        }
    }
}
