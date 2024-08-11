//
//  MenuViewController.swift
//  Shopping
//
//  Created by Aleyna Işıkdağlılar on 4.08.2024.
//

import UIKit

class MenuViewController: UIViewController {
    
    private let tableView = UITableView()
    //    private let menuItems = ["Home", "Profile", "Settings", "Logout"]
    private let sideCategoryMenuViewModel = SideCategoryMenuViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        setupBindings()
        sideCategoryMenuViewModel.fetchCategories()
    }
    private func setupTableView() {
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.separatorStyle = .none
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MenuItemCell")
        view.addSubview(tableView)
    }
    
    private func setupBindings() {
        sideCategoryMenuViewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideCategoryMenuViewModel.numberOfCategories()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemCell", for: indexPath)
        let category = sideCategoryMenuViewModel.category(at: indexPath.row)
        cell.textLabel?.text = category.uppercased()
        return cell
    }
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedItem = menuItems[indexPath.row]
//        print("Selected item: \(selectedItem)")
//        // Add additional logic here for each menu item selection
//    }
}
