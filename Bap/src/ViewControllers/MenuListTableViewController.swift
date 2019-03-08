//
//  MenuListTableViewController.swift
//  Bap
//
//  Created by Minsoo Kim on 2019-03-07.
//  Copyright © 2019 Minsoo Kim. All rights reserved.
//

import UIKit

class MenuListTableViewController: UITableViewController {
    
    var foods: [[String:Any]] = [];
    
    @IBOutlet weak var toggleSwitch: UISwitch!;

    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        let pref = UserDefaults.standard;
        if let foods = pref.object(forKey: "Items") as? [[String:Any]] {
            self.foods = foods;
            self.tableView.reloadData();
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 1;
        }
        return foods.count;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            return tableView.dequeueReusableCell(withIdentifier: "Add New", for: indexPath);
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "Menu", for: indexPath) as! MenuListTableViewCell;
        
        let item = foods[indexPath.row];
        
        cell.menuTitleLabel.text = item["name"] as? String ?? "";
        cell.activatedSwitch.isOn = item["activated"] as? Bool ?? true;
        cell.activatedSwitch.tag = indexPath.row;

        return cell;
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            foods.remove(at: indexPath.row);
            let pref = UserDefaults.standard;
            pref.set(foods, forKey: "Items");
            pref.synchronize();
            tableView.reloadData();
        }
    }
    
    @IBAction func toggleAll(){
        for i in 0..<foods.count {
            foods[i]["activated"] = toggleSwitch.isOn;
        }
        let pref = UserDefaults.standard;
        pref.set(foods, forKey: "Items");
        pref.synchronize();
        tableView.reloadData();
    }

    @IBAction func toggleActivated(_ sender: UISwitch) {
        var item = foods[sender.tag];
        
        if let activated = item["activated"] as? Bool {
            item["activated"] = !activated;
        } else if let activated = item["activated"] as? Int {
            item["activated"] = activated != 1;
        } else {
            item["activated"] = true;
        }
        foods[sender.tag] = item;
        let pref = UserDefaults.standard;
        pref.set(foods, forKey: "Items");
        pref.synchronize();
    }
}
