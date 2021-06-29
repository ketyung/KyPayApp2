//
//  AppDelegate.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 12/06/2021.
//

import UIKit
import Firebase
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        self.publishDeviceToken("key:\("".random(length: 20))")
        
        return true
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

extension AppDelegate {
    
    func registerForPushNotifications(onDeny handler :  (()-> Void)? = nil) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            [weak self] granted, _ in
            
            guard granted else { return }
            
            guard let self = self else { return }
            
            self.getNotificationSettings(onDeny: handler)
        }
    }
    
    
    private func getNotificationSettings( onDeny handler :  (()-> Void)? = nil ) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            
            
            guard settings.authorizationStatus == .authorized else {
                
                if settings.authorizationStatus == .denied {
                    
                    handler?()
                    return
                }
                
                return
    
            }
           
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
}

extension AppDelegate {
    
    private static let deviceTokenPublisherName = "com.techchee.kypayapp.deviceToken"
    
    static let deviceTokenPublisher = Notification.Name(deviceTokenPublisherName)
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
    {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error)
    {
        print("Failed to register: \(error)")
        
    }
    
    func publishDeviceToken(_ token : String){
        
        DispatchQueue.main.async {
   
            NotificationCenter.default.post(name: AppDelegate.deviceTokenPublisher, object: token)
        }
    }
    
}

