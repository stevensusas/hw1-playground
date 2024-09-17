import SwiftUI

// TODO: Declare any additional structs, classes, enums, or protocols here!

enum Direction: String {
    case north = "north"
    case south = "south"
    case east = "east"
    case west = "west"
}

protocol Location {
    var description: String { get }
    var exits: [Direction: String] { get }
    var person: Person? { get }
    func describe() -> String
}

protocol Person {
    var introduction: String { get }
    var ending: Bool { get }
    var endingText: String? { get }
}

struct Annie: Person {
    let introduction = "Hi! omg you're so cute. I'm Annie I'm an abg from Oakland. I like to rave, listen to Keshi, and get high. Sick party, right? Do you wanna get outta here?"
    let ending = true
    let endingText: String? = "You left the party with Annie, the abg from Oakland... have a good night with her bud!"
}

struct John: Person {
    let name = "John"
    let introduction = "You bring any girls? No? Then why you here? get the f out!"
    let ending = true
    let endingText: String? = "You got absolutely destroyed by the Castle brother, John. Everyone around you is looking at you like a loser. You're no longer in the mood for a party anymore. Why even make the effort to party? It's better to focus on the grind anyways. You are going back to your dorm to wash, get comfy, call your parents, and call it a night."
}

struct Casey: Person {
    let introduction = "Hi I'm Casey! I'm sorry I have a boyfriend already but you're cute. I feel bad for turning you down but I can tell you where the backdoor is to Castle!"
    let ending = false
    let endingText: String? = nil
}

struct Locust: Location {
    let description = "You are at Locust Walk. Which party to hit up next?"
    var exits: [Direction: String] = [.north: "Phi Psi", .east: "Fiji", .west: "Ksig", .south: "Castle"]
    var person: Person? = nil
    func describe() -> String {
        return "\(description)"
    }
}

struct PhiPsi: Location {
    let description = "You are at the Phi Psi house. it's so dead there's not a single soul here."
    var exits: [Direction: String] = [.south: "Locust"]
    var person: Person? = nil
    func describe() -> String {
        return "\(description)"
    }
}

struct Castle: Location {
    let description = "You are at Castle, a grand building often used for events. A tall and strong doorguard suddenly comes to you."
    var exits: [Direction: String] = [.north: "Locust"]
    var person: Person? = John()
    func describe() -> String {
        return "\(description)"
    }
}

struct Fiji: Location {
    let description = "You are at the Fiji house, a quieter place known for its close-knit community. You see a short, cute Asian girl with long lashes and fishnets."
    var exits: [Direction: String] = [.west: "Locust"]
    var person: Person? = Annie()
    func describe() -> String {
        return "\(description)"
    }
}

struct Ksig: Location {
    let description = "You are at Ksig, a large house with a reputation for throwing huge parties. You see a girl-- she's not that cute, but you think you can be good friends with her."
    var exits: [Direction: String] = [.east: "Locust"]
    var person: Person? = Casey()
    func describe() -> String {
        return "\(description)"
    }
}

/// Declare your game's behavior and state in this struct.
///
/// This struct will be re-created when the game resets. All game state should
/// be stored in this struct.
struct YourGame: AdventureGame {
    /// Returns a title to be displayed at the top of the game.
    ///
    /// You can generate this dynamically based on your game's state.
    let title = "It's Friday Night at Penn!"
    var currLocation: Location = Locust()
    /// Runs at the start of every game.
    ///
    /// Use this function to introduce the game to the player.
    ///
    /// - Parameter context: The object you use to write output and end the game.
    mutating func start(context: AdventureGameContext) {
        // TODO: Remove this and implement logic to start your game!
        context.write("Welcome to Friday Night at Penn! Have fun at the parties out there.")
        context.write(currLocation.describe())
    }
    
    /// Runs when the user enters a line of input.
    ///
    /// Generally, you parse the user's command, update game state as necessary, then
    /// write output.
    ///
    /// To display a line to the user, use the `context.write(_)` function and pass in
    /// a ``String``, like this:
    ///
    /// ```swift
    /// context.write("You have been eaten by a grue.")
    /// ```
    ///
    /// If you'd like to end the game (say, if the player dies), call context.endGame().
    /// Note that this does *not* display a game over message - it merely disables
    /// the buttons and forces the user to reset.
    ///
    /// **Sidenote:** context.write() supports AttributedString for rich text formatting.
    /// Consult the [homework instructions](https://www.seas.upenn.edu/~cis1951/assignments/hw/hw1)
    /// for guidance.
    ///
    /// - Parameters:
    ///   - input: The line the user typed.
    ///   - context: The object you use to write output and end the game.
    mutating func handle(input: String, context: AdventureGameContext) {
            let direction = Direction(rawValue: input.lowercased()) // Try to match the input with a direction
            if let direction = direction, let newLocationName = currLocation.exits[direction] {
                // Update the location based on the direction input
                switch newLocationName {
                case "Phi Psi":
                    currLocation = PhiPsi()
                case "Castle":
                    currLocation = Castle()
                case "Fiji":
                    currLocation = Fiji()
                case "Ksig":
                    currLocation = Ksig()
                case "Locust":
                    currLocation = Locust()
                default:
                    context.write("You can't go that way.")
                    return
                }
                context.write("You head \(direction.rawValue) to \(currLocation.name).")
                context.write(currLocation.describe())  // Show new location description
            } else {
                context.write("You can't go that way.")
            }
        }
}

// Leave this line in - this line sets up the UI you see on the right.
// Update this if you rename your AdventureGame implementation.
YourGame.display()
