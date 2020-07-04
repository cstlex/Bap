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
            
            showAnimation(foods: foods);
        }
    }
    
    func showAnimation(foods: [[String:Any]], currentCount: Int = 1) {
        let index = Int.random(in: 0..<foods.count);
        let food = foods[index];
        menuLabel.text = food["name"] as? String ?? "";
        if currentCount == 25 {
            menuLabel.alpha = 0.0;
            UIView.animate(withDuration: 2.0) {
                self.menuLabel.alpha = 1.0;
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                self.showAnimation(foods: foods, currentCount: currentCount + 1);
            }
        }
    }
}
