//
//  AppDelegate.swift
//  Todoey
//
//  Created by John Young on 2/3/19.
//  Copyright © 2019 John Young. All rights reserved.
//

import UIKit
import RealmSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
 
        
        do{
            _ = try Realm()
            
        } catch {
            
            print("Error initialisng new realm, \(error)")
        }
        
        
        
        return true
    }

}
