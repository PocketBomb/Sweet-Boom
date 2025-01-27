
import SwiftUI

//MARK: - CoinsView locate on All Screens of app and show total
//count of coins of user
struct CoinsView: View {
    
    @StateObject private var coinsManager = CoinsManager.shared
    
    var body: some View {
        ZStack {
            Image("coinsViewImage")
                .resizable()
                .scaledToFit()
                .frame(width: 134, height: 53, alignment: .center)
            
            GeometryReader { geometry in
                let coinImageWidth: CGFloat = 53
                let coinViewWidth: CGFloat = 134
                let textWidth: CGFloat = 81
                
                let textOffsetX = (coinViewWidth - coinImageWidth - textWidth) / 2 + coinImageWidth
                
                HStack(spacing: 0) {
                    Image("coinImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: coinImageWidth, height: 53)
                        .padding(.leading, -7)
                    
                    Text("\(coinsManager.currentCoins)")
                        .font(.custom("Acme-Regular", fixedSize: 40))
                        .foregroundColor(.white)
                        .frame(width: textWidth, height: 53)
                        .offset(x: textOffsetX - coinImageWidth - 10)
                        .padding(.top, -1)
                        .padding(.leading, 3)
                }
                .frame(width: coinViewWidth, height: 53, alignment: .leading)
            }
            .frame(width: 134, height: 53) // size
        }
    }
}

