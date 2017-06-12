//
//  NetworkingService.swift
//  Showing Some Imgurs
//
//  Created by Kyle Lee on 6/11/17.
//  Copyright © 2017 Kyle Lee. All rights reserved.
//

import UIKit

typealias JSON = [String: Any]

class NetworkingService {
    
    static let shared = NetworkingService()
    private init() {}
    
    func getImgurs(success successBlock: @escaping (GetImgursResponse) -> Void) {
        guard let url = URL(string: "https://api.imgur.com/3/gallery/r/cats") else { return }
        var request = URLRequest(url: url)
        request.addValue("Client-ID 0426f95c0435095", forHTTPHeaderField: "authorization")
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, _, _) in
            guard let data = data else { return }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON else { return }
                print(json)
                let getImgursResponse = try GetImgursResponse(json: json)
                DispatchQueue.main.async {
                    successBlock(getImgursResponse)
                }
            } catch {}
        }.resume()
    }
    
    func downloadImage(link: String, success successBlock: @escaping (UIImage) -> Void) {
        guard let url = URL(string: link) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, _, _) in
            guard let data = data,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async {
                successBlock(image)
            }
        }.resume()
    }
}

enum NetworkingError: Error {
    case someError
}
