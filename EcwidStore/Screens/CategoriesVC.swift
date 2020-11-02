//
//  CategoriesVC.swift
//  EcwidStore
//
//  Created by Logista on 7/26/20.
//  Copyright © 2020 Logista. All rights reserved.
//

import UIKit
import SVProgressHUD

class CategoriesVC: DataLoadingVC {
    
    var mainTitle = UILabel()
    var collectionView: UICollectionView!
    var stackView: UIStackView = UIStackView()
    var masarifTotalPeiceStackView: UIStackView!
    var totalPriceStackView: UIStackView!
    let staticLabelSubTotal = UILabel(frame: CGRect(x: 0, y: 0, width: 20.0, height: 20.0))
    let valueSubTotalLabel = UILabel()
    var completePayButton = UIButton()
    var viewPrice = UIView()
    var subViewPrice = UIView()
    var currentCart =  [CartModel]()
    var totalPrice: Double = 0.00
    override func viewDidLoad() {
        super.viewDidLoad()
        print("thisiscallledforcheckout\(self.currentCart.count)")
        view.backgroundColor = .white
        if (self.currentCart.count == 0) {
            setupView()
        } else {
            setupCollectionView()
            setStaticTitle()
            setupButton()
            setupViewPrice()
            setupStackView()
            
            layoutUI()
        }
       
        
        
        // getting all data for cart
        

    }
    func setupView() {
        self.view.backgroundColor = UIColor.white
    }
    var heightCollectionView: CGFloat = 0.0
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (self.currentCart.count == 0) {
            
        } else {
            self.collectionView.reloadDataOnMainThread()
            self.mainTitle.text = "سله المشتريات"
            guard  let getallitemsdata = UserDefaults.standard.data(forKey: "ItemInCartSection")
            
            else {return}
            
            currentCart  = (NSKeyedUnarchiver.unarchiveObject(with: getallitemsdata as Data) as? [CartModel])!
            heightCollectionView = CGFloat(100.0 * CGFloat(currentCart.count))
            print(heightCollectionView)
        }
        
        
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: UIHelper.getCategoryCartFlowLayout(in: self.view))
        collectionView.register(CardCartCell.self, forCellWithReuseIdentifier: CardCartCell.reuseID)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    func setupButton() {
        completePayButton.setTitle("استمر في عمليه الشراء", for: .normal)
        completePayButton.titleLabel?.numberOfLines = 2
        completePayButton.titleLabel?.textAlignment = .center
        completePayButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        completePayButton.setTitleColor(.black, for: .normal)
        completePayButton.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.5058823529, blue: 0.1137254902, alpha: 1)
        completePayButton.layer.borderWidth = 0
        completePayButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupStackView() {
        
        
        
        stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.fillEqually
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 5.0
        stackView.addArrangedSubview(staticLabelSubTotal)
        stackView.addArrangedSubview(valueSubTotalLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    func setupViewPrice() {
        viewPrice.translatesAutoresizingMaskIntoConstraints = false
        subViewPrice.translatesAutoresizingMaskIntoConstraints = false 
    }
    func setStaticTitle() {
        mainTitle.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        mainTitle.textColor = .black
        mainTitle.textAlignment = .left
        mainTitle.numberOfLines = 2
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        
        staticLabelSubTotal.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        staticLabelSubTotal.textColor = .black
        staticLabelSubTotal.textAlignment = .left
        staticLabelSubTotal.numberOfLines = 2
        staticLabelSubTotal.translatesAutoresizingMaskIntoConstraints = false
        staticLabelSubTotal.text = "Total"
        
    }
    
    func totalPriceLabel(getTotalPrice: String) {
        
        valueSubTotalLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        valueSubTotalLabel.textColor = .black
        valueSubTotalLabel.textAlignment = .right
        valueSubTotalLabel.numberOfLines = 2
        valueSubTotalLabel.translatesAutoresizingMaskIntoConstraints = false
        valueSubTotalLabel.text = getTotalPrice
        
    }
    func layoutUI() {
        view.addSubViews(mainTitle, collectionView, viewPrice)
        viewPrice.addSubViews(subViewPrice, completePayButton)
        subViewPrice.addSubview(stackView)
        guard  let getallitemsdata = UserDefaults.standard.data(forKey: "ItemInCartSection")
        
        else {return}
        
        currentCart  = (NSKeyedUnarchiver.unarchiveObject(with: getallitemsdata as Data) as? [CartModel])!
        heightCollectionView = CGFloat(100.0 * CGFloat(currentCart.count))
        
        NSLayoutConstraint.activate([
            //Title
            mainTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            mainTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            mainTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            mainTitle.heightAnchor.constraint(equalToConstant: 60),
            
            //collectionView
            collectionView.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 8),
            collectionView.heightAnchor.constraint(equalToConstant: heightCollectionView),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
           
            viewPrice.topAnchor.constraint(equalTo: collectionView.bottomAnchor,constant: 10.0),
            viewPrice.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            viewPrice.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            viewPrice.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            viewPrice.heightAnchor.constraint(equalToConstant: 130.0),
            //            stackView.topAnchor.constraint(lessThanOrEqualTo: collectionView.bottomAnchor, constant: 0.0),
            //
            
            
            subViewPrice.topAnchor.constraint(equalTo: self.viewPrice.topAnchor, constant: 2.0),
            subViewPrice.leftAnchor.constraint(equalTo: self.viewPrice.leftAnchor, constant: 0),
            subViewPrice.rightAnchor.constraint(equalTo: self.viewPrice.rightAnchor, constant: 0),
            subViewPrice.heightAnchor.constraint(equalToConstant: 60.0),
            
            
            
            stackView.topAnchor.constraint(equalTo: subViewPrice.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: subViewPrice.leadingAnchor, constant:  12.0),
            stackView.trailingAnchor.constraint(equalTo: subViewPrice.trailingAnchor, constant: -12.0),
            stackView.bottomAnchor.constraint(equalTo: completePayButton.topAnchor),
            
            
            //
            completePayButton.leadingAnchor.constraint(equalTo: viewPrice.safeAreaLayoutGuide.leadingAnchor, constant: 12.0),
            completePayButton.trailingAnchor.constraint(equalTo: viewPrice.safeAreaLayoutGuide.trailingAnchor, constant: -12.0),
            completePayButton.bottomAnchor.constraint(equalTo: viewPrice.bottomAnchor, constant:  10.0),
            completePayButton.heightAnchor.constraint(equalToConstant: 60.0),
            
            
        ])
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension CategoriesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.currentCart.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCartCell.reuseID, for: indexPath) as! CardCartCell
        cell.set(with: self.currentCart[indexPath.row])
        
        
        self.totalPrice += Double(self.currentCart[indexPath.row].defaultDisplayedPriceFormatted.replacingOccurrences(of: "EGP ", with: ""))!
        totalPriceLabel(getTotalPrice: "\(totalPrice) EGP")
        return cell
    }
    
    
}
