import SwiftUI

struct AdventureGameLine: Identifiable {
    let id = UUID()
    let content: AttributedString
}

@Observable class AdventureGameModel<Game: AdventureGame>: AdventureGameContext {
    var game = Game()
    var input = ""

    private(set) var isEnded = false
    private(set) var lines = [AdventureGameLine]()
    
    public func write(_ attributedString: AttributedString) {
        lines.append(AdventureGameLine(content: attributedString))
        
        // Prevent lines from getting too long
        let threshold = 1000
        if lines.count > threshold {
            lines.removeFirst(lines.count - threshold)
        }
    }
    
    public func endGame() {
        isEnded = true
    }
    
    init() {
        game.start(context: self)
    }
    
    func submit() {
        var inputAttributedString = AttributedString(input)
        inputAttributedString.swiftUI.font = .body.bold().italic()
        inputAttributedString.swiftUI.foregroundColor = .primary.opacity(0.6)
        
        lines.append(AdventureGameLine(content: inputAttributedString))
        game.handle(input: input, context: self)
        input = ""
    }
}
