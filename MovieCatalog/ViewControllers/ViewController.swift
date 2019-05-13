//
//  ViewController.swift
//  MovieViewer
//
//  Created by Prajakta Kulkarni on 06/05/2019.
//  Copyright © 2019 Prajakta Kulkarni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var moviesTableView: UITableView!
    var moviesArray = NSMutableArray()
    var selectedRow = 0
    private let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        if Reachability.isConnectedToNetwork() {
            getMovies();
            moviesTableView.isUserInteractionEnabled = true
        }else {
            showAlert(self)
        }
        
        
    }
    func setupTableView() {
        moviesTableView.register(UINib(nibName: "MovieCatalogTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCatalogTableViewCell")
        moviesTableView.refreshControl = refreshControl
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
    }
    @objc private func refreshWeatherData(_ sender: Any) {
        // Fetch Weather Data
        fetchWeatherData()
    }
    private func fetchWeatherData() {
        if Reachability.isConnectedToNetwork() {
            getMovies();
            self.refreshControl.endRefreshing()
            moviesTableView.isUserInteractionEnabled = true
        }else {
            showAlert(self)
            self.refreshControl.endRefreshing()
        }
    }
    
    func getMovies() {
        WebserviceManager().getData(form: moviesApi+"?api_key="+apiKey) { (result) in
            switch result {
            case .success(let jsonData):
                self.initializeMovieArray(jsonData: jsonData)
                self.moviesTableView.reloadData()
                print("Success")
            case .failure:
                print("Failure")
            }
        }
    }
    func initializeMovieArray(jsonData: Data) {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            var movieArray: NSArray!
            movieArray = jsonObject?.value(forKey: "results") as? NSArray
            if (movieArray != nil) {
               
            }else {
                movieArray = NSArray()
            }
            for i in 0 ..< movieArray.count {
                moviesArray.add(Movie(movieDictionary: movieArray?[i] as? NSDictionary ?? NSDictionary()))
            }
            print(moviesArray)
        } catch  {
            print("Error occured")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController = segue.destination as? MovieDetailsViewController
        detailViewController?.movieDictionary = moviesArray[selectedRow] as? Movie
    }

}
extension ViewController:UITableViewDelegate {
    
}
extension ViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MovieCatalogTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MovieCatalogTableViewCell") as? MovieCatalogTableViewCell ?? MovieCatalogTableViewCell()
        let movieItem = moviesArray[indexPath.item] as? Movie
        let movieImageUrlString  = movieImageBaseURL+(movieItem?.movieImageUrl ?? " ")
        print(movieImageUrlString)
        cell.movieImageView.loadImageUsingCacheWithURLString(movieImageUrlString, placeHolder: UIImage(named: "default"))
        cell.movieNameLabel.text = movieItem?.movieName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow =  indexPath.item
        self.performSegue(withIdentifier: "showMovieDetails", sender: nil)
    }
    
    
}

