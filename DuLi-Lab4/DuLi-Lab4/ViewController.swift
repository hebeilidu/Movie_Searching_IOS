//
//  ViewController.swift
//  collectionViewDemo
//
//  Created by 李都 on 2021/10/12.
//

import UIKit

struct APIResults:Decodable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [Movie]
}
struct Movie: Decodable {
    let adult: Bool!
    let id: Int!
    let poster_path: String?
    let title: String
    let release_date: String?
    let vote_average: Double
    let overview: String
    let vote_count:Int!
}

var theData: [Movie] = []
var theImageCache: [String] = []
var theImageSet: [UIImage] = []
var selectedMovie: Movie!
var FavoriteArray:[String] = []

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchText: UISearchBar!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        spinner.hidesWhenStopped = true
        setupCollectionView()
        self.spinner.startAnimating()
        DispatchQueue.global(qos: .userInitiated).async {
            
            self.fetchData(urlString: "https://api.themoviedb.org/3/movie/popular?api_key=701d9cf0c3d5405dd5a22dabdb085271")
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.spinner.stopAnimating()
            }
        }
    }
    
    func setupCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        searchText.delegate = self
        
        if UserDefaults.standard.object(forKey: "FavoriteMovieItem") == nil
        {
         UserDefaults.standard.set(FavoriteArray, forKey: "FavoriteMovieItem")
         
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let configure = UIContextMenuConfiguration(identifier: nil, previewProvider: nil
        ){_ in
            /*cite:
             One format/way o define a UIAction of one item of the menu and the menu itself
             *    Author: IOS Academy
             *    Date: 2021
             *    Code version: Xcode 13
             *    Availability: https://www.youtube.com/watch?v=a1Agazw2JxM
             */
            let favorite = UIAction(
                title: "Favorite",
                image: UIImage(systemName: "star.fill"),
                identifier: nil,
                discoverabilityTitle: nil,
                state: .off
            ){_ in
                if UserDefaults.standard.object(forKey: "FavoriteMovieItem") == nil
                {
                 UserDefaults.standard.set(FavoriteArray, forKey: "FavoriteMovieItem")
                 
                }
                 var a = UserDefaults.standard.array(forKey: "FavoriteMovieItem") as! [String]
                if !a.contains(theData[indexPath.row].title){
                     a.append(theData[indexPath.row].title)
                     UserDefaults.standard.set(a, forKey: "FavoriteMovieItem")
                 }
            }
            
            return UIMenu(
                title: theData[indexPath.row].title,
                image: nil,
                identifier: nil,
                options: UIMenu.Options.displayInline,
                children: [favorite]
            )
        }
        
        return configure
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.spinner.startAnimating()
        if let text = self.searchText.text{
            
            DispatchQueue.global(qos: .userInitiated).async{
                if text.isEmpty == true{
                    self.fetchData(urlString: "https://api.themoviedb.org/3/movie/popular?api_key=701d9cf0c3d5405dd5a22dabdb085271")
                }else{
                    
                    theData = []
                    theImageCache = []
                    theImageSet = []
                    
                    let urlText = text.replacingOccurrences(of: " ", with: "+")
                    let urlString = "https://api.themoviedb.org/3/search/movie?api_key=701d9cf0c3d5405dd5a22dabdb085271&query=" + urlText
                    let url = URL(string:urlString)
                    let defultUrl = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=701d9cf0c3d5405dd5a22dabdb085271&query=.")
                    let data = try! Data(contentsOf: url ?? defultUrl!)
                    let json = try! JSONDecoder().decode(APIResults.self, from: data)
                    
                    for thedata in json.results{
                        if thedata.poster_path != nil{
                            theData.append(thedata)
                            theImageCache.append(thedata.poster_path!)
                        }
                        
                    }
                    for item in theImageCache{
                        let wholeUrl = "https://image.tmdb.org/t/p/original" + item
                        let url = URL(string: wholeUrl)
                        let data = try? Data(contentsOf: url!)
                        let image = UIImage(data: data!)
                        theImageSet.append(image!)
                    }
            
            }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.spinner.stopAnimating()
                }
            
        }
    }
    }
    
    func fetchData(urlString:String){
        let url = URL(string:urlString)
        let data = try! Data(contentsOf: url!)
        let json = try! JSONDecoder().decode(APIResults.self, from: data)
        
        for thedata in json.results{
            theData.append(thedata)
            theImageCache.append(thedata.poster_path!)
        }
        for item in theImageCache{
            let wholeUrl = "https://image.tmdb.org/t/p/original" + item
            let url = URL(string: wholeUrl)
            let data = try? Data(contentsOf: url!)
            let image = UIImage(data: data!)
            theImageSet.append(image!)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(identifier: "DetailedViewController") as? DetailedViewController
        
        vc?.date = "Released: " + theData[indexPath.row].release_date!
        vc?.scoreString = "Score: " + String(Int(theData[indexPath.row].vote_average * 10)) + "/100"
        vc?.image = theImageSet[indexPath.row]
        vc?.ratingString = "Rating: PG"
        vc?.movieName = theData[indexPath.row].title
        if theData[indexPath.row].adult! == false{
            vc?.ratingString = "Rating: PG"
        }else{
            vc?.ratingString = "Rating: G"
        }
        vc?.title = vc?.movieName
        vc?.overview = theData[indexPath.row].overview
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return theData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        
        cell.backgroundColor = UIColor.clear
        cell.contentView.isUserInteractionEnabled = false
        cell.movieImage.image =  theImageSet[indexPath.row]
        cell.movieTitle.text = theData[indexPath.row].title
        
        cell.movieTitle.backgroundColor = UIColor.black
        cell.movieTitle.textColor = UIColor.white
        
        
        cell.movieImage.backgroundColor = UIColor.clear
        return cell
    }
    
}

