//
//  ProfileViewController.swift
//  CloneSpotify
//
//  Created by lov niveriya on 09/07/21.
//

import UIKit

class ProfileViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    private let tabelView:UITableView={
        let tabelview = UITableView()
        tabelview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tabelview
    }()
    
    private var models = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        fetchProfile()
        view.addSubview(tabelView)
        tabelView.delegate = self
        tabelView.dataSource = self
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabelView.frame = view.bounds
    }
    
    private func fetchProfile(){
        APICaller.shared.getCurrentUserProfile {[weak self] reult in
            DispatchQueue.main.async {
                switch reult{
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.failedTogetprofile()
                case .success(let model):
                    self?.updateUI(with: model)
                    print(model)
                }
            }
        }
        
    }
    
    func updateUI(with model:UserProfile){
        tabelView.isHidden = false
        //config tabel model
        models.append("Full Name \(model.display_name)")
        models.append("Email Address\(model.email)")
        models.append("User ID\(model.id)")
        models.append("Plan\(model.product)")
        
        tabelView.reloadData()
    }
    func failedTogetprofile(){
        
        let label = UILabel(frame: .zero)
        label.text = "Failed to load profile"
        label.sizeToFit()
        label.textColor = .secondaryLabel
        view.addSubview(label)
        label.center = view.center
    }
    
    //MARK: - TabelView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    
    
    
}
