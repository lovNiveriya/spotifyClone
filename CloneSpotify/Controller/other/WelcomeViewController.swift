//
//  WelcomeViewController.swift
//  CloneSpotify
//
//  Created by lov niveriya on 09/07/21.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    private let button:UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Sign In with Spotify", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Spotify"
        view.backgroundColor = .systemGreen
        view.addSubview(button)
        button.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.frame = CGRect(x: 20, y: view.height-50-view.safeAreaInsets.bottom, width: view.width-40, height: 50)
    }
    
    @objc func didTapSignIn(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "welcome", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "welcome") as! AuthViewController
        
        nextViewController.completionHandler = { [weak self]sucess in
            DispatchQueue.main.async {
                self?.handelSignIn(sucess: sucess)
            }
        }
        nextViewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(nextViewController, animated: true)

    }
    private func handelSignIn(sucess:Bool){
        //Log user in or yell them an error
    }
}
