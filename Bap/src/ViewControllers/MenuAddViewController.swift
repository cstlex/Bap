//
//  MenuAddViewController.swift
//  Bap
//
//  Created by Minsoo Kim on 2019-03-07.
//  Copyright © 2019 Minsoo Kim. All rights reserved.
//

import UIKit

class MenuAddViewController: UIViewController {

    @IBOutlet weak var menuNameField: UITextField!;
    @IBOutlet weak var defaultActivationSwitch: UISwitch!;
    @IBOutlet weak var addButton: UIButton!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func addMenu() {
        let pref = UserDefaults.standard;
        var items: [[String:Any]] = (pref.value(forKey: "Items") as? [[String:Any]]) ?? [];
        items.append(["name": menuNameField.text!, "activated": defaultActivationSwitch.isOn]);
        pref.set(items, forKey: "Items");
        pref.synchronize();
        navigationController?.popViewController(animated: true);
    }
}

extension MenuAddViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            if let text = self.menuNameField.text, text != "" {
                self.addButton.isEnabled = true;
            } else {
                self.addButton.isEnabled = false;
            }
        };
        
        return true;
    }
}
