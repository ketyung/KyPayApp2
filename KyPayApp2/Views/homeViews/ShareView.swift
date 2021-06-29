//
//  ActivityView.swift
//  SwiftUIPdf
//
//  Created by Chee Ket Yung on 21/02/2021.
//

import SwiftUI

struct ShareView: UIViewControllerRepresentable {

    @Binding var activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil 

    func makeUIViewController(context: UIViewControllerRepresentableContext<ShareView>) -> UIActivityViewController {
        return UIActivityViewController(activityItems: activityItems,applicationActivities: applicationActivities)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController,
                                context: UIViewControllerRepresentableContext<ShareView>) {
        // empty
    }
}
