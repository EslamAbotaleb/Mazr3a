//
//  AuthPhoneNumberRegistration.swift
//  EcwidStore
//
//  Created by Islam Abotaleb on 11/1/20.
//  Copyright © 2020 zeyad. All rights reserved.
//

import UIKit
import FirebaseAuth
import SVProgressHUD
import CoreTelephony

class AuthPhoneNumberRegistration: UIViewController, UITextFieldDelegate {
    
    /*
     first header is logo
     second section is view as rounded contain of:-
     1. static title
     2. insert phonenumber
     3. button for vertification this user
     */
    
    var headerView = UIView()
    let logoImageView = UIImageView(image: UIImage(named: "Mazra3a"))
    var headerPhoneNumberSectionView: UIView!
    var staticTitleLabel = UILabel()
    var phoneNumberTextField = UITextField()
    var butonVerify = UIButton(frame: CGRect(x: 0, y: 0, width: 75, height: 75))
    
    
    
    func setLogo()  {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.clipsToBounds = true
        
    }
    
    func setHeadersView() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        headerPhoneNumberSectionView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        headerPhoneNumberSectionView.translatesAutoresizingMaskIntoConstraints = false
        headerPhoneNumberSectionView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    func setLabels() {
        staticTitleLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        staticTitleLabel.textColor = .black
        staticTitleLabel.textAlignment = .right
        staticTitleLabel.numberOfLines = 2
        staticTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        staticTitleLabel.text = "مرحبا نحن سعداء برؤيتك"
    }
    
    func setTextFields() {
        phoneNumberTextField.font = UIFont.systemFont(ofSize: 15, weight: .light)
        phoneNumberTextField.placeholder = "Insert phone number"
        phoneNumberTextField.textAlignment = .center
        phoneNumberTextField.textContentType = .telephoneNumber
        phoneNumberTextField.keyboardType = .phonePad
        phoneNumberTextField.textColor = UIColor.black
        phoneNumberTextField.borderStyle = UITextField.BorderStyle.roundedRect
        phoneNumberTextField.layer.cornerRadius = 5
        phoneNumberTextField.layer.borderWidth = 1.0
        phoneNumberTextField.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setButttons() {
        butonVerify.setTitle("Verify", for: .normal)
        butonVerify.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        butonVerify.setTitleColor(UIColor.white, for: .normal)
        butonVerify.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.5058823529, blue: 0.1137254902, alpha: 1)
        butonVerify.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layoutUI() {
        view.addSubViews(headerView, headerPhoneNumberSectionView)
        
        headerView.addSubview(logoImageView)
        headerPhoneNumberSectionView.addSubViews(staticTitleLabel, phoneNumberTextField, butonVerify)
        
        NSLayoutConstraint.activate([
            //HeaderView
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5.0),
            headerView.heightAnchor.constraint(equalToConstant: 300),
            
            //LogoImage
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            logoImageView.heightAnchor.constraint(equalToConstant: 300),
            
            //Header Phone Number
            headerPhoneNumberSectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20.0),
            headerPhoneNumberSectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerPhoneNumberSectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            headerPhoneNumberSectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            staticTitleLabel.leadingAnchor.constraint(equalTo: headerPhoneNumberSectionView.leadingAnchor, constant: 5.0),
            staticTitleLabel.trailingAnchor.constraint(equalTo: headerPhoneNumberSectionView.trailingAnchor, constant: -5.0),
            staticTitleLabel.topAnchor.constraint(equalTo: headerPhoneNumberSectionView.topAnchor, constant: 5.0),
            staticTitleLabel.heightAnchor.constraint(equalToConstant: 22.0),

            phoneNumberTextField.leadingAnchor.constraint(equalTo: headerPhoneNumberSectionView.leadingAnchor, constant: 5.0),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: headerPhoneNumberSectionView.trailingAnchor, constant: -5.0),
            phoneNumberTextField.topAnchor.constraint(equalTo: staticTitleLabel.bottomAnchor, constant: 5.0),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 70),
            
            //Verify Phone Number
            butonVerify.leadingAnchor.constraint(equalTo: headerPhoneNumberSectionView.leadingAnchor, constant: 25.0),
            butonVerify.trailingAnchor.constraint(equalTo: headerPhoneNumberSectionView.trailingAnchor, constant: -25.0),
            butonVerify.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 25.0),
            butonVerify.heightAnchor.constraint(equalToConstant: 75),
            butonVerify.widthAnchor.constraint(equalToConstant: 75)
        ])
    }
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    //MARK:- vrify Action
    @objc func verifyPressed(_ sender: UIButton) {
        

        // this for add phone numbers for test in verify like (+01033488611) , pinCode = 123456
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true

        guard let phoneNumber = self.phoneNumberTextField.text else {
            return
        }
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in

            if error == nil {
                print(verificationID)
                guard let verify = verificationID else {return}
                
                UserDefaults.standard.set(verify, forKey: "verifyID")
                UserDefaults.standard.synchronize()
                self.verifyPhoneNumberAlert()

            } else {
                print("unable to get verifation code\(error!.localizedDescription)")
                SVProgressHUD.showSuccess(withStatus: error!.localizedDescription)
                                 SVProgressHUD.dismiss(withDelay: 0.7)
            }
        }
    }
    // Mark:- add pincode for verify after insert your phone number
    func verifyPhoneNumberAlert() {
        let alert = UIAlertController(title: "Verify Phone", message: "Please enter verification code", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { action in
          guard let code = alert.textFields?.first?.text, code != ""     else {
          return
     }
        let verificationID = UserDefaults.standard.value(forKey: "verifyID")
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID! as! String, verificationCode: code)
        Auth.auth().signIn(with: credential) { (authResult, error) in
      if let error = error {
         print(error.localizedDescription)
        } else {
            print(authResult?.user.uid)
         }
      }
    }
       alert.addTextField { textfield in
       textfield.keyboardType = .phonePad
        if #available(iOS 12.0, *) {
            textfield.textContentType = .oneTimeCode
        } else {
            // Fallback on earlier versions
        }
       textfield.placeholder = "Enter code"
       textfield.delegate = self
      }
      alert.addAction(okAction)
        
       
        present(alert, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                let vc = HomeVC()
                 self.present(vc,animated: true)
            }
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.dismiss(animated: true, completion: nil)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // Call the roundCorners() func right there.
        headerPhoneNumberSectionView.roundCorners([.topLeft, .topRight], radius: 25.0)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.9725490196, blue: 0.9960784314, alpha: 1)
        setHeadersView()
        setLogo()
        setLabels()
        setButttons()
        setTextFields()
        layoutUI()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        self.butonVerify.addTarget(self, action: #selector(verifyPressed), for: .touchUpInside)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
  
}
