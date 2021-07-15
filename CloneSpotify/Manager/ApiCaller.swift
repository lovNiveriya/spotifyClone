//
//  ApiCaller.swift
//  CloneSpotify
//
//  Created by lov niveriya on 09/07/21.
//

import Foundation

final class APICaller{
    static let shared = APICaller()
    
    public init(){}
    
    struct Constants {
        static let baseAPIURl = "https://api.spotify.com/v1"
    }
    
    enum APIError {
        case failedToGetData
    }
    
    public func getCurrentUserProfile(completion:@escaping (Result<UserProfile,Error>)->Void){
        createRequest(with: URL(string: Constants.baseAPIURl + "/me"), type: .GET) { baserequest in
            let task = URLSession.shared.dataTask(with: baserequest){data,_,error in
                guard let data = data,error == nil else{
                    completion(.failure(APIError.failedToGetData as! Error))
                    return
                }
                do{
                    let reult = try JSONDecoder().decode(UserProfile.self, from: data)
                    completion(.success(reult))
                    print(reult)
                }
                catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    enum HTTPMethod:String {
        case GET
        case POST
    }
    
    //MARK: - Private
    
    private func createRequest(with url: URL?, type:HTTPMethod , completion:@escaping(URLRequest)->Void){
        Authmanager.shared.withValidToken { token in
            guard let apiURL = url else{
                return
            }
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
        
    }
}
