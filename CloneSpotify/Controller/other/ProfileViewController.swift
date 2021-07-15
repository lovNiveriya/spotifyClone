//
//  ProfileViewController.swift
//  CloneSpotify
//
//  Created by lov niveriya on 09/07/21.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Profile"
        APICaller.shared.getCurrentUserProfile { reult in
            switch reult{
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let model):
                print(model)
            }
        }
    }
    

}
