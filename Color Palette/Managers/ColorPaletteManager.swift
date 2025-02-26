//
//  ColorPaletteManager.swift
//  Color Palette
//
//  Created by mac on 25/02/2025.
//

import Foundation

class ColorPaletteManager {
    static let shared = ColorPaletteManager() // Singleton instance
    private var palettes: [String:[ColorPalette]] = [:]

    private init() {
        loadPalettes()
    }

    // Load color palettes from a JSON file in the app bundle
    private func loadPalettes() {
        guard let url = Bundle.main.url(forResource: "palettes", withExtension: "json") else {
            print("JSON file not found")
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let decodedData = try JSONDecoder().decode(ColorPalettesData.self, from: data)
            self.palettes = decodedData.palettes
        } catch {
            print("Failed to load JSON: \(error.localizedDescription)")
        }
    }

 //    Get all palettes
    func getAllPalettes() ->[String: [ColorPalette]] {
        return palettes
    }
    func getPalettes(forCategory category: String) -> [ColorPalette] {
           return palettes[category] ?? [] // Returns palettes if found, else empty array
       }
}
