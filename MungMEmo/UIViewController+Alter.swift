//
//  UIViewController+Alter.swift
//  MungMEmo
//
//  Created by 박정태 on 2019/12/15.
//  Copyright © 2019 JeongTae Park. All rights reserved.
//

import UIKit


extension UIViewController {
    func alert(title: String = "알림", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert) // preferredStyle: .alert
        
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
}
