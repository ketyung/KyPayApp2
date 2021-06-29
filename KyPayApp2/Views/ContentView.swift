//
//  ContentView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 12/06/2021.
//

import SwiftUI


struct ContentView: View {

    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    @EnvironmentObject private var viewModel : UserViewModel
    
    @State private var toShowAlert : Bool = false
    
    var body: some View {
        
        view()
    }
}


extension ContentView {
    
    
    @ViewBuilder
    private func view() -> some View {
        
        if viewModel.hasSignedIn {
            
           homeTabbedView()
            
        }
        else {
            
            LoginView()
        }
        
    }

    
}

extension ContentView {
    
    private func homeTabbedView() -> some View {
        
        HomeTabbedView()
        .onReceive( NotificationCenter.default.publisher(for:AppDelegate.deviceTokenPublisher), perform: { obj in
            
            if let token = obj.object as? String {
                
                print("received custom notification::\(token)")
            
            }
                
        })
        .onAppear{
            
            // registerForRemoteNotifications()
        }
        .alert(isPresented: $toShowAlert) {
            Alert(title: Text("Notification has been disabled for this app"),
            message: Text("Please go to settings to enable it now"),
               primaryButton: .default(Text("Go To Settings")) {
                  self.goToSettings()
               },
               secondaryButton: .cancel())
        }
        
    }
    
    
    
    private func registerForRemoteNotifications(){
        
        appDelegate.registerForPushNotifications(onDeny: {
            
            self.toShowAlert = true
        })
 
    }
    
    
    private func goToSettings(){
        
        DispatchQueue.main.async {
         
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
          
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
