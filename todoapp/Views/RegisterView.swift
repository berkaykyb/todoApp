//
//  RegisterView.swift
//  todoapp
//
//  Created by Berkay KAYABAŞI on 3.09.2025.
//

import SwiftUI

struct RegisterView: View {    
    @StateObject var viewModel = RegisterViewViewModel()
    @State var showPassword: Bool = false
    var body: some View {
        NavigationStack{
            VStack{
                // Header
                HeaderView()
                
                //Register Formu
                Form{
                    Section(header: Text("Kayıt Formu")
                        .bold()
                    ){
                        if !viewModel.errorMessage.isEmpty{
                            Text(viewModel.errorMessage)
                                .foregroundStyle(.red)
                        }
                        TextField("Tam Adınız", text: $viewModel.name)
                            .autocorrectionDisabled()
                        TextField("Email Adresiniz", text: $viewModel.email)
                            .autocorrectionDisabled()
                            .autocapitalization(.none)
                        HStack{
                            if showPassword{
                                TextField("Şifeniz", text: $viewModel.password)
                            }else{
                                SecureField("Şifreniz", text: $viewModel.password)
                            }
                            Button {
                                showPassword.toggle()
                            } label: {
                                Image(systemName: showPassword ? "eye" : "eye.slash")
                                    .foregroundStyle(.gray)
                            }

                        }
                    }
                }
                .frame(height: 230)
                Button(action: {
                    viewModel.register()
                }, label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundStyle(.primary)
                        Text("Kayıt Ol")
                            .foregroundStyle(.white)
                    }
                })
                .frame(height: 50)
                .padding(.horizontal)
                Spacer()

                
                //Footer
                VStack{
                    Text("Zaten hesabın var mı?")
                    NavigationLink("Giriş Yap!", destination: LoginView())
                        .navigationBarBackButtonHidden(true)
                }
                
            }
        }
    }
}

#Preview {
    RegisterView()
}
