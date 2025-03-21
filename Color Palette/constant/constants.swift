//
//  constants.swift
//  Color Palette
//
//  Created by mac on 21/03/2025.
//

import Foundation
import UIKit
import StoreKit

let appDelegate  = UIApplication.shared.delegate as! AppDelegate
let privacyPolicyLink = "https://sites.google.com/view/myapps-tech/privacy-policy"
let termsOfUsesLink = "https://sites.google.com/view/myapps-tech/terms-of-use"
let appId = ""
let weeklySub = "com.aiVideo.weekly"
let monthlySub = "com.aiVideo.monthly"
let yearlySub = "com.aiVideo.yearly"
let lifeTimeProduct = ""
let IS_LIFETIME_USER = "LIFETIME_USERSS"
let IS_SUBSCRIBED_USER = "SUBSCRIBED_USERSS"
let userDefaults = UserDefaults.standard


extension NSNotification.Name{
    static let  loadProduct = Notification.Name("loadProduct")
    static let  purchaseCheck = Notification.Name("purchaseCheck")
}

func isPremiumUser()->Bool {
    if userDefaults.bool(forKey: IS_LIFETIME_USER) == true {
        return true
    }
    if userDefaults.bool(forKey: IS_SUBSCRIBED_USER) == true {
        return true
    }
    return false
}
