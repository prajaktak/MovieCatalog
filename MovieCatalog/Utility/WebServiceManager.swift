//
//  WebServiceManager.swift
//  ProductBrowser
//
//  Created by Prajakta Kulkarni on 01/07/2018.
//  Copyright © 2018 Prajakta Kulkarni. All rights reserved.
//

import Foundation

class WebserviceManager: NSObject, URLSessionDelegate {
    enum Result<Value> {
        case success(Value)
        case failure(Error)
    }
    func getData(form path: String, completion: ((Result<Data>) -> Void)?) {
        var request = URLRequest(url: URL(string: path)!)
        request.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
        let task = session.dataTask(with: request) { (responseData, _, responseError) in
            DispatchQueue.main.async {
                if let error = responseError {
                    completion?(.failure(error))
                } else if let jsonData = responseData {
                    do {
                            completion?(.success(jsonData))
                        }
                } else {
                    let error = NSError(domain: "", code: 0,
                                        userInfo: [NSLocalizedDescriptionKey: "Data was not retrived"]) as Error
                    completion?(.failure(error))
                }
            }
        }
        task.resume()
    }
}
