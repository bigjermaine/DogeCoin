//
//  ApiFetch.swift
//  DogeCoin
//
//  Created by Apple on 28/01/2023.
//



import Foundation



  class APICaller {
    
    static let shared = APICaller()
    
    private init() {}
    
    struct Constants {
        static let apikey = "284a4b2a-f4de-40de-8f47-165687b89b66"
        static let baseurl = "https://pro-api.coinmarketcap.com/v1/"
        static let apukeyheader = "X-CMC_PRO_API_KEY"
        static let doge = "dogecoin"
        static let endpoint = "cryptocurrency/quotes/latest"
        
    }
        
        func getdata(completion:@escaping (Result<DogeCoinModel, Error>) -> Void) {
            guard let url = URL(string: Constants.baseurl + Constants.endpoint + "?slug=" + Constants.doge) else {
                completion(.failure(Error.self as! Error))
                return
            }
            print(url.absoluteString)
            var request = URLRequest(url: url)
            request.setValue(Constants.apikey, forHTTPHeaderField: Constants.apukeyheader)
            request.httpMethod = "GET"
            
            
            let task = URLSession.shared.dataTask(with: request) {data ,_ ,error in
                if let error = error {
                    completion(.failure(error))
                }
                guard let data = data else {return}
                
                
               do {
                  
                   let response =  try JSONDecoder().decode(APIResponse.self, from: data)
                   guard let dogecoindata = response.data.values.first else {return}
                   completion(.success(dogecoindata))
              
               }catch{
                   completion(.failure(error))
               }
            }
            task.resume()
            
        }
        
        
        
        
        
        
}
    
    
    

