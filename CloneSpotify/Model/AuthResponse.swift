import Foundation

struct AuthResponse:Codable {
    
    let access_token:String
    let expires_in:Int
    let refresh_token:String?
    let scope:String
    let token_type:String
    
}

/*
 "access_token" = "BQAH8OJdJkRlo2pOG55dT0ZkXasKcLt2EDohQt4Ku0d5mwWxWMJI9nn2x1YHyGZDngkEKlgMd8fLriWIT8ZsXX8fuSWPBGrkPS5uKxcK5kEdnPuCwogny1sbPLua3Vr6VVZFND8UDgX-5kUnbZurGXcS8ZL2wZFBVZxs_q-uaawc13dJVtE";
 "expires_in" = 3600;
 "refresh_token" = "AQAwtPj-APwvI_sKbabp-pTeowDxABsCuXaAe4Y1X0fhhEK9QfkWjWCM-moKoTV7akH4Dy074Y18t54PVZJGyzM7KN-GSviOLC5eQZi-mZ-SeVzLQG5OeCFKbIexT5SCTiE";
 scope = "user-read-private";
 "token_type" = Bearer;
}
*/
