//
//  SlectedPaletteInExploreVC.swift
//  Color Palette
//
//  Created by mac on 14/03/2025.
//

import UIKit

class SlectedPaletteInExploreVC: UIViewController, UITabBarDelegate {
    @IBOutlet weak var save: UITabBarItem!
    @IBOutlet weak var adjust: UITabBarItem!
    @IBOutlet weak var delete: UITabBarItem!
    @IBOutlet weak var download: UITabBarItem!
    @IBOutlet weak var tabBar: UITabBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.delegate = self  // Set the delegate
    }

    // Delegate method to handle tab selection
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == save {
            saveButtonTapped()
        } else if item == adjust {
            adjustButtonTapped()
        } else if item == delete {
            deleteButtonTapped()
        }
    else if item == download {
        downloadButtonTapped()
    }
    }

    // Custom actions for each "button"
    func saveButtonTapped() {
        print("Home tab tapped!")
        // Add your logic here (e.g., navigate, update UI)
    }

    func adjustButtonTapped() {
        print("Profile tab tapped!")
        // Add your logic here
    }

    func deleteButtonTapped() {
        print("Settings tab tapped!")
        // Add your logic here
    }
    func downloadButtonTapped() {
        print("Settings tab tapped!")
        // Add your logic here
    }
}
