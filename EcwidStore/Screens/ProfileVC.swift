//
//  SignupVC.swift
//  EcwidStore
//
//  Created by Logista on 7/26/20.
//  Copyright © 2020 Logista. All rights reserved.
//

import UIKit
import FirebaseAuth
class ProfileVC: UIViewController {

    let firstView = UIView()
    let secondView = UIView()
    var secondSectionFirstStackView = UIStackView()
    var secondSectionSecondStackView = UIStackView()
    
    var firstSectionFirstStackView = UIStackView()
    var firstSectionSecondStackView = UIStackView()
    let logoImageView = UIImageView(image: UIImage(named: "Mazra3a"))
    var nameUser = UILabel()
    let locationTitle = UILabel()
    let discountLabel = UILabel()
    let supportLabel = UILabel()
    let shareTitle = UILabel()
    let aboutUs = UILabel()
    let logoutLabel = UILabel()
    let paymentLabel = UILabel()
    let informationLabel = UILabel()
    let ordersLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.9725490196, blue: 0.9960784314, alpha: 1)
        configureViews()
        setLabels()
        setLogo()
        setStackView()
        layoutUI()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.logOutUser))
        logoutLabel.isUserInteractionEnabled = true
        logoutLabel.addGestureRecognizer(tap)
        
    }
  
    
    func setLogo()  {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.clipsToBounds = true
        
    }
    func setLabels() {
        
        nameUser.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        nameUser.textColor = .black
        nameUser.textAlignment = .center
        nameUser.numberOfLines = 2
        nameUser.translatesAutoresizingMaskIntoConstraints = false
        nameUser.text = "User Name"
        
        locationTitle.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        locationTitle.textColor = .black
        locationTitle.textAlignment = .center
        locationTitle.numberOfLines = 2
        locationTitle.translatesAutoresizingMaskIntoConstraints = false
        locationTitle.text = "العنوان"
        
        discountLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        discountLabel.textColor = .black
        discountLabel.textAlignment = .center
        discountLabel.numberOfLines = 2
        discountLabel.translatesAutoresizingMaskIntoConstraints = false
        discountLabel.text = "الخصومات"

        
        supportLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        supportLabel.textColor = .black
        supportLabel.textAlignment = .center
        supportLabel.numberOfLines = 2
        supportLabel.translatesAutoresizingMaskIntoConstraints = false
        supportLabel.text = "الدعم الفني"
        
        shareTitle.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        shareTitle.textColor = .black
        shareTitle.textAlignment = .center
        shareTitle.numberOfLines = 2
        shareTitle.translatesAutoresizingMaskIntoConstraints = false
        shareTitle.text = "المشاركة"
        
        aboutUs.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        aboutUs.textColor = .black
        aboutUs.textAlignment = .center
        aboutUs.numberOfLines = 2
        aboutUs.translatesAutoresizingMaskIntoConstraints = false
        aboutUs.text = "من نحن"

        
        logoutLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        logoutLabel.textColor = .black
        logoutLabel.textAlignment = .center
        logoutLabel.numberOfLines = 2
        logoutLabel.translatesAutoresizingMaskIntoConstraints = false
        logoutLabel.text = "خروج"
        
        
        paymentLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        paymentLabel.textColor = .black
        paymentLabel.textAlignment = .center
        paymentLabel.numberOfLines = 2
        paymentLabel.translatesAutoresizingMaskIntoConstraints = false
        paymentLabel.text = "دفع"
        
        informationLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        informationLabel.textColor = .black
        informationLabel.textAlignment = .center
        informationLabel.numberOfLines = 2
        informationLabel.translatesAutoresizingMaskIntoConstraints = false
        informationLabel.text = "معلوماتك"

        
        ordersLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        ordersLabel.textColor = .black
        ordersLabel.textAlignment = .center
        ordersLabel.numberOfLines = 2
        ordersLabel.translatesAutoresizingMaskIntoConstraints = false
        ordersLabel.text = "الطلبات"
        
    }
    
    func configureViews() {
        firstView.translatesAutoresizingMaskIntoConstraints = false
        secondView.translatesAutoresizingMaskIntoConstraints = false
        firstView.backgroundColor = UIColor.white
        secondView.backgroundColor = UIColor.white
    }
    
    func setStackView() {
        
        firstSectionSecondStackView.axis  = NSLayoutConstraint.Axis.horizontal
        firstSectionSecondStackView.distribution  = UIStackView.Distribution.fillEqually
        firstSectionSecondStackView.alignment = UIStackView.Alignment.center
        firstSectionSecondStackView.spacing   = 5.0
        firstSectionSecondStackView.addArrangedSubview(paymentLabel)
        firstSectionSecondStackView.addArrangedSubview(informationLabel)
        firstSectionSecondStackView.addArrangedSubview(ordersLabel)
        firstSectionSecondStackView.translatesAutoresizingMaskIntoConstraints = false
        
        firstSectionFirstStackView.axis  = NSLayoutConstraint.Axis.horizontal
        firstSectionFirstStackView.distribution  = UIStackView.Distribution.fillEqually
        firstSectionFirstStackView.alignment = UIStackView.Alignment.center
        firstSectionFirstStackView.spacing   = 5.0
        firstSectionFirstStackView.addArrangedSubview(logoImageView)
        firstSectionFirstStackView.addArrangedSubview(nameUser)
        firstSectionFirstStackView.translatesAutoresizingMaskIntoConstraints = false
        
        secondSectionFirstStackView.axis  = NSLayoutConstraint.Axis.horizontal
        secondSectionFirstStackView.distribution  = UIStackView.Distribution.fillEqually
        secondSectionFirstStackView.alignment = UIStackView.Alignment.center
        secondSectionFirstStackView.spacing   = 5.0
        secondSectionFirstStackView.addArrangedSubview(locationTitle)
        secondSectionFirstStackView.addArrangedSubview(discountLabel)
        secondSectionFirstStackView.addArrangedSubview(supportLabel)
        secondSectionFirstStackView.translatesAutoresizingMaskIntoConstraints = false
        
        //secondStackView
        secondSectionSecondStackView.axis  = NSLayoutConstraint.Axis.horizontal
        secondSectionSecondStackView.distribution  = UIStackView.Distribution.fillEqually
        secondSectionSecondStackView.alignment = UIStackView.Alignment.center
        secondSectionSecondStackView.spacing   = 5.0
        secondSectionSecondStackView.addArrangedSubview(shareTitle)
        secondSectionSecondStackView.addArrangedSubview(aboutUs)
        secondSectionSecondStackView.addArrangedSubview(logoutLabel)
        secondSectionSecondStackView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    func layoutUI() {
        view.addSubViews(firstView, secondView)
        firstView.addSubview(firstSectionSecondStackView)
        firstView.addSubview(firstSectionFirstStackView)
        secondView.addSubview(secondSectionFirstStackView)
        secondView.addSubview(secondSectionSecondStackView)
        
        NSLayoutConstraint.activate([
            firstView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25.0),
            firstView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            firstView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            firstView.heightAnchor.constraint(equalToConstant: 250.0),
            
            
            firstSectionFirstStackView.leadingAnchor.constraint(equalTo: firstView.leadingAnchor),
            firstSectionFirstStackView.trailingAnchor.constraint(equalTo: firstView.trailingAnchor),
            firstSectionFirstStackView.topAnchor.constraint(equalTo: firstView.topAnchor),
            firstSectionFirstStackView.heightAnchor.constraint(equalToConstant: 120.0),
            
            
            
            firstSectionSecondStackView.leadingAnchor.constraint(equalTo: firstView.leadingAnchor),
            firstSectionSecondStackView.trailingAnchor.constraint(equalTo: firstView.trailingAnchor),
            firstSectionSecondStackView.topAnchor.constraint(equalTo: firstSectionFirstStackView.bottomAnchor, constant:  25.0),
            firstSectionSecondStackView.heightAnchor.constraint(equalToConstant: 85.0),
            
            
            secondSectionFirstStackView.leadingAnchor.constraint(equalTo: secondView.leadingAnchor),
            secondSectionFirstStackView.trailingAnchor.constraint(equalTo: secondView.trailingAnchor),
            secondSectionFirstStackView.topAnchor.constraint(equalTo: secondView.topAnchor),
            secondSectionFirstStackView.heightAnchor.constraint(equalToConstant: 85.0),
            
            secondView.topAnchor.constraint(equalTo: firstView.bottomAnchor, constant: 20.0),
            secondView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            secondView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            secondView.heightAnchor.constraint(equalToConstant: 200.0),
            
            secondSectionSecondStackView.leadingAnchor.constraint(equalTo: secondView.leadingAnchor),
            secondSectionSecondStackView.trailingAnchor.constraint(equalTo: secondView.trailingAnchor),
            secondSectionSecondStackView.topAnchor.constraint(equalTo: secondSectionFirstStackView.bottomAnchor, constant: 20.0),
            secondSectionSecondStackView.heightAnchor.constraint(equalToConstant: 85.0),
            
        ])
    }
    //Logout user
    @objc func logOutUser() {
        guard (UserDefaults.standard.value(forKey: "verifyID") != nil) else {
            print("user not found")
            return
        }
        UserDefaults.standard.removeObject(forKey: "verifyID")
        UserDefaults.standard.synchronize()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let vc = SignupVC()
             self.present(vc,animated: true)
        }
 
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
