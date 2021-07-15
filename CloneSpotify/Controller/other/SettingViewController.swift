//
//  SettingViewController.swift
//  CloneSpotify
//
//  Created by lov niveriya on 09/07/21.
//

import UIKit

class SettingViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
  
    private let tabelView: UITableView = {
        let tabelView = UITableView(frame: .zero,style: .grouped)
        tabelView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tabelView
    }()
    
    private var Sections = [SectionsForSetting]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title="Settings"
        view.backgroundColor = .systemBackground
        view.addSubview(tabelView)
        //tabelView.backgroundColor = .white
        tabelView.dataSource = self
        tabelView.delegate = self
        configureModels()
        
    }
    
    private func configureModels(){
        Sections.append(SectionsForSetting(title: "Profile", Options: [Options(title: "view Your Profile", handler: {[weak self] in
            self?.viewProfile()
        })]))
        
        Sections.append(SectionsForSetting(title: "Account", Options: [Options(title: "Sign Out", handler: {[weak self] in
            self?.signOutTapped()
        })]))
        
    }
    
    private func viewProfile(){
        let vc = ProfileViewController()
        vc.title = "profile"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func signOutTapped(){
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabelView.frame = view.bounds
    }
    
    //MARK: - TabelView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.count
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Sections[section].Options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = Sections[indexPath.section].Options[indexPath.row]
        let cell = tabelView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tabelView.deselectRow(at: indexPath, animated: true)
        //handler for cell
        let model = Sections[indexPath.section].Options[indexPath.row]
        model.handler()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let model = Sections[section]
        return model.title
    }
}
