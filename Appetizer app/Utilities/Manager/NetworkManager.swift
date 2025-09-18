//
//  NetworkManager.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 04/09/25.
//

import UIKit

final class NetworkManager {
    static let shared = NetworkManager()  // singleton object so that we dont have to create an instance again and again
     // this will will not allow other to create an  instance
    
    private  let appetizerURL = "https://raw.githubusercontent.com/ShashankYadav28/AppetizerData/main/food_items.json"
  // i have created the url  and i will fetch the data from the github
    private init() {} 
    
    
    private let cache = NSCache<NSString,UIImage>()  // ..  it store the image in the cache memory so that loading view can be stopped
    
    func getAppetizers ( completed:@escaping (Result<[Appetizer], APerror>) -> Void ){   // this function will  will fetch the data from the github
        guard let url = URL(string: appetizerURL) else {   // in this function i have created a completion closure this will run after the data will be fetch
            completed(.failure(.invalidURL))               // here i have craeted the url object
            return
            
        }
        
        let _: Void = URLSession.shared.dataTask(with: url) { data, response, error in    // in this urlSession.shared.data , it used to the send the get request                                                                                   to the server
            if let _ = error {                                                            // it  will give us the three things data,response and error
                completed(.failure(.unableToComplete))                                    // now we have to decode the error first  then respionse and then data
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {   // in this we to unwrap the response and then
                completed(.failure(.invalidResponse))                                                             // in this we have to do we are checking the response is in the correct range or not
                return
                
            }
            
            guard let data = data else {                        // hare also we are unwrapping the data if it is valid we will assign the data  ,..... invalid then we will pass the error
                completed(.failure(.invalidData))              // if there is an error then it will return tghe error
                return
                
            }                                                 // now error handling is done , if there is an error in the network manager then it will give now we need to decode the data
            
            do {
                let decoder = JSONDecoder()                   // this willl decodde the data
                decoder.keyDecodingStrategy = .convertFromSnakeCase     // it will convert the data in the camel case
                let decoderResponse = try decoder.decode([Appetizer].self, from: data)     // here decoder.decode the data , here we have to decode the data to the struct of the                                                                                                       json now i
                completed(.success(decoderResponse))          // it will return the decoded response
                
            }
            catch {
                completed(.failure(.invalidData))
                
            }
            
            
            
        }.resume()
        
        
        
    }
    
    func DownloadImage(fromurlString urlString: String , completed: @escaping (UIImage?) -> Void ) {
        
        let cacheKey = NSString(string: urlString)   // this convert string to nsstring of objective c type because cache  expect the keys of tyoe Nsstring
        if let image =  cache.object(forKey: cacheKey) { // it check if the image is downloaded ,if it is downloaded than no fetching if not then download and                                                    store the image
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ data , response , error in
            guard let data =  data , let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)                // cache key become the unique indentifier to store and fetch the image in the cache
            completed(image)                                                        // here setobject is the object that is used for storing  the image
            
        }
        task.resume()
        
                                                           
        
    }
    
    
}
