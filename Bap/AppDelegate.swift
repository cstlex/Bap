//
//  AppDelegate.swift
//  Bap
//
//  Created by Minsoo Kim on 2020/07/04.
//  Copyright © 2020 Minsoo Kim. All rights reserved.
//

import UIKit;
import Firebase;

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let pref = UserDefaults.standard;
        if pref.object(forKey: "Items") == nil {
            pref.set([], forKey: "Items");
            pref.synchronize();
        }
        if let items = pref.array(forKey: "Items") as? [[String:Any]] {
            var currentId = 1;
            let foods = items.map { (item) -> Food in
                var food = Food(id: currentId);
                currentId += 1;
                food.name = item["name"] as? String ?? "";
                food.isActivated = item["activated"] as? Bool ?? false;
                return food;
            };
            foods.save();
        }
        FirebaseApp.configure();
        UISwitch.appearance().onTintColor = UIColor.label;
        UINavigationBar.appearance().tintColor = UIColor.label;
        
        return true;
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

