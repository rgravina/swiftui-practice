import SwiftUI

class CombineViewModel: ObservableObject {
}


struct CombineView: View {
    @StateObject var viewModel: CombineViewModel = CombineViewModel()

    var body: some View {
        VStack {
            VStack {
                ScrollView {
                    Text("""
TODO: This view uses Combine.
""")
                }
            }
        }
        .padding()
    }
}
