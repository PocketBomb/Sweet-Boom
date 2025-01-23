
import SwiftUI

struct HighestLevelView: View {
    var body: some View {
        ZStack {
            Image("hightestLevelView")
                .resizable()
                .scaledToFit()
                .frame(width: 180, height: 73)
            VStack {
                Spacer() // Заполняет пространство сверху
                Text("5")
                    .font(.custom("Acme-Regular", size: 30))
                    .foregroundColor(.white)
                    .padding(.bottom, 5) // Отступ 5px от нижней границы
            }
            .frame(width: 180, height: 73)
        }
        .frame(width: 180, height: 73)
    }
}

