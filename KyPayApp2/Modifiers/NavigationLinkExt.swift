//
//  NavigationLinkExt.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 27/06/2021.
//

import SwiftUI

extension NavigationLink where Label == EmptyView, Destination == EmptyView {

   static var empty: NavigationLink {
       self.init(destination: EmptyView(), label: { EmptyView() })
   }
}
