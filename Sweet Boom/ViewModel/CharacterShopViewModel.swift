import SwiftUI

//MARK: - Shop Data
class CharacterShopViewModel: ObservableObject {
    
    @Published var characters: [Character]
    @Published var selectedCharacterId: Int = 0
    @Published var choosenCharacterId: Int = 0
    let coinsManager = CoinsManager.shared
    
    private let charactersKey = "charactersKey"
    
    init() {
        if let savedData = UserDefaults.standard.data(forKey: charactersKey),
           let decodedCharacters = try? JSONDecoder().decode([Character].self, from: savedData) {
            self.characters = decodedCharacters
            self.selectedCharacterId = self.characters.first(where: { $0.isChoosen })?.id ?? 0
            self.choosenCharacterId = self.characters.first(where: { $0.isChoosen })?.id ?? 0
        } else {
            self.selectedCharacterId = 0
            self.choosenCharacterId = 0
            self.characters = [
                Character(id: 0, name: "Base Character", price: 0, images: CharacterImages(heroImage: "hero0Image", storeImage: "", selectedImage: "", ownedImage: "hero0Owned", ownedSelectedImage: "hero0OwnedSelected", imageWidth: 343, imageHeight: 343), isOwned: true, isSelected: true, isChoosen: true),
                Character(id: 1, name: "Character 2", price: 50, images: CharacterImages(heroImage: "hero1Image", storeImage: "hero1Store", selectedImage: "hero1Selected", ownedImage: "hero1Owned", ownedSelectedImage: "hero1OwnedSelected", imageWidth: 392, imageHeight: 392), isOwned: false, isSelected: false, isChoosen: false),
                Character(id: 2, name: "Character 3", price: 100, images: CharacterImages(heroImage: "hero2Image", storeImage: "hero2Store", selectedImage: "hero2Selected", ownedImage: "hero2Owned", ownedSelectedImage: "hero2OwnedSelected", imageWidth: 370, imageHeight: 370), isOwned: false, isSelected: false, isChoosen: false),
                Character(id: 3, name: "Character 4", price: 150, images: CharacterImages(heroImage: "hero3Image", storeImage: "hero3Store", selectedImage: "hero3Selected", ownedImage: "hero3Owned", ownedSelectedImage: "hero3OwnedSelected", imageWidth: 355, imageHeight: 354), isOwned: false, isSelected: false, isChoosen: false),
                Character(id: 4, name: "Character 5", price: 200, images: CharacterImages(heroImage: "hero4Image", storeImage: "hero4Store", selectedImage: "hero4Selected", ownedImage: "hero4Owned", ownedSelectedImage: "hero4OwnedSelected", imageWidth: 379, imageHeight: 379), isOwned: false, isSelected: false, isChoosen: false),
                Character(id: 5, name: "Character 6", price: 250, images: CharacterImages(heroImage: "hero5Image", storeImage: "hero5Store", selectedImage: "hero5Selected", ownedImage: "hero5Owned", ownedSelectedImage: "hero5OwnedSelected", imageWidth: 380, imageHeight: 379), isOwned: false, isSelected: false, isChoosen: false),
                Character(id: 6, name: "Character 7", price: 300, images: CharacterImages(heroImage: "hero6Image", storeImage: "hero6Store", selectedImage: "hero6Selected", ownedImage: "hero6Owned", ownedSelectedImage: "hero6OwnedSelected", imageWidth: 423, imageHeight: 422), isOwned: false, isSelected: false, isChoosen: false),
                Character(id: 7, name: "Character 8", price: 350, images: CharacterImages(heroImage: "hero7Image", storeImage: "hero7Store", selectedImage: "hero7Selected", ownedImage: "hero7Owned", ownedSelectedImage: "hero7OwnedSelected", imageWidth: 386, imageHeight: 386), isOwned: false, isSelected: false, isChoosen: false),
                Character(id: 8, name: "Character 9", price: 400, images: CharacterImages(heroImage: "hero8Image", storeImage: "hero8Store", selectedImage: "hero8Selected", ownedImage: "hero8Owned", ownedSelectedImage: "hero8OwnedSelected", imageWidth: 397, imageHeight: 396), isOwned: false, isSelected: false, isChoosen: false),
                Character(id: 9, name: "Character 10", price: 450, images: CharacterImages(heroImage: "hero9Image", storeImage: "hero9Store", selectedImage: "hero9Selected", ownedImage: "hero9Owned", ownedSelectedImage: "hero9OwnedSelected", imageWidth: 355, imageHeight: 355), isOwned: false, isSelected: false, isChoosen: false)
            ]
        }
    }
    
    func chooseCharacter(id: Int) {
        if id != choosenCharacterId {
            self.characters[choosenCharacterId].isChoosen = false
            self.choosenCharacterId = id
            self.characters[choosenCharacterId].isChoosen = true
            
            UserDefaults.standard.set(characters[choosenCharacterId].images.heroImage, forKey: "heroImage")
            saveCharacters()
        }
    }
    
    func selectCharacter(id: Int) {
        if id != selectedCharacterId {
            self.characters[selectedCharacterId].isSelected = false
            self.selectedCharacterId = id
            self.characters[selectedCharacterId].isSelected = true
        }
    }
    
    func buyCharacter(id: Int) {
        if !characters[id].isOwned && coinsManager.currentCoins >= characters[id].price{
            chooseCharacter(id: id)
            let _ = coinsManager.subtractCoins(characters[id].price)
            characters[id].isOwned = true
            saveCharacters()
        }
    }
    
    func getButtonText(for character: Character) -> String {
        if character.isOwned && character.isChoosen {
            return "usedButton"
        } else if character.isOwned {
            return "useButton"
        } else {
            if character.price > coinsManager.currentCoins {
                return "buyButton"+"NotEnough"
            } else {
                return "buyButton"
            }
        }
    }
    
    
    
    private func saveCharacters() {
        if let encodedData = try? JSONEncoder().encode(characters) {
            UserDefaults.standard.set(encodedData, forKey: charactersKey)
        }
    }
}
