//
//  HeaderView.swift
//  todoapp
//
//  Created by Berkay KAYABAŞI on 3.09.2025.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        ZStack{
            Image("todoapp-logo")
                .resizable()
                .frame(width: 300, height: 150)
        }.padding(.top, 100)
    }
}

#Preview {
    HeaderView()
}
