//
//  DetailViewController.swift
//  Flixxxx
//
//  Created by Jules Frantz Stephane Loubeau on 9/24/18.
//  Copyright © 2018 Jules Frantz Stephane Loubeau. All rights reserved.
//

import UIKit

enum MovieKeys {
    static let movieID = "id"
    static let title = "title"
    static let overview = "overview"
    static let releaseDate = "release_date"
    static let backdropPath = "backdrop_path"
    static let posterPath = "poster_path"
   
}

class DetailViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var frontImage: UIImageView!
    
    var movie: [String : Any]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = movie![MovieKeys.title] as! String
        let overview = movie![MovieKeys.overview] as! String
        
        titleLabel.text = title
        overviewLabel.text = overview
        
        let backdropPathString = movie![MovieKeys.backdropPath] as! String
        let posterPathString = movie![MovieKeys.posterPath] as! String
        let baseURLString = "https://image.tmdb.org/t/p/w500/"
        
        let backDropURL = URL(string: baseURLString + backdropPathString)!
        posterImageView.af_setImage(withURL: backDropURL)
        
        let posterURL = URL(string: baseURLString + posterPathString)!
        let placeholderImage = UIImage(named: "reel_tabbar_icon")
        frontImage.af_setImage(withURL: posterURL,
                               placeholderImage: placeholderImage)
        frontImage.layer.borderWidth = 1
        frontImage.layer.cornerRadius = 10
        navigationItem.title = movie![MovieKeys.title] as? String

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let TrailerViewController = segue.destination as! TrailerViewController
        TrailerViewController.movieId = (movie![MovieKeys.movieID] as? Int)!
        
    }*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! TrailerViewController
        if let movie = movie {
            let movieId = String(describing: movie[MovieKeys.movieID]!)
            vc.movieId = movieId
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
