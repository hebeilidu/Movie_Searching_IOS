//
//  tableViewController.swift
//  collectionViewDemo
//
//  Created by 李都 on 2021/10/15.
//

import UIKit

class tableViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let b = UserDefaults.standard.array(forKey: "FavoriteMovieItem") as![String]
        return b.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let b = UserDefaults.standard.array(forKey: "FavoriteMovieItem") as![String]
        let vc = storyboard?.instantiateViewController(identifier: "OverviewViewController") as? OverviewViewController
        
        for item in theData{
            if b[indexPath.row] == item.title{
                vc?.labelString = item.overview
            }
        }
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            var b = UserDefaults.standard.array(forKey: "FavoriteMovieItem") as![String]
            
            b.remove(at: indexPath.row)
            UserDefaults.standard.set(b, forKey: "FavoriteMovieItem")
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let b = UserDefaults.standard.array(forKey: "FavoriteMovieItem") as![String]
        let myCell = UITableViewCell(style: .default, reuseIdentifier: nil)
        myCell.textLabel?.text = b[indexPath.row]
        
        return myCell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.reloadData()
    }

}
