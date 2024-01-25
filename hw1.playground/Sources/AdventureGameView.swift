import SwiftUI
import PlaygroundSupport

struct AdventureGameView<Game: AdventureGame>: View {
    static var cornerRadius: CGFloat { 16 }
    
    @State var model = AdventureGameModel<Game>()
    
    var body: some View {
        ScrollView {
            ScrollViewReader { proxy in
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(model.lines) { line in
                        Text(line.content)
                    }
                }
                .padding()
                .frame(width: 480, alignment: .leading)
                .onChange(of: model.lines.count) {
                    if let line = model.lines.last {
                        proxy.scrollTo(line.id, anchor: .bottom)
                    }
                }
            }
        }
        .safeAreaInset(edge: .top, spacing: 0) {
            VStack(spacing: 0) {
                HStack {
                    Text(model.game.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    Spacer()
                    Button("Reset") {
                        model = .init()
                    }
                }
                .padding()
                Divider()
            }
            .background(.regularMaterial)
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            VStack(spacing: 0) {
                Divider()
                HStack {
                    TextField("Input", text: $model.input)
                        .autocorrectionDisabled()
                        .textFieldStyle(.roundedBorder)
                        .onSubmit {
                            model.submit()
                        }
                    
                    Button {
                        model.submit()
                    } label: {
                        Label("Submit", systemImage: "arrow.forward")
                            .labelStyle(.iconOnly)
                    }
                    .keyboardShortcut(.defaultAction)
                }
                .disabled(model.isEnded)
                .padding()
            }
            .background(.regularMaterial)
        }
        .background(.black)
        .environment(\.colorScheme, .dark)
        .frame(height: 640)
        .controlSize(.large)
        .clipShape(RoundedRectangle(cornerRadius: Self.cornerRadius))
        .overlay {
            RoundedRectangle(cornerRadius: Self.cornerRadius)
                .stroke(.quaternary)
        }
        .padding()
    }
}
