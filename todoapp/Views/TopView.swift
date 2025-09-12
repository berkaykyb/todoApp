//
//  TopView.swift
//  todoapp
//
//  Created by Berkay KAYABAŞI on 8.09.2025.
//

import SwiftUI

struct TopView: View {
    @EnvironmentObject var profileVM: ProfileViewViewModel
    var body: some View {
        HStack(spacing: 16){
            if let user = profileVM.user {
                if let imageUrl = user.image, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                    } placeholder: {
                        Image(systemName: "person.circle")
                            .resizable()
                    }
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                } else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                }

                Text(user.name)
                    .font(.headline)
                
                Spacer()
            }
        }
        .padding()
    }
}

#Preview {
    TopView()
        .environmentObject(ProfileViewViewModel())
}
