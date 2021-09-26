//
//  SearchMovieTableViewController.swift
//  challenge-mobile2you
//
//  Created by Softbuilder Hibrido on 26/09/21.
//

import UIKit

class SearchMovieTableViewController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchModel: SearchMovieViewModel = SearchMovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchModel.delegate = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchModel.movie.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        cell.textLabel?.text = searchModel.movie[indexPath.row].original_title
        cell.textLabel?.textColor = .white
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailMovieViewController {
            vc.idMovie = self.searchModel.movie[indexPath.row].id
            present(vc, animated: true, completion: nil)
        }
    }
     
}

extension SearchMovieTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            self.searchModel.getMovieSearch(nameSearch: searchText)
        }
        view.endEditing(true)
    }
    
}

extension SearchMovieTableViewController: SearchMovieDelegate {
    func finishFetchMovie() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func failFetchMovie(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Ops!", message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.searchModel.movie.removeAll()
            self.tableView.reloadData()
        }
    }
}
