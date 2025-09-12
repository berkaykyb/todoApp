//
//  BigButtonView.swift
//  todoapp
//
//  Created by Berkay KAYABAŞI on 5.09.2025.
//

import SwiftUI

struct BigButtonView: View {
    let title: String
    let action: () -> Void
    var body: some View {
        Button(action: action, label: {
            ZStack{
                RoundedRectangle(cornerRadius: 5)
                    .foregroundStyle(.primary)
                Text(title)
                    .foregroundStyle(.white)
            }
        })
        .frame(height: 50)
        .padding(.horizontal)
    }
}

#Preview {
    BigButtonView(title: "Örnek Buton", action: {})
}
