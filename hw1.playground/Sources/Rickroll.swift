import Cocoa

/// Plays the world's best song!
public func neverGonnaGiveYouUp() {
    let url = URL(string: "https://www.youtube.com/watch?v=xvFZjo5PgG0")!
    NSWorkspace.shared.open(url)
}
