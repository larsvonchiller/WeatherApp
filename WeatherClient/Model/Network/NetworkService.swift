//
//  NetworkService.swift
//  WeatherClient
//
//  Created by Matoshko Andrey on 5/16/20.
//  Copyright © 2020 Matoshko Andrey. All rights reserved.
//

import Foundation

final class NetworkService {
    typealias Completion = (_ statusCode: Int, _ value: Any?) -> ()
    
    class func url(_ router: ApiRouter) -> URL {
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        components.queryItems = router.query
        guard let url = components.url else { fatalError() }
        return url
    }
    
    class func request(_ router: ApiRouter, completion: @escaping Completion) {
        let session = URLSession.shared
        
        var request = URLRequest(url: url(router))
        request.httpMethod = router.method
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else { return }
            
            completion(httpResponse.statusCode, data)
        }
        
        task.resume()
    }
    
    
}
