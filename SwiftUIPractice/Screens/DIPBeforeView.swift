import SwiftUI

class DIPBeforeViewModel: ObservableObject {
}

struct DIPBeforeView: View {
    @StateObject var viewModel = DIPBeforeViewModel()

    var body: some View {
        VStack {
            VStack {
                ScrollView {
                    Text("""
TODO: This view contains an example not using DIP.
""")
                }
            }
        }
        .padding()
    }
}
