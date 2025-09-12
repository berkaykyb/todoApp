import FirebaseFirestore
import SwiftUI

enum TaskFilter {
    case all, todo, success, failed
}

struct ToDoListView: View {
    let user: User
    @StateObject var viewModel: ToDoListViewViewModel
    @FirestoreQuery var items: [ToDoListItem]
    @State private var selectedFilter: TaskFilter = .all
    @EnvironmentObject var profileVM: ProfileViewViewModel // ✅ Aynı instance

    init(user: User){
        self.user = user
        self._items = FirestoreQuery(collectionPath: "users/\(user.id)/todos")
        self._viewModel = StateObject(wrappedValue: ToDoListViewViewModel(userId: user.id))
    }

    var filteredItems: [ToDoListItem] {
        let now = Date().timeIntervalSince1970
        switch selectedFilter {
        case .all: return items
        case .todo: return items.filter { !$0.isDone && $0.dueDate > now }
        case .success: return items.filter{ $0.isDone }
        case .failed: return items.filter { !$0.isDone && $0.dueDate <= now }
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            TopView()
                .padding()
            HStack {
                Text("Görevler")
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
                
                Button {
                    viewModel.showingNewItemView = true
                } label: {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundStyle(.blue)
                }
            }
            .padding([.horizontal, .bottom])

            HStack{
                Button("Tümü") { selectedFilter = .all }
                Text(" | ").foregroundStyle(.blue)
                Button("Yapılacaklar") { selectedFilter = .todo }
                Text(" | ").foregroundStyle(.blue)
                Button("Başarısız") { selectedFilter = .failed }
                Text(" | ").foregroundStyle(.blue)
                Button("Başarılı") { selectedFilter = .success }
            }

            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.blue)
                .padding()

            List {
                ForEach(filteredItems) { item in
                    ToDoListItemView(item: item)
                        .swipeActions {
                            Button("Sil") { viewModel.delete(id: item.id) }
                                .tint(.red)
                        }
                }
            }
            .scrollContentBackground(.hidden)
        }
        .sheet(isPresented: $viewModel.showingNewItemView) {
            NewItemView(newItemPresented: $viewModel.showingNewItemView)
        }
    }
}

#Preview {
    ToDoListView(user: User(
        id: "fEtxrSYz79aIFvhoVS6S1cvzexv1",
        name: "Berkay",
        email: "test@mail.com",
        joined: Date().timeIntervalSince1970,
        image: nil
    ))
    .environmentObject(ProfileViewViewModel())
}
