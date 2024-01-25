import SwiftUI
import PlaygroundSupport

public protocol AdventureGame {
    init()
    
    var title: String { get }
    
    mutating func start(context: AdventureGameContext)
    mutating func handle(input: String, context: AdventureGameContext)
}

public protocol AdventureGameContext {
    func write(_ attributedString: AttributedString)
    func endGame()
}

public extension AdventureGame {
    static func display() {
        PlaygroundPage.current.setLiveView(AdventureGameView<Self>())
    }
}

public extension AdventureGameContext {
    func write(_ string: String) {
        write(AttributedString(string))
    }
}
