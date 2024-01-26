import SwiftUI
struct ChatView: View {
    @Binding var messages: [ChatMessage]

    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading, spacing: 10) {
                
                ForEach(messages, id: \.self) { message in
                    Text("\(message.sender): \(message.content)")
                        .padding()
                }
            }
        }
    }
}

struct ChatMessage: Hashable {
    let sender: String
    let content: String
}
