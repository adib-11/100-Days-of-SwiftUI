import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Adib").prominentTitle()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

private struct ProminantTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.weight(.bold))
            .foregroundColor(.blue)
    }
}

extension View {
    func prominentTitle() -> some View {
        modifier(ProminantTitle())
    }
}
