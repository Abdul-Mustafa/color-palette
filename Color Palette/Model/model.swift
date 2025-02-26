//
//import Foundation
//
//// Define the model for a color palette
//struct ColorPalette: Codable {
//    let type: String
//    let name: String
//    let colors: [String]
//}
//
//// Define the model for the entire data structure
//struct ColorPalettesData: Codable {
//    let palettes: [ColorPalette]
//}
//

import Foundation

// Model for an individual color palette
struct ColorPalette: Codable {
    let name: String
    let colors: [String]
}

// Model for the entire color palettes collection
struct ColorPalettesData: Codable {
    let palettes: [String: [ColorPalette]]
}
