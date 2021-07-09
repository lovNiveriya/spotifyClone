//
//  AuthViewController.swift
//  CloneSpotify
//
//  Created by lov niveriya on 09/07/21.
//

import UIKit
import WebKit


class AuthViewController: UIViewController,WKNavigationDelegate{
    
    private let webView: WKWebView = {

        let pref = WKWebpagePreferences()
        pref.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = pref
        let webView = WKWebView(frame: .zero, configuration: config)
        return webView

    }()
    
    public var completionHandler: ((Bool)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        title = "Sign In"
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        let request = URLRequest(url: Authmanager.shared.sighnInURL)
        webView.load(request)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else {
            return
        }
        
        //exchange the code for acess token
        guard let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: {$0.name == "code"})?.value
        else{
            return
        }
        print("code: \(code)")
     
    }
}
