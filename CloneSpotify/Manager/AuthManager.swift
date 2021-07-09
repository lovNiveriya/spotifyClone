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
    }
    
    private init(){}
    
    public var sighnInURL:URL{
        let base = "https://accounts.spotify.com/authorize"
        let redirectURI = "https://www.iosacademy.io/"
        let scope = "user-read-private"
        let string = "\(base)?response_type=code&client_id=\(Constant.clientId)&scope=\(scope)&redirect_uri=\(redirectURI)&show_dialog=TRUE"
        return URL(string: string)!
    }
    
    var isSignedIn:Bool{
        return false
    }
    private var acessToken:String?{
        return nil
    }
    private var refreshToken:String?{
        return nil
    }
    private var tokenExpirationDate:Date?{
        return nil
    }
    private var shouldRefreshToken:Bool{
        return false
    }
    public func exchangeCodeForToken(code:String, completion: @escaping((Bool)->Void)){
        //Get token
    }
    public func cacheToken(){
        
    }
    public func refreshAcessToken(){
        
    }
}
