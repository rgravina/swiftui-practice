import SwiftUI

struct SwiftUIPracticeView: View {
    var body: some View {
        VStack {
            Image(systemName: "figure.walk")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.orange)
                .id("figure.walk")
        }
        .padding()
    }
}

#Preview {
    SwiftUIPracticeView()
        .preferredColorScheme(.dark)
}
