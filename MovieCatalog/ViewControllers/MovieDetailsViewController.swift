//
//  MovieDetailsViewController.swift
//  MovieViewer
//
//  Created by Prajakta Kulkarni on 06/05/2019.
//  Copyright © 2019 Prajakta Kulkarni. All rights reserved.
//

import UIKit
//import WebKit
import AVKit
import XCDYouTubeKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    var movieDictionary: Movie!
    var movieVideos = NSArray()
    
    @IBOutlet weak var watchTrailerButton: UIButton!
    
 
    @IBOutlet weak var widthLayoutPosterImageView: NSLayoutConstraint!
    @IBOutlet weak var yLayoutConstraintWatchTrailerButton: NSLayoutConstraint!
    @IBOutlet weak var xLayoutConstraintWatchTrailerButton: NSLayoutConstraint!
    @IBOutlet weak var yLayoutConstrintMovieName: NSLayoutConstraint!
    @IBOutlet weak var xLayoutConstraintMovieName: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupMovieDetails()
        setupView()
        if Reachability.isConnectedToNetwork() {
             getVideos()
        }else {
            showAlert(self)
        }
       
    }
    
    func setupMovieDetails() {
        movieName.text = movieDictionary.movieName
        let movieImageUrlString  = movieImageBaseURL+(movieDictionary?.movieImageUrl ?? " ")
        posterImageView.loadImageUsingCacheWithURLString(movieImageUrlString, placeHolder: UIImage(named: "default"))

    }
    
    func setupView() {
        if UIDevice.current.orientation.isLandscape {
            self.setupLanscapeLayoutConstraint()
        }else {
            self.setupPotraitLayoutConstraint()
        }
    }
    
    func getVideos(){
        
        WebserviceManager().getData(form: movieDetails + "/\(movieDictionary.movieId)" + movieTrailer + "?api_key=" + apiKey) { (result) in
            switch result {
            case .success(let movieVideosData):
                do{
                    let jsonObject = try JSONSerialization.jsonObject(with: movieVideosData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                    print (jsonObject ?? "Object not present")
                    self.movieVideos = jsonObject?.value(forKey: "results") as? NSArray ?? NSArray()
                    print ("Videos list = \(self.movieVideos)")
                }catch {
                    
                }
                print("Success")
                
            case .failure:
                print("Failuer")
            }
        }
    }
    
    func setupPotraitLayoutConstraint() {
        widthLayoutPosterImageView.constant = potraitViewWidth
        xLayoutConstraintMovieName.constant = CGFloat(xForMovieNameLabel)
        xLayoutConstraintWatchTrailerButton.constant = CGFloat(xForMovieWatchTrailerButton)
        yLayoutConstrintMovieName.constant = CGFloat(Int(self.posterImageView.bounds.size.height) + yForMovieNameLabel)
        yLayoutConstraintWatchTrailerButton.constant = CGFloat(yForMovieWatchTrailerButton)
       
        
    }
    
    func setupLanscapeLayoutConstraint() {
        widthLayoutPosterImageView.constant = potraitViewHeight/2
        xLayoutConstraintMovieName.constant = CGFloat(xForMovieNameLabel + Int(posterImageView.bounds.size.width))
        xLayoutConstraintWatchTrailerButton.constant = CGFloat(xForMovieWatchTrailerButton + Int (posterImageView.bounds.size.width))
        yLayoutConstrintMovieName.constant = CGFloat(yForMovieNameLabel)
        yLayoutConstraintWatchTrailerButton.constant = CGFloat(self.posterImageView.frame.height - watchTrailerButton.bounds.size.height)
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
         setupView()
    }
    
    @IBAction func watchTrailer(_ sender: UIButton) {
        if Reachability.isConnectedToNetwork() {
            if movieVideos.count > 0{
                let movieVideoDictionary = movieVideos[0] as? NSDictionary
                let playerViewController = AVPlayerViewController()
                self.present(playerViewController, animated: true, completion: nil)
                let movieIdentifier = movieVideoDictionary?.value(forKey: "key") as? String
                XCDYouTubeClient.default().getVideoWithIdentifier(movieIdentifier) { [weak playerViewController] (video: XCDYouTubeVideo?, error: Error?) in
                    if let streamURLs = video?.streamURLs, let streamURL = (streamURLs[XCDYouTubeVideoQualityHTTPLiveStreaming] ?? streamURLs[YouTubeVideoQuality.hd720] ?? streamURLs[YouTubeVideoQuality.medium360] ?? streamURLs[YouTubeVideoQuality.small240]) {
                        playerViewController?.player = AVPlayer(url: streamURL)
                        NotificationCenter.default.addObserver(self, selector: #selector(self.finishVideo), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
                        playerViewController?.player?.play()
                    } else {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }else {
                if Reachability.isConnectedToNetwork() {
                    getVideos()
                }else {
                    showAlert(self)
                }
            }
        }else {
            showAlert(self)
//            let alert = UIAlertController(title: networkAlertTitle, message: networkAlertMessage, preferredStyle:.alert)
//            alert.addAction(UIAlertAction(title: networkAlertAction, style: .cancel, handler: nil))
//            self.present(alert, animated: true, completion: nil)
        }
        
    }
    @objc func finishVideo() {
        self.dismiss(animated: true, completion: nil)
    }

}
extension MovieDetailsViewController:UITableViewDelegate {
    
}
extension MovieDetailsViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        cell.textLabel?.text = " "
        switch indexPath.section {
        case 0:
             cell.textLabel?.text = movieDictionary.movieGenre
        case 1:
             cell.textLabel?.text = movieDictionary.movieReleaseDate
        case 2:
            cell.textLabel?.text = movieDictionary.movieOverview
            cell.textLabel?.numberOfLines = 0
            
        default:
            cell.textLabel?.text = " "
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionName: String
        switch section {
        case 0:
            sectionName = NSLocalizedString("Genre", comment: "Genre")
        case 1:
            sectionName = NSLocalizedString("Date", comment: "Date")
        case 2:
            sectionName = NSLocalizedString("Overview", comment: "Overview")

        default:
            sectionName = ""
        }
        return sectionName
    }
}
