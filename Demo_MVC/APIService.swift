//
//  APIService.swift
//  Demo_MVC
//
//  Created by Praveen Kokkula on 22/01/21.
//

import Foundation


let urlString = "https://jsonplaceholder.typicode.com/posts"

class APIService {
    
    private init() {    }
    
    static let shared = APIService()
    
    func call(url: String,httpMethod: String = "GET", completionHandler: @escaping (_ data : Data) -> Void) {
        
        guard let _url = URL(string: url) else {
            return
        }
        
        var request = URLRequest(url: _url)
        request.httpMethod = httpMethod
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
           
            guard error == nil  else { return }
            
            if (response as? HTTPURLResponse)?.statusCode == 200 {
                if let _data = data {
                    completionHandler(_data)
                }
            }
        }
        
        task.resume()
    }
}


class ModelService {
    
    static let shared = ModelService()
    
    private init() {  }
    
    func call(urlString: String, completion: @escaping(_ model: [Model]) -> Void) {
        
        let apiService = APIService.shared
        
        apiService.call(url: urlString) { (data) in
            do {
                let modelData = try JSONDecoder().decode(Array<Model>.self, from: data)
                completion(modelData)
            } catch {
                debugPrint("\(error.localizedDescription)")
            }
        }
    }
    
}
