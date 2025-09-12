import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewViewModel()
    @StateObject var profileVM = ProfileViewViewModel()

    var body: some View {
        if viewModel.isSignedIn, let user = viewModel.currentUser {
            accountView(user: user)
        } else {
            LoginView()
        }
    }

    @ViewBuilder
    func accountView(user: User) -> some View {
        TabView {
            ToDoListView(user: user)
                .tabItem { Label("Görevler", systemImage: "house") }
                .environmentObject(profileVM)

            ProfileView()
                .tabItem { Label("Profil", systemImage: "person.circle") }
                .environmentObject(profileVM) 
        }
    }
}

#Preview {
    MainView()
}
