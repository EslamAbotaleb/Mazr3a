//
//  SingleProductVC.swift
//  EcwidStore
//
//  Created by Logista on 7/27/20.
//  Copyright © 2020 Logista. All rights reserved.
//

import UIKit
import SVProgressHUD
class SingleProductVC: UIViewController {
    
    let scrollView  = UIScrollView()
    let contentView = UIView()
    var item:PItem!
    var currentCart: [CartModel]!
    
    let searchView = SearchViewWithBackButton()
    let productImageView = UIImageView(image: UIImage(named: "Food"))
    let codeLabel = UILabel()
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let priceLabel = UILabel()
    let quantityStackView = UIStackView()
    let promoLabel = UILabel()
    let deliveryLabel = UILabel()
    let cardButton = SignButton(bgColor: .white, title: "CART")

    let buyButton = SignButton(bgColor: #colorLiteral(red: 0.2274509804, green: 0.5058823529, blue: 0.1137254902, alpha: 1), title: "BUY NOW")
    
    let QTLabel = UILabel()
    let minusButton = UIButton()
    let counter = UILabel()
    let plusButton = UIButton()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
            //checking if the user had something in cart
        if let getallitemsdata = UserDefaults.standard.data(forKey: "ItemInCartSection") {
            currentCart = (NSKeyedUnarchiver.unarchiveObject(with: getallitemsdata as Data) as? [CartModel])!
           
            searchView.cardButton.badgeString = "\(currentCart.count)"
                      
                  }else {
                      
                    searchView.cardButton.badgeString = ""
                      
                  }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("this is callled for single product")
        searchView.cardButton.badgeTextColor = UIColor.white
        searchView.cardButton.badgeEdgeInsets = UIEdgeInsets(top: 4, left: 1, bottom: 5, right: 13)
        currentCart = [CartModel]()

        configureScrollView()
        setupLabels()
        configureUI()
        configureStackView()
        layoutUI()
        configureActionButton()
        if let getallitemsdata = UserDefaults.standard.data(forKey: "ItemInCartSection") {
            
            
            let cart : [CartModel] = NSKeyedUnarchiver.unarchiveObject(with: getallitemsdata as Data) as! [CartModel]
         
            for (_,value) in cart.enumerated() {
                
                    
                if  "\(item.id)" == value.id  {
                        

               
                        cardButton.setTitleColor(.black, for: .normal)
                        cardButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
                        cardButton.layer.borderWidth = 2
                        cardButton.layer.borderColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
                        cardButton.setTitle("Carted", for: .normal)
                    }else {
                        
                        cardButton.setTitleColor(.black, for: .normal)
                        cardButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
                        cardButton.layer.borderWidth = 2
                        cardButton.layer.borderColor = #colorLiteral(red: 0.2274509804, green: 0.5058823529, blue: 0.1137254902, alpha: 1)
                        cardButton.setTitle("Cart", for: .normal)
                    }
                    
                    
            }
        }
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(CartimageTapped(tapGestureRecognizer:)))
        cardButton.isUserInteractionEnabled = true
        cardButton.addGestureRecognizer(tapGestureRecognizer2)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.productImageView.downloadImage(fromURL: item.imageURL ?? "")
        self.codeLabel.text = "Code:\(item.id)"
        self.nameLabel.text = item.name ?? ""
        self.descriptionLabel.text = Helpers.handleDescriptionString(description: item.itemDescription ?? "")
        self.priceLabel.text = item.defaultDisplayedPriceFormatted
        if !(item.discountsAllowed ?? false)  {
            self.promoLabel.text = "No Discount 😟"
        }
    }
    
    func configureScrollView(){
        view.addSubViews(searchView,scrollView)
        scrollView.addSubview(contentView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false 
        contentView.pinToTheEdges(of: scrollView)
        contentView.backgroundColor = .white
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.topAnchor, constant: 35),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchView.heightAnchor.constraint(equalToConstant: 50),
            
            scrollView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 740)
        ])
    }
    
    func configureStackView(){
        QTLabel.translatesAutoresizingMaskIntoConstraints = false
        QTLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        QTLabel.textColor = .black
        QTLabel.textAlignment = .left
        QTLabel.text = "Qty:"
        
        counter.translatesAutoresizingMaskIntoConstraints = false
        counter.font = UIFont.systemFont(ofSize: 16, weight: .light)
        counter.textColor = .black
        counter.textAlignment = .center
        counter.layer.borderColor = UIColor.black.cgColor
        counter.layer.borderWidth = 1
        counter.layer.cornerRadius = 4
        counter.text = "1"
        NSLayoutConstraint.activate([
            counter.widthAnchor.constraint(equalTo: counter.heightAnchor)
        ])
        
        minusButton.setImage(UIImage(named: "SF_minus_circle"), for: .normal)
        plusButton.setImage(UIImage(named: "SF_plus_circle"), for: .normal)
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        
        quantityStackView.translatesAutoresizingMaskIntoConstraints = false
        quantityStackView.axis = .horizontal
        quantityStackView.distribution = .equalSpacing
        quantityStackView.backgroundColor = .red
        quantityStackView.addArrangedSubview(QTLabel)
        quantityStackView.addArrangedSubview(plusButton)
        quantityStackView.addArrangedSubview(counter)
        quantityStackView.addArrangedSubview(minusButton)

    }
    
    func setupLabels(){
        codeLabel.translatesAutoresizingMaskIntoConstraints = false
        codeLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        codeLabel.textColor = .black
        codeLabel.textAlignment = .left
        codeLabel.text = "Code:3075000"
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        nameLabel.textColor = .black
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 2
        nameLabel.text = "Papaya"
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = 2
        descriptionLabel.textAlignment = .left
        descriptionLabel.text = "Papaya PapayaPapayaPapaya Papaya Papaya Papaya Papaya Papaya Papaya Papaya Papaya"
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        priceLabel.textColor = .black
        priceLabel.textAlignment = .left
        priceLabel.text = "EGP 90.00"
        
        
        promoLabel.translatesAutoresizingMaskIntoConstraints = false
        promoLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        promoLabel.textColor = .gray
        promoLabel.textAlignment = .left
        promoLabel.text = "20% off today"
        
        deliveryLabel.translatesAutoresizingMaskIntoConstraints = false
        deliveryLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        deliveryLabel.textColor = .gray
        deliveryLabel.textAlignment = .left
        deliveryLabel.text = "🎯Express Delivery"
        
        cardButton.setTitleColor(.black, for: .normal)
        cardButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        cardButton.layer.borderWidth = 2
        cardButton.layer.borderColor = #colorLiteral(red: 0.2274509804, green: 0.5058823529, blue: 0.1137254902, alpha: 1)
    }
    
    func configureUI(){
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        quantityStackView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.contentMode = .scaleAspectFill
        productImageView.layer.cornerRadius = 8
        productImageView.clipsToBounds = true
        quantityStackView.backgroundColor = .green
        searchView.backButton.addTarget(self, action: #selector(HandleBackButtonTab), for: .touchUpInside)
    }
    
    
    @objc func HandleBackButtonTab(){
        self.dismiss(animated: true)
    }
    
    func layoutUI(){
        contentView.addSubViews(productImageView,codeLabel,nameLabel,descriptionLabel,priceLabel,quantityStackView,promoLabel,deliveryLabel,cardButton,buyButton)
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor , constant: 20),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            productImageView.heightAnchor.constraint(equalTo: productImageView.widthAnchor),
            
            codeLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 8),
            codeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor , constant: 20),
            codeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            codeLabel.heightAnchor.constraint(equalToConstant: 25),
            
            nameLabel.topAnchor.constraint(equalTo: codeLabel.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor , constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            nameLabel.heightAnchor.constraint(equalToConstant: 100),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor , constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 50),
            
            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor , constant: 20),
            priceLabel.trailingAnchor.constraint(greaterThanOrEqualTo: quantityStackView.leadingAnchor, constant: 8),
            priceLabel.heightAnchor.constraint(equalToConstant: 35),
            
            quantityStackView.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
            quantityStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            quantityStackView.heightAnchor.constraint(equalToConstant: 30),
            quantityStackView.widthAnchor.constraint(equalToConstant: 130),
            
            promoLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            promoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor , constant: 20),
            promoLabel.heightAnchor.constraint(equalToConstant: 35),
            
            deliveryLabel.centerYAnchor.constraint(equalTo: promoLabel.centerYAnchor),
            deliveryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            deliveryLabel.heightAnchor.constraint(equalToConstant: 35),
            
            cardButton.topAnchor.constraint(equalTo: promoLabel.bottomAnchor, constant: 10),
            cardButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor , constant: 20),
            cardButton.widthAnchor.constraint(equalToConstant: 100),
            cardButton.heightAnchor.constraint(equalToConstant: 40),

            
            buyButton.centerYAnchor.constraint(equalTo: cardButton.centerYAnchor),
            buyButton.leadingAnchor.constraint(equalTo: cardButton.trailingAnchor , constant: 12),
            buyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor , constant: -20),
            buyButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        
    }
    
    func configureActionButton() {

        cardButton.addTarget(self, action: #selector(cartItem), for: .touchUpInside)
    }
    
    @objc func CartimageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
        // Your cartItem
        cartItem(self.cardButton)
    }
    
    
    @IBAction func cartItem(_ sender: UIButton) {
        
  
        if !checkIfCarted(cartItemId: item.id)  {
            sender.isSelected = true
            let defults = UserDefaults.standard
            defults.set(true, forKey: "isSelectedCartdetailotherproductitem\(sender.tag)")
            cardButton.setTitleColor(.black, for: .normal)
            cardButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
            cardButton.layer.borderWidth = 2
            cardButton.layer.borderColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
            cardButton.setTitle("Carted", for: .normal)
            SVProgressHUD.showSuccess(withStatus: "تم اضافه المنتج")
                             SVProgressHUD.dismiss(withDelay: 0.7)
            if let data = UserDefaults.standard.data(forKey: "ItemInCartSection"),

               let cartuseritem = NSKeyedUnarchiver.unarchiveObject(with: data) as? [CartModel] {
                
                currentCart = cartuseritem as [CartModel]
                
                currentCart.append(CartModel(CartName: item.name!, Cartid: "\(item.id)", CartdefaultDisplayedPriceFormatted: item.defaultDisplayedPriceFormatted!, Cartweight: item.weight!, Cartenabled: item.enabled, CartitemDescription: item.itemDescription!, CartimageURL: item.imageURL!, CartinStock: item.inStock!, CartdiscountsAllowed: item.discountsAllowed!))

                let data = NSKeyedArchiver.archivedData(withRootObject: currentCart!)
                
                UserDefaults.standard.set(data, forKey: "ItemInCartSection")
                
                UserDefaults.standard.synchronize()

            } else {
                currentCart.append(CartModel(CartName: item.name!, Cartid: "\(item.id)", CartdefaultDisplayedPriceFormatted: item.defaultDisplayedPriceFormatted!, Cartweight: item.weight!, Cartenabled: item.enabled, CartitemDescription: item.itemDescription!, CartimageURL: item.imageURL!, CartinStock: item.inStock!, CartdiscountsAllowed: item.discountsAllowed!))
                let data = NSKeyedArchiver.archivedData(withRootObject: currentCart!)
                
                
                UserDefaults.standard.set(data, forKey: "ItemInCartSection")
                
                UserDefaults.standard.synchronize()
            }
            searchView.cardButton.badgeString = "\(currentCart.count)"

        } else {
            sender.isSelected = false

            let defults = UserDefaults.standard

            defults.set(false, forKey: "isSelectedCartdetailotherproductitem\(sender.tag)")
            
            if let data = UserDefaults.standard.data(forKey: "ItemInCartSection") {
                currentCart = NSKeyedUnarchiver.unarchiveObject(with: data) as? [CartModel]
                for(key, value) in (currentCart?.enumerated())! {
                    
                    if value.id ==  "\(item.id)" {
                        currentCart?.remove(at: Int(key))
                        cardButton.setTitleColor(.black, for: .normal)
                        cardButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
                        cardButton.layer.borderWidth = 2
                        cardButton.layer.borderColor = #colorLiteral(red: 0.2274509804, green: 0.5058823529, blue: 0.1137254902, alpha: 1)
                        SVProgressHUD.showSuccess(withStatus: "تم ازاله المنتج")
                                         SVProgressHUD.dismiss(withDelay: 0.7)
                        cardButton.setTitle("Cart", for: .normal)
                        let data = NSKeyedArchiver.archivedData(withRootObject: currentCart!)
                        UserDefaults.standard.set(data, forKey: "ItemInCartSection")
                        UserDefaults.standard.synchronize()
                    } 
                }
                
                searchView.cardButton.badgeString = ""

            }
            

        }
    }
    
//    //MARK:- check if carted or not

    
        func checkIfCarted (cartItemId : Int) -> Bool {
            print("\(cartItemId)")
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
}
