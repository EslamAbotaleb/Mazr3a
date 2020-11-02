//
//  CategoryProductsVC.swift
//  EcwidStore
//
//  Created by Logista on 7/27/20.
//  Copyright © 2020 Logista. All rights reserved.
//

import UIKit
import SVProgressHUD 

class CategoryProductsVC: DataLoadingVC {

    let mainTitle = UILabel()
    let subTitle = UILabel()
    var sortProductTextField = UITextField()
    var pickerViewSortProduct = ToolbarPickerView()
    var collectionView:UICollectionView!
    let searchView = SearchView()
    var items = [PItem]()
    var productCartModel =  [CartModel]()

    var category:StoreCategory?
    var productsIDs:[Int] = [Int]()
    var viewIsSelected: Bool = false

    var nameSortingProductBy = ["NAME_ASC","NAME_DESC","PRICE_ASC","PRICE_DESC"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("this is called for many products")
        setCollectionView()
        setupPickerView()
        setTitles()
        layoutUI()
        
        view.backgroundColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(DismissSelf))
        getProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           self.collectionView.reloadDataOnMainThread()
        self.mainTitle.text = self.category?.name ?? ""
        self.subTitle.text = self.category?.name ?? ""
       }
    
    func getProducts(){
        if self.productsIDs.count > 0 {
        items.removeAll()
        self.collectionView.reloadDataOnMainThread()
        showLoadingView()
        StoreClient.shared.getSubCategory(for: productsIDs) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let product):
                print(self.productsIDs)
                for item in product.items{
                    if item.enabled {
                        self.items.append(item)
                    }
                }
                self.dismissLoadingView()
                self.collectionView.reloadDataOnMainThread()
            }
        }
    }
    }
    
    func setTitles(){
        mainTitle.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        mainTitle.textColor = .black
        mainTitle.textAlignment = .left
        mainTitle.numberOfLines = 2
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        
        subTitle.font = UIFont.systemFont(ofSize: 16, weight: .light)
        subTitle.textColor = .gray
        subTitle.textAlignment = .left
        subTitle.numberOfLines = 1
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        
        sortProductTextField.placeholder = "Sort By"
        sortProductTextField.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        sortProductTextField.textColor = .black
        sortProductTextField.textAlignment = .center
        sortProductTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.getTwoCellsFlowLayout(in: self.view))
        collectionView.register(CardCell.self, forCellWithReuseIdentifier: CardCell.reuseID)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func layoutUI(){
        view.addSubViews(mainTitle,subTitle,sortProductTextField ,collectionView)
        
        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            mainTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            mainTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            mainTitle.heightAnchor.constraint(equalToConstant: 60),
            
            subTitle.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 0),
            subTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            subTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            subTitle.heightAnchor.constraint(equalToConstant: 20),
            
            sortProductTextField.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 4),
            sortProductTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            sortProductTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            sortProductTextField.heightAnchor.constraint(equalToConstant: 80),
            
            collectionView.topAnchor.constraint(equalTo: sortProductTextField.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    func setupPickerView() {
        self.sortProductTextField.inputView = self.pickerViewSortProduct
        self.sortProductTextField.inputAccessoryView = self.pickerViewSortProduct.toolbar
        self.pickerViewSortProduct.delegate = self
        self.pickerViewSortProduct.dataSource = self
        self.pickerViewSortProduct.toolbarDelegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        
        self.pickerViewSortProduct.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ gesture: UISwipeGestureRecognizer) {
        
       
        if viewIsSelected == false {
            viewIsSelected = true
            self.pickerViewSortProduct.isHidden = true
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            self.pickerViewSortProduct.heightAnchor.constraint(equalToConstant: 0.0).constant = 0.0
        } else {
            viewIsSelected = false
            self.pickerViewSortProduct.isHidden = false
            self.navigationController?.navigationBar.isHidden = false
            self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
            self.pickerViewSortProduct.heightAnchor.constraint(equalToConstant: 0.0).constant = 0.0

        }
    }
    
    @objc func DismissSelf(){
        
        dismiss(animated: true)
        
    }
    
    //MARK: check if product in cart section
    func checkIfCarted (cartItemId : Int) -> Bool {
        if let data = UserDefaults.standard.data(forKey: "ItemInCartSection"),
           
           let cartuseritem = NSKeyedUnarchiver.unarchiveObject(with: data)! as? [CartModel] {
            for item in cartuseritem {
                
                if   item.id == "\(cartItemId)" {
                    return true
                }
            }
            
        }
        return false
    }
    
    //MARK:- Add product in cart
    @objc func addProductInCart(_ sender: UIButton) {
        let productItem = self.items[sender.tag]
        if !checkIfCarted(cartItemId: productItem.id) {
            
            sender.isSelected = true
            let defaults = UserDefaults.standard
            defaults.setValue(true, forKey: "isSelectedItemInCart\(sender.tag)")
            sender.backgroundColor = UIColor.green
            sender.setTitle("Carted تم الاضافة", for: .normal)
            
            sender.titleLabel?.numberOfLines = 2
            sender.setTitleColor(.white, for: .normal)
            SVProgressHUD.showSuccess(withStatus: "تم اضافه المنتج")
                             SVProgressHUD.dismiss(withDelay: 0.7)
            if let dataItemsInCart = UserDefaults.standard.data(forKey: "ItemInCartSection"),
               let itemInCart = NSKeyedUnarchiver.unarchiveObject(with: dataItemsInCart) as? [CartModel]
               {
                productCartModel = itemInCart as [CartModel]
                productCartModel.append(CartModel(CartName: productItem.name!, Cartid: "\(productItem.id)", CartdefaultDisplayedPriceFormatted: productItem.defaultDisplayedPriceFormatted!, Cartweight: productItem.weight!, Cartenabled: productItem.enabled, CartitemDescription: productItem.itemDescription!, CartimageURL: productItem.imageURL!, CartinStock: productItem.inStock!, CartdiscountsAllowed: productItem.discountsAllowed!))
                
                let data = NSKeyedArchiver.archivedData(withRootObject: productCartModel)
                
                
                UserDefaults.standard.set(data, forKey: "ItemInCartSection")
                
                UserDefaults.standard.synchronize()
                
            } else {
                productCartModel.append(CartModel(CartName: productItem.name!, Cartid: "\(productItem.id)", CartdefaultDisplayedPriceFormatted: productItem.defaultDisplayedPriceFormatted!, Cartweight: productItem.weight!, Cartenabled: productItem.enabled, CartitemDescription: productItem.itemDescription!, CartimageURL: productItem.imageURL!, CartinStock: productItem.inStock!, CartdiscountsAllowed: productItem.discountsAllowed!))
                let data = NSKeyedArchiver.archivedData(withRootObject: productCartModel)
                
                
                UserDefaults.standard.set(data, forKey: "ItemInCartSection")
                
                UserDefaults.standard.synchronize()
            }
            searchView.cardButton.badgeString = "\(productCartModel.count)"

        } else {
            sender.isSelected = false
            let defaults = UserDefaults.standard
            defaults.setValue(false, forKey: "isSelectedItemInCart\(sender.tag)")
            sender.backgroundColor = UIColor.white
            sender.setTitle("add to Cart اضف الي السله", for: .normal)
            SVProgressHUD.showSuccess(withStatus: "تم ازاله المنتج")
                             SVProgressHUD.dismiss(withDelay: 0.7)
            sender.setTitleColor(.black, for: .normal)
            // this part to remove part
            if let dataItemsInCart = UserDefaults.standard.data(forKey: "ItemInCartSection") {
                
                productCartModel = (NSKeyedUnarchiver.unarchiveObject(with: dataItemsInCart) as? [CartModel])!
                let objectCartModel = CartModel(CartName: productItem.name!, Cartid: "\(productItem.id)", CartdefaultDisplayedPriceFormatted: productItem.defaultDisplayedPriceFormatted!, Cartweight: productItem.weight!, Cartenabled: productItem.enabled, CartitemDescription: productItem.itemDescription!, CartimageURL: productItem.imageURL!, CartinStock: productItem.inStock!, CartdiscountsAllowed: productItem.discountsAllowed!)
                
                for(key,value) in productCartModel.enumerated() {
                    if objectCartModel.id == value.id {
                        productCartModel.remove(at: Int(key))
                        let data = NSKeyedArchiver.archivedData(withRootObject: productCartModel)
 
                        UserDefaults.standard.set(data, forKey: "ItemInCartSection")
                        
                        
                        UserDefaults.standard.synchronize()
                    }
                }
            }
            searchView.cardButton.badgeString = "\(productCartModel.count - 1)"

        }
    }
}
//MARK:- collectionview
extension CategoryProductsVC: UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.items.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.reuseID, for: indexPath) as! CardCell
        cell.addToCardButton.tag = indexPath.item
        cell.set(with: self.items[indexPath.item])

        let defaults = UserDefaults.standard
        let stateCart = defaults.bool(forKey: "isSelectedCart\(indexPath.item)")
        cell.addToCardButton.isSelected = stateCart
        
        if let dataItemsInCart = UserDefaults.standard.data(forKey: "ItemInCartSection") {

            let cart: [CartModel] = NSKeyedUnarchiver.unarchiveObject(with: dataItemsInCart as Data) as! [CartModel]
            for (_, value) in cart.enumerated() {

                if let idItem = Int((value.id.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())) {
                    if items[indexPath.item].id == idItem {
                        cell.addToCardButton.setTitle("Carted تم الاضافة", for: .normal)
                        cell.addToCardButton.titleLabel?.numberOfLines = 2
                        cell.addToCardButton.titleLabel?.textAlignment = .center
                        cell.addToCardButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
                        cell.addToCardButton.setTitleColor(.white, for: .normal)
                        cell.addToCardButton.backgroundColor = .green
                        cell.addToCardButton.layer.borderWidth = 1
                        cell.addToCardButton.layer.borderColor = UIColor.lightGray.cgColor
                        break
                    } else {
                        cell.addToCardButton.setTitle("add to Cart اضف الي السله", for: .normal)
                        cell.addToCardButton.titleLabel?.numberOfLines = 2
                        cell.addToCardButton.titleLabel?.textAlignment = .center
                        cell.addToCardButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
                        cell.addToCardButton.setTitleColor(.black, for: .normal)
                        cell.addToCardButton.backgroundColor = .white
                        cell.addToCardButton.layer.borderWidth = 1
                        cell.addToCardButton.layer.borderColor = UIColor.lightGray.cgColor
                            
                    }
                }
            }
        }

        cell.addToCardButton.addTarget(self, action: #selector(CategoryProductsVC.addProductInCart), for: .touchUpInside)
        UserDefaults.standard.synchronize()

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let vc = SingleProductVC()
        vc.item = self.items[indexPath.item]
        self.present(vc,animated: true)
        

    }
    
}

