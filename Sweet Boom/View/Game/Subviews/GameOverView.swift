
import SwiftUI

struct GameOverView: View {
    var body: some View {
        ZStack {
            Image("gameOverView")
                .resizable()
                .scaledToFit()
                .frame(width: 313, height: 240)
            VStack(alignment: .center, spacing: 8) {
                Button {
                    print("continue pressed")
                } label: {
                    Image("continueButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 237, height: 55)
                }

                Button {
                    print("skip pressed")
                } label: {
                    Image("skipButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 46, height: 31)
                }
            }
            .padding(.top, 70)
        }
    }
}
