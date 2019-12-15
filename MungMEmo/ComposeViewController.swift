//
//  ComposeViewController.swift
//  MungMEmo
//
//  Created by 박정태 on 2019/12/15.
//  Copyright © 2019 JeongTae Park. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func close(_ sender: Any) {
        print("hello world")
        dismiss(animated: true, completion: nil)
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
