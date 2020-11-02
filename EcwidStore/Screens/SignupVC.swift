//
//  SignupVC.swift
//  EcwidStore
//
//  Created by Logista on 7/26/20.
//  Copyright © 2020 Logista. All rights reserved.
//

import UIKit
import FirebaseAuth
class SignupVC: UIViewController {

    let logoImageView = UIImageView(image: UIImage(named: "Mazra3a"))
    let welcomeLable = UILabel()
    let signinButton = SignButton(bgColor: #colorLiteral(red: 0.2274509804, green: 0.5058823529, blue: 0.1137254902, alpha: 1), title: "Sign In")
    let signupButton = SignButton(bgColor: #colorLiteral(red: 0.9782002568, green: 0.9782230258, blue: 0.9782107472, alpha: 1), title: "Sign Up")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.968627451, blue: 0.9725490196, alpha: 1)
        configure()
        layouUI()
        
    }
    
    func configure(){
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.contentMode = .scaleToFill
        logoImageView.clipsToBounds = true
        
        welcomeLable.translatesAutoresizingMaskIntoConstraints = false
        welcomeLable.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        welcomeLable.textColor = #colorLiteral(red: 0.2274509804, green: 0.5058823529, blue: 0.1137254902, alpha: 1)
        welcomeLable.textAlignment = .center
        welcomeLable.text = "Welcome!"
        
        signupButton.setTitleColor(#colorLiteral(red: 0.2274509804, green: 0.5058823529, blue: 0.1137254902, alpha: 1), for: .normal)
        signupButton.layer.borderWidth = 1
        signupButton.layer.borderColor = #colorLiteral(red: 0.2274509804, green: 0.5058823529, blue: 0.1137254902, alpha: 1)
     
        signupButton.addTarget(self, action: #selector(authenticationPhoneNumberScreen), for: .touchUpInside)
//        signupButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        signinButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
    }
    
    @objc func dismissVC(){
        self.dismiss(animated: true)
    }
    @objc func authenticationPhoneNumberScreen() {
        //MARK:-
        let vc = AuthPhoneNumberRegistration()
         self.present(vc,animated: true)

    }
    func layouUI(){
        view.addSubViews(logoImageView,welcomeLable,signinButton,signupButton)
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            
            welcomeLable.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            welcomeLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLable.heightAnchor.constraint(equalToConstant: 30),
            welcomeLable.widthAnchor.constraint(equalToConstant: 150),
            
            signinButton.topAnchor.constraint(equalTo: welcomeLable.bottomAnchor, constant: 50),
            signinButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            signinButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            signinButton.heightAnchor.constraint(equalToConstant: 50),
            
            signupButton.topAnchor.constraint(equalTo: signinButton.bottomAnchor, constant: 20),
            signupButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            signupButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            signupButton.heightAnchor.constraint(equalToConstant: 50)

        ])
    }
    
    
}