//MARK: pickerView
extension CategoryProductsVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.nameSortingProductBy.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == self.pickerViewSortProduct {
            return self.nameSortingProductBy[row]
        }
        return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerViewSortProduct {
            self.sortProductTextField.text = self.nameSortingProductBy[row]
        }
    }
}

// MARK:- select row from pickerview
extension CategoryProductsVC: ToolbarPickerViewDelegate {
    func didTapDone() {
        let row = self.pickerViewSortProduct.selectedRow(inComponent: 0)
        self.pickerViewSortProduct.selectRow(row, inComponent: 0, animated: false)
        self.sortProductTextField.text = self.nameSortingProductBy[row]
        self.sortProductTextField.resignFirstResponder()
        if self.productsIDs.count > 0 {
        items.removeAll()
        self.collectionView.reloadDataOnMainThread()
        showLoadingView()
            StoreClient.shared.getProductBySorting(sortBy: self.nameSortingProductBy[row]) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let product):
                print(self.productsIDs)
                for item in product.items{
                    if item.enabled {
                        self.items.append(item)
                    }
                }
                self.dismissLoadingView()
                self.collectionView.reloadDataOnMainThread()
                self.pickerViewSortProduct.reloadDataOnMainThread()
            }
        }
    }

    }
    
    func didTapCancel() {
        self.sortProductTextField.resignFirstResponder()

    }
    
    
}
