//
//  APIClient.swift
//  SportsApp
//
//  Created by Mahmoud Morsy on 24/03/2021.
//

import Foundation
import Alamofire

class APIClient {
    
    fileprivate let baseURL = "https://www.thesportsdb.com/api/v1/json/1/"
    
    
    func fetchData<T: Decodable>(endPoint: String, responseClass: T.Type , completion:@escaping (Result<T?, NSError>) -> Void) {
        
        if(!self.isConnectedToInternet()){
            return completion(.failure(NSError(domain: baseURL + endPoint, code: -1, userInfo: [NSLocalizedDescriptionKey: "No Internet Connection"])))
        }
        
        AF.request(baseURL + endPoint, method: .get, parameters: [:], headers: [:]).responseJSON {
            (response) in
            guard let statusCode = response.response?.statusCode else { return }
            
            if statusCode == 200 {
                guard let jsonResponse = try? response.result.get() else { return }
                guard let theJSONData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) else { return }
                
                guard let responseObj = try? JSONDecoder().decode(T.self, from: theJSONData) else {
                    let error = NSError(domain: self.baseURL + endPoint, code: 1, userInfo: [NSLocalizedDescriptionKey: "Parsing Error"])
                    completion(.failure(error))
                    return }
                completion(.success(responseObj))
            }else{
                return completion(.failure(NSError(domain: self.baseURL + endPoint, code: 0, userInfo: [NSLocalizedDescriptionKey: "Can not reach the data please try again later!"])))
            }
        }
    }
    
    func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
    

