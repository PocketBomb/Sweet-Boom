
import SwiftUI

//MARK: - Shop View
struct CharacterShopView: View {
    @StateObject private var store = CharacterShopViewModel()
    @State var backPressed = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            //back
            Image("shopBackImage")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    
                    // Label Image
                    Image("shopLabelImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 151, height: 95)
                        .padding(.top, 150)
                    
                    //MARK: - character image
                    VStack(alignment: .center, spacing: -40) {
                        let selectedCharacter = store.characters[store.selectedCharacterId]
                        Image(selectedCharacter.images.heroImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 228, height: 228)
                        
                        //MARK: - Button
                        Button(action: {
                            if selectedCharacter.isOwned {
                                store.chooseCharacter(id: store.selectedCharacterId)
                            } else {
                                store.buyCharacter(id: store.selectedCharacterId)
                            }
                        }) {
                            ZStack {
                                Image(store.getButtonText(for: selectedCharacter))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 134, height: 50)
                                
                                //MARK: - not owned
                                if store.getButtonText(for: selectedCharacter).contains("buyButton") {
                                    HStack(alignment: .center, spacing: 5) {
                                        Spacer()
                                        CustomStrokeText(text: "\(selectedCharacter.price)", width: 2, color: Color(red: 120/255, green: 0/255, blue: 68/255))
                                            .foregroundStyle(.white)
                                            .font(.custom("Acme-Regular", size: 27))
                                            .padding(.bottom, 5)
                                        Image("coinImage")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 38, height: 38)
                                        Spacer()
                                    }
                                   
                                }
                            }
                        }
                    }
                    .padding(.top, 20)
                    
                    //MARK: - characters
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ForEach(store.characters.indices, id: \.self) { index in
                            let character = store.characters[index]
                            Button(action: {
                                store.selectCharacter(id: index)
                            }) {
                                //MARK: - is it owned?
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
                                //MARK: - is it selected?
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
                //Button --> MainView
                Button {
                    print("back Pressed")
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image("backButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 61, height: 50)
                }
                .frame(width: 61, height: 50)
                .padding(.leading, 16)
                
                Spacer()
                
                //MARK: - CoinView
                CoinsView()
                    .frame(width: 134, height: 53)
                    .padding(.trailing, 16)
            }
            .position(x: UIScreen.main.bounds.width / 2 ,y: 116)
        }
        .navigationBarBackButtonHidden(true)
    }
}
