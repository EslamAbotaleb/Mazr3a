//
//  SignButton.swift
//  EcwidStore
//
//  Created by Logista on 7/26/20.
//  Copyright © 2020 Logista. All rights reserved.
//

import UIKit

class SignButton: UIButton {

   override init(frame: CGRect) {
       super.init(frame: frame)
       configure()
   }
   
   convenience init(bgColor:UIColor,title:String){
       self.init(frame: .zero)
       self.backgroundColor = bgColor
       self.setTitle(title, for: .normal)
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   
   private func configure() {
       layer.cornerRadius = 10
       setTitleColor(.white, for: .normal)
       titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
       translatesAutoresizingMaskIntoConstraints = false
   }

}
