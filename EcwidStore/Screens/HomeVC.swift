//
//  HomeVC.swift
//  EcwidStore
//
//  Created by Logista on 7/26/20.
//  Copyright © 2020 Logista. All rights reserved.
//

import UIKit

class HomeVC: DataLoadingVC {
    
    
    let homeTableView = UITableView()
    let searchView = SearchView()
    var currentCart =  [CartModel]()
    var items = [Item]()
    var page = 0
    var offset =  10
    var hasMoreCategories = true
    var isLoadingCategories = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.cardButton.badgeTextColor = UIColor.white
        searchView.cardButton.badgeEdgeInsets = UIEdgeInsets(top: 4, left: 1, bottom: 5, right: 13)
        
        setupHomeTabelView()
        layoutUI()
        getCategories(offset:page*offset)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.homeTableView.reloadDataOnMainThread()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkIfThereProductInCart()
           
    }
    
    //checking if the user had something in cart
    func checkIfThereProductInCart() {
    if let getallitemsdata = UserDefaults.standard.data(forKey: "ItemInCartSection") {
        currentCart = (NSKeyedUnarchiver.unarchiveObject(with: getallitemsdata as Data) as? [CartModel])!
       
        searchView.cardButton.badgeString = "\(currentCart.count)"
                  
              }else {
                searchView.cardButton.badgeString = ""
                  
              }
    }
    func setupHomeTabelView(){
        homeTableView.separatorStyle = .none
        homeTableView.allowsSelection = false
        homeTableView.delaysContentTouches = false
        homeTableView.showsVerticalScrollIndicator = false
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layoutUI(){
        view.addSubViews(searchView,homeTableView)
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchView.heightAnchor.constraint(equalToConstant: 50),
            
            homeTableView.topAnchor.constraint(equalTo: searchView.bottomAnchor),
            homeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func getCategories(offset:Int){
        showLoadingView()
        StoreClient.shared.getCategories(offset: offset) { (result) in
            self.dismissLoadingView()
            switch result {
            case .success(let cats):
                self.updateUI(with: cats.items)
            case .failure(let error):
                print(error)
            }
            self.isLoadingCategories = false
        }
    }
    
    func updateUI(with items:[Item]){
        if items.count < 10 {
            self.hasMoreCategories = false
        }
        self.items.append(contentsOf: items)
        self.homeTableView.reloadDataOnMainThread()
    }
    
    
    
    
}
extension HomeVC: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            homeTableView.register(LogoCell.self, forCellReuseIdentifier: LogoCell.reuseID)
            let cell = tableView.dequeueReusableCell(withIdentifier: LogoCell.reuseID, for: indexPath)
            return cell
        }else if indexPath.row == 1 {
            homeTableView.register(CategoriesCell.self, forCellReuseIdentifier: CategoriesCell.reuseID)
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesCell.reuseID, for: indexPath) as! CategoriesCell
            cell.items = self.items
            return cell
        }else {
            homeTableView.register(CategoryDetailsCell.self, forCellReuseIdentifier: CategoryDetailsCell.reuseID)
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryDetailsCell.reuseID, for: indexPath) as! CategoryDetailsCell
//            cell.set(with: self.items[indexPath.row - 2])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let CategoryDetailsCell = cell as? CategoryDetailsCell {
            CategoryDetailsCell.set(with: self.items[indexPath.row - 2])
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 210
        }else if indexPath.row == 1 {
            return 130
        }else {
            return 235
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height
        let offsetY = scrollView.contentOffset.y
        if offsetY > contentHeight - height {
            guard hasMoreCategories , !isLoadingCategories else {return}
            page += 1
            getCategories(offset: offset*page)
        }
    }
    
}
