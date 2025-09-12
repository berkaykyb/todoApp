import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var profileVM: ProfileViewViewModel
    @State private var isEditing = false
    @State private var newName = ""
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage? = nil

    var body: some View {
        NavigationView{
            VStack{
                if let user = profileVM.user{
                    profile(user: user)
                } else {
                    Text("Profil yükleniyor...")
                }
                
                BigButtonView(title: "Çıkış Yap"){
                    profileVM.logout()
                }
            }
            .navigationTitle("Profil")
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $selectedImage)
        }
    }

    @ViewBuilder
    func profile(user: User) -> some View {
        VStack(spacing: 20){
            Button{
                showImagePicker = true
            } label: {
                if let selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 125, height: 125)
                        .clipShape(Circle())
                } else if let imageUrl = user.image, let url = URL(string: imageUrl) {
                    AsyncImage(url: url){ image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 125, height: 125)
                    .clipShape(Circle())
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(.blue)
                        .frame(width: 125, height: 125)
                }
            }

            VStack(alignment: .leading, spacing: 10){
                HStack{
                    Text("İsim: ")
                    if isEditing {
                        TextField("İsim", text: $newName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    } else {
                        Text(user.name)
                    }
                }
                HStack{
                    Text("Email: ")
                    Text(user.email)
                }
                HStack{
                    Text("Kayıt Tarihi: ")
                    Text("\(Date(timeIntervalSince1970:user.joined).formatted(date: .abbreviated, time: .shortened))")
                }
            }

            if isEditing {
                BigButtonView(title: "Kaydet") {
                    if !newName.isEmpty {
                        profileVM.updateName(newName: newName)
                    }
                    if let selectedImage {
                        profileVM.uploadProfileImage(image: selectedImage)
                    }
                    isEditing = false
                }
            }

            Button(isEditing ? "İptal" : "Düzenle") {
                if isEditing { newName = user.name }
                isEditing.toggle()
            }
        }
        .padding()
    }
}

#Preview {
    ProfileView()
        .environmentObject(ProfileViewViewModel())
}

