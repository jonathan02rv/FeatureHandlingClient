//
//  AppDelegate.swift
//  TestFrameworkCarthage
//
//  Created by Jhonatahan Orlando Rivera Vilcapoma on 9/07/21.
//

import UIKit
import LaunchDarkly

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let mobileKey = "mob-54985da9-7c19-47cf-91f7-c2a12225aa57"
    var ldCliet: LaunchDarklyClient?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setUpLDClient()
        return true
    }
    
    private func setUpLDClient() {
        let user = LDUser(key: "test@email.com")

        let config = LDConfig(mobileKey: mobileKey)
        LDClient.start(config: config, user: user)
        ldCliet = LaunchDarklyClient()
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

