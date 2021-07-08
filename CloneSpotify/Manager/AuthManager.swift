//
//  AuthManager.swift
//  CloneSpotify
//
//  Created by lov niveriya on 09/07/21.
//

import Foundation

final class Authmanager{
    static let shared = Authmanager()
    
    private init(){}
    
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
}
