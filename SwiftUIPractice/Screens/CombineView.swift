import SwiftUI
import Combine

class CombineViewModel: ObservableObject {
    var uuidPublisher: PassthroughSubject<UUID, Never>
    var cancellable: AnyCancellable?
    @Published var uuids = [UUID]()

    init() {
        uuidPublisher = PassthroughSubject<UUID, Never>()
    }

    func listen() {
        self.cancellable = uuidPublisher.sink { uuid in
            self.uuids.append(uuid)
        }
    }

    func sendEvent() {
        uuidPublisher.send(UUID())
    }

    func clearList() {
        uuids.removeAll()
    }
}

struct CombineView: View {
    @StateObject var viewModel: CombineViewModel = CombineViewModel()

    var body: some View {
        VStack {
            Text("""
This view uses a PassthroughSubject to send UUIDs to a subscriber on the view model that updates a list.
"""
            )
            HStack {
                Button("Send Event") {
                    viewModel.sendEvent()
                }.buttonStyle(PrimaryButtonStyle(color: .green))
                Button("Clear List") {
                    viewModel.clearList()
                }.buttonStyle(PrimaryButtonStyle(color: .green))
            }
            List {
                ForEach(viewModel.uuids, id: \.self) { uuid in
                    Text(uuid.uuidString)
                        .font(.system(size: 14, weight: .regular, design: .monospaced))
                        .foregroundColor(.green)
                }
            }
        }
        .onAppear {
            viewModel.listen()
        }
        .padding()
    }
}
