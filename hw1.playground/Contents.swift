import SwiftUI

// TODO: Declare any additional structs, classes, enums, or protocols here!

enum Direction: String {
    case north = "north"
    case south = "south"
    case east = "east"
    case west = "west"
    case talk = "talk"
    case help = "help"
}

protocol Location {
    var name: String{ get }
    var description: String { get }
    var exits: [Direction: String] { get }
    var person: Person? { get }
    func describe() -> String
}

protocol Person {
    var name: String { get }
    var introduction: String { get }
    var ending: Bool { get }
    var endingText: String { get }
}

struct Annie: Person {
    let name = "Annie"
    let introduction = "Hi! omg you're so cute. I'm Annie I'm an abg from Oakland. I like to rave, listen to Keshi, and get high. Sick party, right? Do you wanna get outta here?"
    let ending = true
    let endingText: String = "You left the party with Annie, the abg from Oakland... have a good night with her bud!"
}

struct John: Person {
    let name = "John"
    let introduction = "You bring any girls? No? Then why you here? get the f out!"
    let ending = true
    let endingText: String = "You got absolutely destroyed by the Castle brother, John. Everyone around you is looking at you like a loser. You're no longer in the mood for a party anymore. Why even make the effort to party? It's better to focus on the grind anyways. You are going back to your dorm to wash, get comfy, call your parents, and call it a night."
}

struct Casey: Person {
    let name = "Casey"
    let introduction = "Hi I'm Casey! I'm sorry I have a boyfriend already but you're cute. I feel bad for turning you down but I can tell you where the backdoor is to Castle! She whispered to your ear the backdoor location of Castle."
    let ending = false
    let endingText: String = ""
}

struct Locust: Location {
    let name = "Locust"
    let description = "You are at Locust Walk. Which party to hit up next?"
    var exits: [Direction: String] = [.north: "Phi Psi", .east: "Fiji", .west: "Ksig", .south: "Castle", .help: "help"]
    var person: Person? = nil
    func describe() -> String {
        return "\(description)"
    }
}

struct PhiPsi: Location {
    let name = "PhiPsi"
    let description = "You are at the Phi Psi house. it's so dead there's not a single soul here."
    var exits: [Direction: String] = [.south: "Locust", .help: "help"]
    var person: Person? = nil
    func describe() -> String {
        return "\(description)"
    }
}

struct Castle: Location {
    let name = "Castle"
    let description = "You are at Castle, a grand building often used for events. A tall and strong doorguard suddenly comes to you. He seems like he wants to talk to you."
    var exits: [Direction: String] = [.north: "Locust", .talk: "talk", .help: "help"]
    var person: Person? = John()
    func describe() -> String {
        return "\(description)"
    }
}

struct Fiji: Location {
    let name = "Fiji"
    let description = "You are at the Fiji house, a quieter place known for its close-knit community. You see a short, cute Asian girl with long lashes and fishnets. Maybe you should talk to her!"
    var exits: [Direction: String] = [.west: "Locust", .talk: "talk", .help: "help"]
    var person: Person? = Annie()
    func describe() -> String {
        return "\(description)"
    }
}

struct Ksig: Location {
    let name = "Ksig"
    let description = "You are at Ksig, a large house with a reputation for throwing huge parties. You see a girl-- she's not that cute, but you think you can be good friends with her. Maybe you should talk to her!"
    var exits: [Direction: String] = [.east: "Locust", .talk: "talk", .help: "help"]
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
    var end = false
    var key = false
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
        if end {
            context.write("The game is already over.")
            return
        }
            let direction = Direction(rawValue: input.lowercased()) // Try to match the input with a direction
            if let direction = direction, let newLocationName = currLocation.exits[direction] {
                // Update the location based on the direction input
                switch newLocationName {
                case "Phi Psi":
                    currLocation = PhiPsi()
                case "Castle":
                    currLocation = Castle()
                    if key {
                        end = true
                        context.write("You got into Castle through the backdoor that Casey told you, one of the best frats on campus. Have a great night!")
                        return
                    }
                case "Fiji":
                    currLocation = Fiji()
                case "Ksig":
                    currLocation = Ksig()
                case "Locust":
                    currLocation = Locust()
                case "help":
                    let joinedValues = currLocation.exits.keys.map { $0.rawValue }.joined(separator: ", ")
                    context.write(joinedValues)
                    return
                case "talk":
                    if let person = currLocation.person {
                        if person.name == "Casey" {
                            key = true
                        }
                        context.write(person.introduction)
                        if person.ending {
                         end = true
                            context.write(person.endingText)
                        }
                    }
                    return
                default:
                    context.write("You can't do that.")
                    return
                }
                context.write("You head \(direction.rawValue) to \(currLocation.name).")
                context.write(currLocation.describe())  // Show new location description
            } else {
                context.write("You can't do that.")
            }
        }
}

// Leave this line in - this line sets up the UI you see on the right.
// Update this if you rename your AdventureGame implementation.
YourGame.display()

