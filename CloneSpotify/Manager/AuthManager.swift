//
//  AuthManager.swift
//  CloneSpotify
//
//  Created by lov niveriya on 09/07/21.
//

import Foundation


final class Authmanager{
    static let shared = Authmanager()
    
    struct Constant {
        static let clientId = "ed4145151a5a419e94e94503aed32fc1"
        static let clienScret = "b7964023c43442f393889d31f85c03e6"
        static let tokenAPIURL = "https://accounts.spotify.com/api/token"
        static let rediderctURL = "https://www.iosacademy.io/"
        static let scope = "user-read-private%20playlist-modify-public%20playlist-read-private%20playlist-modify-private%20user-follow-read%20user-library-modify%20user-library-read%20user-read-email"
    }
    
    private init(){}
    
    public var sighnInURL:URL{
        let base = "https://accounts.spotify.com/authorize"
        
        let string = "\(base)?response_type=code&client_id=\(Constant.clientId)&scope=\(Constant.scope)&redirect_uri=\(Constant.rediderctURL)&show_dialog=TRUE"
        return URL(string: string)!
    }
    
    var isSignedIn:Bool{
        return acessToken != nil
    }
    private var acessToken:String?{
        //print(UserDefaults.standard.string(forKey: "userName"))
        return UserDefaults.standard.string(forKey: "access_token")
    }
    private var refreshToken:String?{
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    private var tokenExpirationDate:Date?{
        return UserDefaults.standard.object(forKey: "expirationDate") as? Date
    }
    private var shouldRefreshToken:Bool{
        guard let expiration = tokenExpirationDate else {
            return false
        }
        let currentDate = Date()
        let FiveMinutes:TimeInterval = 300
        return currentDate.addingTimeInterval(FiveMinutes) >= expiration
    }
    public func exchangeCodeForToken(code:String, completion: @escaping((Bool)->Void)){
        guard let url = URL(string: Constant.tokenAPIURL) else {
            return
        }
        
        var components = URLComponents()
        
        components.queryItems = [URLQueryItem(name: "grant_type", value: "authorization_code"),
                                 URLQueryItem(name: "code", value: code),
                                 URLQueryItem(name: "redirect_uri", value: Constant.rediderctURL),
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        let basicToken = Constant.clientId+":"+Constant.clienScret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString()
        else{
            completion(false)
            print("Something went wrong in base64 encoding")
            return
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        let task =  URLSession.shared.dataTask(with: request) { [weak self]data, URLResponse, error in
            guard let data = data,error == nil else{
                completion(false)
                return
            }
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("SUCESS: \(json)")
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self?.cacheToken(result:result)
                completion(true)
            }
            catch{
                completion(false)
                print(error.localizedDescription)
                
            }
        }
        task.resume()
        
    }
    public func cacheToken(result:AuthResponse){
        let defaults = UserDefaults.standard
        defaults.set(result.access_token, forKey: "access_token")
        defaults.set(Date().addingTimeInterval(TimeInterval(result.expires_in)), forKey: "expirationDate")
        if let refresh_token = result.refresh_token{
            defaults.set(refresh_token, forKey: "refresh_token")
        }
        
    }
    public func refreshIfneeded(completion: @escaping ((Bool)->Void)){
        
//        guard shouldRefreshToken else {
//            completion(true)
//            return
//        }
        guard let refreshToken = refreshToken else {
            return
        }
        
        //refresh the token
        
        guard let url = URL(string: Constant.tokenAPIURL) else {
            return
        }
        
        var components = URLComponents()
        
        components.queryItems = [URLQueryItem(name: "grant_type", value: "refresh_token"),
                                 URLQueryItem(name: "refresh_token", value: refreshToken),
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        let basicToken = Constant.clientId+":"+Constant.clienScret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString()
        else{
            completion(false)
            print("Something went wrong in base64 encoding")
            return
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        let task =  URLSession.shared.dataTask(with: request) { [weak self]data, URLResponse, error in
            guard let data = data,error == nil else{
                completion(false)
                return
            }
            do{
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                print("SUCESSFULL REFRESHED")
                self?.cacheToken(result:result)
                completion(true)
            }
            catch{
                completion(false)
                print(error.localizedDescription)
                
            }
        }
        task.resume()
        
        
    }
}
