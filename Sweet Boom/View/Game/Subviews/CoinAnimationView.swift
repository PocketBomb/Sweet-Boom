
import SwiftUI

//MARK: - Adding coin animation(if User win)
struct CoinAnimationView: View {
    @State private var position: CGPoint
    @State private var opacity: Double = 1.0
    let coinImage: String = "coinImage"

    init(startingPosition: CGPoint) {
        _position = State(initialValue: startingPosition)
    }

    var body: some View {
        HStack(alignment: .center,spacing: 3) {
            Text("+5")
                .font(.custom("Acme-Regular", size: 20))
                .foregroundColor(.white) //text color
            Image(coinImage)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
        }
        .position(position)
        .opacity(opacity)
        .onAppear {
            animateCoin()
        }
    }

    private func animateCoin() {
        withAnimation(Animation.easeOut(duration: 2.0)) {
            position.y -= 50 //animate down
            opacity = 0.0 //smooth disappearance
        }
    }
}

