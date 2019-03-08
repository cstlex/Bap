//
//  MenuChooseViewController.swift
//  Bap
//
//  Created by Minsoo Kim on 2019-03-07.
//  Copyright © 2019 Minsoo Kim. All rights reserved.
//

import UIKit;

class MenuChooseViewController: UIViewController {

    @IBOutlet weak var menuLabel: UILabel!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }

    @IBAction func choose() {
        let pref = UserDefaults.standard;
        if var foods = pref.object(forKey: "Items") as? [[String:Any]] {
            foods = foods.filter { (food) -> Bool in
                return food["activated"] as? Bool ?? false;
            };
            if foods.count == 0 {
                let controller = UIAlertController(title: "No menu available", message: nil, preferredStyle: .alert);
                
                controller.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
                
                present(controller, animated: true, completion: nil);
                return;
            }
            let index = Int.random(in: 0..<foods.count);
            let food = foods[index];
            menuLabel.text = food["name"] as? String ?? "";
        }
    }
}
