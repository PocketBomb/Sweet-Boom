import SwiftUI

struct CoinsView: View {
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
                
                // Рассчитаем отступ текста, чтобы он оказался по центру
                let textOffsetX = (coinViewWidth - coinImageWidth - textWidth) / 2 + coinImageWidth
                
                HStack(spacing: 0) {
                    Image("coinImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: coinImageWidth, height: 53)
                        .padding(.leading, -7)
                    
                    Text("9999")
                        .font(.custom("Funkydori", fixedSize: 40))
                        .foregroundColor(.white)
                        .frame(width: textWidth, height: 53)
                        .offset(x: textOffsetX - coinImageWidth-10)
                        .padding(.top, 7)
                        .padding(.leading, 3)
                }
                .frame(width: coinViewWidth, height: 53, alignment: .leading)
            }
            .frame(width: 134, height: 53) // Размер контейнера
        }
    }
}

