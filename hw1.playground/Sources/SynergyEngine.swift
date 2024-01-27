import Cocoa

/// Super advanced synergy engine for maximum productivity.
///
/// We use an `enum` without any cases since this isn't really
/// a type that can be initialized - we're just using it as a namespace.
public enum SynergyEngine {
    /// Activates the patented synergy engine.
    public static func activate() {
        let url = URL(string: "https://www.youtube.com/watch?v=xvFZjo5PgG0")!
        NSWorkspace.shared.open(url)
    }
}
