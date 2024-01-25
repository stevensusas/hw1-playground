import SwiftUI

// Declare your game's behavior in this struct.
//
// This struct will be re-created when the game resets. All game state should
// be stored in this struct.
struct YourGame: AdventureGame {
    var title: String {
        // Return a title to be displayed at the top of the game.
        // You can generate this dynamically based on your game's state.
        
        return "Generic Adventure Game"
    }
    
    mutating func start(context: AdventureGameContext) {
        // This function runs at the start of every game.
        
        context.write("Welcome to Generic Adventure Game!")
    }
    
    mutating func handle(input: String, context: AdventureGameContext) {
        // This function runs when the user enters a line of input.
        //
        // Generally, you parse the user's command, update game state as necessary,
        // then write output.
        //
        // To display a line to the user, use the context.write(_) function and pass
        // in a String, like this:
        //
        // context.write("You have been eaten by a grue.")
        //
        // If you'd like to end the game (say, if the player dies), call
        // context.endGame(). Note that this does *not* display a game over message -
        // it merely disables the buttons and forces the user to reset.
        //
        // Sidenote: context.write() supports AttributedString for rich text
        // formatting. If you'd like to customize how the text is displayed, look up
        // the documentation for the AttributedString struct.
        
        context.write("You decide to \(input). It's not very effective.")
    }
}

// Leave this line in - this line sets up the UI you see on the right.
// Update this if you rename your AdventureGame implementation.
YourGame.display()
