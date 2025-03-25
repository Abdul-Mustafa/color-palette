import Foundation

enum UserLimitsManager {
    private static let cameraUsageCountKey = "cameraUsageCount"
    private static let imageUploadCountKey = "imageUploadCount"
    private static let downloadCountKey = "downloadCount"
    private static let adjustmentCountKey = "adjustmentCount"
    
    private static let maxCameraUsages = 2
    private static let maxImageUploads = 2
    private static let maxDownloads = 2
    private static let maxAdjustments = 2
    
    static func canUseCamera() -> Bool {
        UserDefaults.standard.integer(forKey: cameraUsageCountKey) < maxCameraUsages || isPremiumUser()
    }
    
    static func incrementCameraUsage() {
        let newCount = UserDefaults.standard.integer(forKey: cameraUsageCountKey) + 1
        UserDefaults.standard.set(newCount, forKey: cameraUsageCountKey)
    }
    
    static func getCameraUsageCount() -> Int {
        UserDefaults.standard.integer(forKey: cameraUsageCountKey)
    }
    
    static func canUploadImage() -> Bool {
        UserDefaults.standard.integer(forKey: imageUploadCountKey) < maxImageUploads || isPremiumUser()
    }
    
    static func incrementImageUpload() {
        let newCount = UserDefaults.standard.integer(forKey: imageUploadCountKey) + 1
        UserDefaults.standard.set(newCount, forKey: imageUploadCountKey)
    }
    
    static func getImageUploadCount() -> Int {
        UserDefaults.standard.integer(forKey: imageUploadCountKey)
    }
    
    static func canDownloadPalette() -> Bool {
        UserDefaults.standard.integer(forKey: downloadCountKey) < maxDownloads || isPremiumUser()
    }
    
    static func incrementDownloadCount() {
        let newCount = UserDefaults.standard.integer(forKey: downloadCountKey) + 1
        UserDefaults.standard.set(newCount, forKey: downloadCountKey)
    }
    
    static func getDownloadCount() -> Int {
        UserDefaults.standard.integer(forKey: downloadCountKey)
    }
    
    static func canAdjustPalette() -> Bool {
        UserDefaults.standard.integer(forKey: adjustmentCountKey) < maxAdjustments || isPremiumUser()
    }
    
    static func incrementAdjustmentCount() {
        let newCount = UserDefaults.standard.integer(forKey: adjustmentCountKey) + 1
        UserDefaults.standard.set(newCount, forKey: adjustmentCountKey)
    }
    
    static func getAdjustmentCount() -> Int {
        UserDefaults.standard.integer(forKey: adjustmentCountKey)
    }
    
    static func limitReachedMessage(for type: LimitType) -> String {
        switch type {
        case .cameraUsage:
            return "Free users can only use the camera \(maxCameraUsages) times to extract palettes. Upgrade to Premium!"
        case .imageUpload:
            return "Free users can only upload \(maxImageUploads) images to extract palettes. Upgrade to Premium!"
        case .download:
            return "Free users can only copy palettes \(maxDownloads) times. Upgrade to Premium!"
        case .adjustment:
            return "Free users can only adjust palettes \(maxAdjustments) times. Upgrade to Premium!"
        }
    }
}

enum LimitType {
    case cameraUsage, imageUpload, download, adjustment
}
