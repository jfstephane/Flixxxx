//
//  DetailViewController.swift
//  Flixxxx
//
//  Created by Jules Frantz Stephane Loubeau on 9/24/18.
//  Copyright © 2018 Jules Frantz Stephane Loubeau. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var infoView: UIView!
    
     //var movies: [[String: Any]] = []
    var movie: [String : Any]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = movie!["title"] as! String
        let overview = movie!["overview"] as! String
        
        titleLabel.text = title
        overviewLabel.text = overview
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
