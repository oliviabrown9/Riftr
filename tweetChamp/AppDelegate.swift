//
//  AppDelegate.swift
//  tweetChamp
//
//  Created by Olivia Brown on 7/6/16.
//  Copyright © 2016 tweetChamp. All rights reserved.
//

import UIKit
import Fabric
import TwitterKit
import Parse


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    //Initial Fabric and Parse
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Fabric.with([Twitter.self])
        
        // Set up the Parse SDK
        let configuration = ParseClientConfiguration {
            $0.applicationId = "test"
            $0.server = "https://tester-av.herokuapp.com/parse"
        }
        Parse.initialize(with: configuration)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}

