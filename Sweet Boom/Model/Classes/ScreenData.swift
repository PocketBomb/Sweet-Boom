
import Foundation
import SwiftUI

final class ScreenData {
    static let shared = ScreenData()
    
    public var isSmallScreen: Bool {
        get {
            return UIScreen.main.bounds.height < 800
        }
    }
}
