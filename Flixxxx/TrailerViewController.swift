//
//  TrailerViewController.swift
//  Flixxxx
//
//  Created by Jules Frantz Stephane Loubeau on 9/24/18.
//  Copyright © 2018 Jules Frantz Stephane Loubeau. All rights reserved.
//

import UIKit

class TrailerViewController: UIViewController {
    
    var movieID:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let baseURLString = "https://api.themoviedb.org/3/movie/"
        let postURL = (String(movieID) + "/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")
        let videoURL = (baseURLString + postURL)
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
