//
//  LoginView.swift
//  todoapp
//
//  Created by Berkay KAYABAŞI on 3.09.2025.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()
    @State var showPassword: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                // Header
                HeaderView()
                // Form - email, şifre ve buton
                Form{
                    if !viewModel.errorMessage.isEmpty{
                        Text(viewModel.errorMessage)
                            .foregroundStyle(.red)
                    }
                    TextField("Email Adresiniz",text: $viewModel.email)
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                    HStack {
                        if showPassword{
                            TextField("Şifreniz", text: $viewModel.password)
                        }else{
                            SecureField("Şifreniz", text: $viewModel.password)
                        }
                        
                        Button(action: {
                            showPassword.toggle()
                        }){
                            Image(systemName: showPassword ? "eye" : "eye.slash")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .frame(height: 190)
                Button(action: {
                    viewModel.login()
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundStyle(.primary)
                        Text("Giriş Yap")
                            .foregroundStyle(.white)
                    }
                })
                .frame(height: 50)
                .padding(.horizontal)
                Spacer()
                // Footer - hesabınız yok mu
                
                VStack{
                    Text("Buralarda yeni misin?")
                    NavigationLink("Yeni hesap oluştur!", destination: RegisterView())
                        .navigationBarBackButtonHidden(true)
                }
                
            }
        }
    }
}

#Preview {
    LoginView()
}
