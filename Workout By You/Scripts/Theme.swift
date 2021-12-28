import Foundation
import SwiftUI

// All available color themes (specific colors are in the assets file)
enum Theme: String, CaseIterable, Identifiable, Codable {
    case BubbleGum
    case Lavender
    case Lemon
    case Maroon
    case Navy
    case Orange
    case Poppy
    case Purple
    case Seafoam
    case Sky
    case Slime
    case TreeBark
    
    // Returns the accent color for the theme (usually for text)
    var accentColor: Color {
        switch self {
        case .BubbleGum, .Lavender, .Orange, .Poppy, .Seafoam, .Sky, .Lemon, .Slime: return .black
        case .Maroon, .Navy, .Purple, .TreeBark: return .white
        }
    }
    
    // Returns the themes main color
    var mainColor: Color {
        Color(rawValue)
    }
    
    // Returns the name of the theme
    var name: String {
        rawValue.capitalized
    }
    
    // Returns the id for each theme
    var id: String {
        name
    }
}
