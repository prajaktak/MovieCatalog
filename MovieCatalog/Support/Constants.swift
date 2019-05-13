//
//  Constants.swift
//  MovieCatalog
//
//  Created by Prajakta Kulkarni on 09/05/2019.
//  Copyright © 2019 Prajakta Kulkarni. All rights reserved.
//

import Foundation
import XCDYouTubeKit

let apiKey = "dde5205bac1cb1a501e21b28358852a6"
let moviesApi = "https://api.themoviedb.org/3/movie/popular"
let movieDetails = "https://api.themoviedb.org/3/movie"
let movieImageBaseURL = "https://image.tmdb.org/t/p/original"
let movieTrailer = "/videos"
let youTubeUrl = "https://www.youtube.com/watch?v="
enum Genre: Int {
    case Action = 28
    case Adventure = 12
    case Animation = 16
    case Comedy = 35
    case Crime = 80
    case Documentary = 99
    case Drama = 18
    case Family = 10751
    case Fantasy = 14
    case History = 36
    case Horror = 27
    case Music = 10402
    case Mystery = 9648
    case Romance = 10749
    case ScienceFiction = 878
    case TVMovie = 10770
    case Thriller = 53
    case War = 10752
    case Western = 37
    
    func getGenerName() -> String {
        switch self {
        case Genre.Action:
            return "Action"
        case Genre.Adventure:
            return "Adventure"
        case Genre.Animation:
            return "Animation"
        case Genre.Comedy:
            return "Comedy"
        case Genre.Crime:
            return "Crime"
        case Genre.Documentary:
            return "Documentry"
        case Genre.Drama:
            return "Drama"
        case Genre.Family:
            return "Family"
        case Genre.Fantasy:
            return "Fantasy"
        case Genre.History:
            return "History"
        case Genre.Horror:
            return "Horror"
        case Genre.Music:
            return "Music"
        case Genre.Mystery:
            return "Mystery"
        case Genre.Romance:
            return "Romance"
        case Genre.ScienceFiction:
            return "ScienceFiction"
        case Genre.TVMovie:
            return "TV Movie"
        case Genre.Thriller:
            return "Thriller"
        case Genre.War:
            return "War"
        case Genre.Western:
            return "Western"
        }
    }
}

struct YouTubeVideoQuality {
    static let hd720 = NSNumber(value: XCDYouTubeVideoQuality.HD720.rawValue)
    static let medium360 = NSNumber(value: XCDYouTubeVideoQuality.medium360.rawValue)
    static let small240 = NSNumber(value: XCDYouTubeVideoQuality.small240.rawValue)
}

let networkAlertTitle = "Network"
let networkAlertMessage = "Please check internet connection and try after sometime."
let networkAlertAction = "Ok"

let yForMovieNameLabel = 8
let yForMovieWatchTrailerButton = 8
let xForMovieNameLabel = 20
let xForMovieWatchTrailerButton = 20
let rightXPosterImageView = 0
let potraitViewWidth =  UIScreen.main.bounds.width
let potraitViewHeight =  UIScreen.main.bounds.height

let showAlert: (_ vc:UIViewController) -> () =  {(vc) in
        let alert = UIAlertController(title: networkAlertTitle, message: networkAlertMessage, preferredStyle:.alert)
        alert.addAction(UIAlertAction(title: networkAlertAction, style: .cancel, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
