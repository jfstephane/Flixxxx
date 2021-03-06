//
//  ViewController.swift
//  Flixxxx
//
//  Created by Jules Frantz Stephane Loubeau on 9/18/18.
//  Copyright © 2018 Jules Frantz Stephane Loubeau. All rights reserved.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

@IBOutlet weak var tableView: UITableView!
   
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var movies: [[String: Any]] = []
   // var filteredMovies: [[String: Any]] = [];
        var filteredMovies: [[String: Any]]?
    var reasultsController = UITableViewController()
    var url_api: String!
    var refreshControl: UIRefreshControl!
    //var searchController: UISearchController!
    
    let cellSpacingHeight: CGFloat = 5
    let cellReuseIdentifier = "MovieCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
       //activityIndicator.startAnimating()
        self.navigationItem.titleView = searchBar
        
        self.refreshControl = UIRefreshControl()
        
        self.refreshControl.addTarget(self, action: #selector(ViewController.didPullToRefresh(_:)), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh!")
        tableView.insertSubview(refreshControl, at: 0)
        
        
        
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        addMovies()
    }
    
    
    
    func addMovies() {
        activityIndicator.startAnimating()
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                let errorAlertController = UIAlertController(title: "Cannot Get Movies", message: "The Internet connections appears to be offline.", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Retry", style: .cancel)
                errorAlertController.addAction(cancelAction)
                self.present(errorAlertController, animated: true)
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.movies = dataDictionary["results"] as! [[String: Any]]
                 //self.filteredMovies = self.movies;
                self.tableView.reloadData()
            }
            self.refreshControl.endRefreshing()
        }
        task.resume()
        activityIndicator.stopAnimating()
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        addMovies()
    }
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.movies.count
        if self.searchBar.text!.isEmpty{
            return self.movies.count
        }else{
            return filteredMovies?.count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCellTableViewCell
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        
        let posterPathString = movie["poster_path"] as! String
        let baseURLString = "https://image.tmdb.org/t/p/w500"
        let posterURL = URL(string: baseURLString + posterPathString)!
        
        
        let placeholderImage = UIImage(named: "reel_tabbar_icon")
        let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
            size: cell.posterImage.frame.size,
            radius: 5.0)
        
        
        
        cell.posterImage.af_setImage(withURL: posterURL,
                                     placeholderImage: placeholderImage,
                                     filter: filter,
                                     imageTransition: .crossDissolve(1),
                                     runImageTransitionIfCached: false,
                                     completion: (nil)
        
        )
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.lightGray
        cell.selectedBackgroundView = backgroundView
        
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        
        
       
        
        //let imageView = UIImageView(frame: posterImage)
        //let url = URL(string: "https://httpbin.org/image/png")!
        //let placeholderImage = UIImage(named: "placeholder")!
        //cell.posterImage.af_setImage(withURL: url, placeholderImage: placeholderImage)
        
        
        
        
        //let imageView = UIImageView(frame: frame)
        
        //let url = URL(string: "https://httpbin.org/image/png")!
        //let placeholderImage = UIImage(named: "placeholder")!
        
        //let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
           // size: imageView.frame.size,
            //radius: 20.0
       // )
        
        //imageView.af_setImage(
            //withURL: url,
            //placeholderImage: placeholderImage,
            //filter: filter,
            //imageTransition: .crossDissolve(0.2)
        //)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(200)
    }
    
    
    
    /*func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }*/
    
    
    
   /* func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = "cancel"
        searchBar.resignFirstResponder()
    }*/
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
   /* func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredMovies = searchText.isEmpty ? movies : movies.filter{ (movie: [String: Any]) -> Bool in
            return (movie["title"] as! String).localizedCaseInsensitiveContains(searchText)
        }
        tableView.reloadData()
    }*/
    
   /* func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredMovies = searchText.isEmpty ? self.movies : self.movies.filter({(movie) -> Bool in
            return (movie["title"] as! String).range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
        self.tableView.reloadData()
    }*/
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        if(searchText.isEmpty){
            let alertController = UIAlertController(title: "Search field empty", message: "Cannot get result for empty search...", preferredStyle: .alert)
            
            // create an OK action
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // handle response here.
                // self.fetchAllMovies()
            }
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            self.present(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
        }else{
            self.activityIndicator.startAnimating()
            //searchText
            url_api = "https://api.themoviedb.org/3/search/movie?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&query=\(searchText)"
            addMovies();
        }
        
        
    }

   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell) {
            let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
        }
    }


}

