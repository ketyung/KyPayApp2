//
//  SceneDelegate.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 12/06/2021.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Create the SwiftUI view that provides the window contents.
        
        // ARH.shared.requestUser()
        
        //Tester.testAddPayment()
         
        // Tester.testAddUser()
         
         
         //Tester.testSignOut()
         
        // Tester.testJson()
         
         //+60128126882
         
        // Tester.testAddUserAddr()
        //Tester.fetchUser(id: "Yon_pgP5FOzMeJM2")
         
         //Tester.testFetchUserAddress()
         
       //  Tester.testAddUserWallet()
         
         //Tester.testSignIn()//phoneNumber: "+60128126882")
         // Create the SwiftUI view that provides the window contents.
       
       // Tester.testDecodeCountries()
        
        //Tester.testAccessOtherBundle()
        
        //Tester.testStoreAndRetrieveUser()
        
       // Tester.testPhoneAuth()
        
        //Tester.testAddPayment()
        
    
       // Tester.testFetchAllContacts()
        
        //Tester.testLoopAllContactsInDb()
        //Tester.testRCountries()
        
        //Tester.testRCurrencies()
        
        
        //print("xxxx....c::\(CurrencyManager.currency(countryCode: "AD") ?? "xxxx")")
        
        
        //let tx = TxHandler()
        //tx.transfer(phoneNumber: "+60168112493", amount: 20, currency: "MYR")
        
        
        let contentView =
        
        //    TopUpSucessView().environmentObject(TopUpPaymentViewModel()).environmentObject(UserWalletViewModel())
       
        /** PaymentRedirectView(url:  URL(string: "https://sandboxdashboard.rapyd.net/complete-bank-payment?token=payment_59bb607e45b227237639f0fdcda6d01a&complete_payment_url=https%3A%2F%2Ftechchee.com%2FKyPaySuccess&error_payment_url=https%3A%2F%2Ftechchee.com%2FKyPayFailed)")) */
        
        //PaymentRedirectView(url: URL(string: "http://127.0.0.1:808/KyPay/Test2.php"))
        //    ContactsListView()
        //CountDownTextView(viewModel: OtpTextViewModel())
            ContentView().environmentObject(PhoneInputViewModel()).environmentObject(UserViewModel()).environmentObject(UserWalletViewModel()).environmentObject(TxInputDataViewModel()).environmentObject(MessagesViewModel()).environmentObject(SellerItemsViewModel())
            .environmentObject(CartViewModel()) 
       //SellerItemsView().environmentObject(PhoneInputViewModel()).environmentObject(UserViewModel()).environmentObject(UserWalletViewModel()).environmentObject(TxInputDataViewModel()).environmentObject(MessagesViewModel()).environmentObject(SellerItemsViewModel())
    
        //SendMoneyView().environmentObject(PhoneInputViewModel()).environmentObject(UserViewModel()).environmentObject(UserWalletViewModel()).environmentObject(TxInputDataViewModel())
        
        
        //FirstSignInView().environmentObject(PhoneInputViewModel()).environmentObject(UserViewModel())

        
        //OTPView().environmentObject(PhoneInputViewModel()).environmentObject(UserViewModel())
            //LoginView().environmentObject(PhoneInputViewModel()).environmentObject(UserViewModel())

            //HomeTabbedView().environmentObject(UserViewModel())
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

