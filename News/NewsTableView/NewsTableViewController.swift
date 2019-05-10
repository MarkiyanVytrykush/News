//
//  NewsTableViewController.swift
//  News
//
//  Created by Nanter on 5/7/19.
//  Copyright © 2019 Nanter. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class NewsTableViewController: UITableViewController {
    
    //MARK: - Outlets

    @IBOutlet private var newsSearchBar: UISearchBar!
    
    //MARK: - Properties

    private let refresher = UIRefreshControl()
    let viewModel = NewsTableViewModel()
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        registerCell()
        configureViewModel()
        addRefresher()
    }
    
    //MARK: - Configures
    
    private func configureViewModel() {
        
        viewModel.didGotData = { [unowned self] in
            DispatchQueue.main.async {
                self.refresher.endRefreshing()
                self.tableView.reloadData()
            }
        }

        viewModel.didError = { [unowned self] error in
            DispatchQueue.main.async {
                self.alert(message: error.localizedDescription)
            }
        }
    }
    
    private func registerCell() {
        let nib = UINib(nibName: "ArticleTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ArticleTableViewCell")
    }

    func addRefresher() {
        refresher.tintColor = UIColor.black
        refresher.attributedTitle = NSAttributedString(string: "Refreshing...")
        tableView.addSubview(refresher)
        refresher.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }

    @objc func refresh() {
        viewModel.getData()
    }
    
    //MARK: - TableView methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.allNews.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell") as! ArticleTableViewCell
        cell.article = viewModel.allNews[indexPath.row]
        cell.delegate = self
        return cell
    }
}

//MARK: - ArticleTableViewCellDelegate

extension NewsTableViewController: ArticleTableViewCellDelegate {
    func didArticleSelected(with url: URL) {
        let safariViewController = Safari.safariViewController(url: url)
        self.present(safariViewController, animated: true)
    }
}

//MARK: - UISearchBarDelegate

extension NewsTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text else { return }
        RequestManager.cancelReques(requst: NetworkManager.shared.currentRequest)
        viewModel.getData(searchParam: searchText)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.endEditing(true)
        
        viewModel.getData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.isEnabled = true
        }
    }
}

