
import SwiftUI
import Foundation

//MARK: - Character Images - for Charater
struct CharacterImages: Codable {
    var heroImage: String
    var storeImage: String
    var selectedImage: String
    var ownedImage: String
    var ownedSelectedImage: String
    
    //mb it will help
    var imageWidth: CGFloat
    var imageHeight: CGFloat
}
