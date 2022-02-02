//
//  DetailedViewController.swift
//  collectionViewDemo
//
//  Created by 李都 on 2021/10/14.
//

import UIKit

class DetailedViewController: UIViewController {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var releaseTime: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var addFavoriteButton: UIButton!
    @IBOutlet weak var SaveButton: UIButton!
    @IBOutlet weak var overviewButton: UIButton!
    
    var date:String = ""
    var scoreString:String = ""
    var ratingString:String = ""
    var image:UIImage!
    var movieName:String = ""
    var overview:String = ""
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDetailView()
    }
    
    func setupDetailView(){
        releaseTime.text = date
        score.text = scoreString
        rating.text = ratingString
        movieImage.image = image
        movieImage.backgroundColor = UIColor.clear
        addFavoriteButton.layer.borderColor = UIColor.systemBlue.cgColor
        addFavoriteButton.layer.borderWidth = 1.0
        SaveButton.layer.borderColor = UIColor.systemBlue.cgColor
        SaveButton.layer.borderWidth = 1.0
        overviewButton.layer.borderColor = UIColor.systemBlue.cgColor
        overviewButton.layer.borderWidth = 1.0
    }
    
    
    
    @IBAction func OverviewPressed(_ sender: Any) {
       print(overview)
        let vc = storyboard?.instantiateViewController(identifier: "OverviewViewController") as? OverviewViewController
        
        vc?.labelString = overview
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func savePressed(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
    @IBAction func addFavorite(_ sender: Any) {
        
       if UserDefaults.standard.object(forKey: "FavoriteMovieItem") == nil
       {
        UserDefaults.standard.set(FavoriteArray, forKey: "FavoriteMovieItem")
        
       }
        var a = UserDefaults.standard.array(forKey: "FavoriteMovieItem") as! [String]
        if !a.contains(movieName){
            a.append(movieName)
            UserDefaults.standard.set(a, forKey: "FavoriteMovieItem")
        }
    }
    
}
