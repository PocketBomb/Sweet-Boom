import SwiftUI

struct CharacterShopView: View {
    @StateObject private var store = CharacterStore()
    @State var backPressed = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            Image("shopBackgroundImage")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
//            VStack {
//                
//            }
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    
                    // Label Image
                    Image("shopLabelImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 151, height: 95)
                        .padding(.top, 150)
                    
                    // Изображение выбранного персонажа и кнопка
                    VStack(alignment: .center, spacing: -40) {
                        let selectedCharacter = store.characters[store.selectedCharacterId]
                        Image(selectedCharacter.images.heroImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 228, height: 228)
                        
                        // Кнопка для выбора/покупки персонажа
                        Button(action: {
                            if selectedCharacter.isOwned {
                                store.chooseCharacter(id: store.selectedCharacterId)
                            } else {
                                store.buyCharacter(id: store.selectedCharacterId)
                            }
                        }) {
                            Image(store.getButtonText(for: selectedCharacter))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 134, height: 50)
                        }
                    }
                    .padding(.top, 20)
                    
                    // Ячейки с персонажами
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ForEach(store.characters.indices, id: \.self) { index in
                            let character = store.characters[index]
                            Button(action: {
                                store.selectCharacter(id: index)
                            }) {
                                if character.isOwned {
                                    if character.isSelected {
                                        Image(character.images.ownedSelectedImage)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 161, height: 145)
                                    } else {
                                        Image(character.images.ownedImage)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 161, height: 145)
                                    }
                                } else {
                                    if character.isSelected {
                                        Image(character.images.selectedImage)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 161, height: 145)
                                    } else {
                                        Image(character.images.storeImage)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 161, height: 145)
                                    }
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        Spacer(minLength: 40)
                    }
                    .padding(.top, 16)
                }
                .padding()
            }
            
            HStack {
                Button {
                    print("back Pressed")
//                            backPressed.toggle()
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image("backButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 61, height: 50)
                }
                .frame(width: 61, height: 50)
//                .padding(.top, 44 + 50/2)
                .padding(.leading, 16)
                
                Spacer()
                
                CoinsView()
                    .frame(width: 134, height: 53)
//                    .padding(.top, 44 + 53 / 2)
                    .padding(.trailing, 16)
            }
            .position(x: UIScreen.main.bounds.width / 2 ,y: 116)
        }
        .navigationBarBackButtonHidden(true)
    }
}
