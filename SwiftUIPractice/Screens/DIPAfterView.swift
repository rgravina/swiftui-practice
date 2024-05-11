import SwiftUI

class DIPAfterViewModel: ObservableObject {
}

struct DIPAfterView: View {
    @StateObject var viewModel = DIPAfterViewModel()

    var body: some View {
        VStack {
            VStack {
                ScrollView {
                    Text("""
TODO: This view contains an example using DIP.
""")
                }
            }
        }
        .padding()
    }
}
