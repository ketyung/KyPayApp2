//
//  RequestView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 15/06/2021.
//

import SwiftUI

struct RequestView : View {

    @State private var selectedContacts : [Contact] = []
    
    @State private var kypayUsers : [KyPayUser] = []
    
    @EnvironmentObject private var txInputViewModel : TxInputDataViewModel
    
    @ObservedObject private var moneyRequestViewModel = MoneyRequestViewModel()
    
    @State private var requestChoiceViewPresented : Bool = false
    
    static let toSyncContactPublisher = Notification.Name("com.techchee.kypay.toSyncContactPublisher.id")
   
    var body: some View{
        
        VStack(alignment: .leading){
            
            refreshButton()
            
            Spacer().frame(height:30)
            
            Text("Request Money From".localized).font(.custom(Theme.fontNameBold, size: 30))

            Text("You can select up to 5 numbers to split the bill among them!")
                .font(.custom(Theme.fontName, size: 16)).foregroundColor(.gray)
            
            self.contactsScrollView()
            
            Spacer().frame(height:30)
            
            //ContactsListView(selectedContacts: $selectedContacts)
            
            KypayUserSelectionView(selectedContacts: $selectedContacts, kypayUsers: $kypayUsers)
            
            Spacer()
            
        }
        .padding()
        .progressView(isShowing: $txInputViewModel.showProgressIndicator, text: "Syncing contacts...",
            size:  CGSize(width:200, height: 200))
        .onReceive( NotificationCenter.default.publisher(for:RequestView.toSyncContactPublisher), perform: { _ in
     
           syncContacts()
           // print("receive.to.sync!!!")
        
        })
        .popOver(isPresented: $requestChoiceViewPresented , content: {
            
            RequestChoiceView(selectedContacts: $selectedContacts)
            
        })
        .bottomFloatingButton( isPresented: self.requestButtonPresented() , action: {
            
            withAnimation{
                
                self.requestChoiceViewPresented.toggle()
            }
            
        })
        .environmentObject(moneyRequestViewModel)
   
    }
    
    
    private func requestButtonPresented() -> Bool {
        
        return selectedContacts.count > 0 && !self.requestChoiceViewPresented
    }
}


extension RequestView {
    
    private func contactsScrollView() -> some View {
        
        ScrollView (.horizontal, showsIndicators:false ){
            
            HStack (spacing: 20) {
                ForEach(self.selectedContacts, id:\.cnIdentifier) {
                    
                    contact in
                    
                    contactView(contact)
                }
            }.padding()
        }
    }
    
    
    private func contactView(_ contact : Contact) -> some View {
        
        ZStack{
            
            let f = contact.firstName.prefix(1).uppercased()
            
            Circle().fill(Color.orange)
            .frame(width: 50, height: 50)
            
            let t = "\(f)\(contact.lastName.prefix(1).uppercased())"
            Text(t)
            .font(.custom(Theme.fontNameBold, size: 18))
            .foregroundColor(.white)
            
            
            Button(action : {
                
                withAnimation{
                    
                    selectedContacts.remove(object: contact)
                }
            }){
           
                Image(systemName: "x.circle.fill")
                .resizable()
                .frame(width:18, height: 18, alignment: .bottomTrailing)
                .foregroundColor(.black).offset(x: 20, y: 20)
               
            }
            
            
           
        }
    
    }
    
}

extension RequestView {
    
    
    private func syncContacts(force : Bool = false ){
        
        if !force {
            
            kypayUsers = KyPayContactDataStore().all() ?? []
        }
        
        txInputViewModel.syncContact(forceSyncing: force, completion: {
            
            kypayUsers = KyPayContactDataStore().all() ?? []
     
        })
    }
    
    
    private func refreshButton() -> some View {
        
        HStack {
        
            Spacer()
   
            Button(action: {
                
                syncContacts(force: true)
            }){
                Image("reload")
                .resizable()
                .frame(width:24, height: 24, alignment: .topTrailing)
                .foregroundColor(.gray)
            }
        
            Spacer().frame(width:10)
        }
    }
}
