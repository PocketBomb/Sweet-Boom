
import SwiftUI

//MARK: - Chatacter information
struct Character: Identifiable, Codable {
    var id: Int
    var name: String
    var price: Int
    var images: CharacterImages
    var isOwned: Bool
    var isSelected: Bool
    var isChoosen: Bool
}
