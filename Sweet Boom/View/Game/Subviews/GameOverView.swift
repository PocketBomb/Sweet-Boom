
import SwiftUI

//MARK: - Game Over View shows when contact registred with 2 knifes
struct GameOverView: View {
    var currentLevel: Int
    var scores: Int
    var onContinue: () -> Void
    var onSkip: () -> Void

    var body: some View {
        ZStack {
            Image("gameOverView")
                .resizable()
                .scaledToFit()
                .frame(width: 286, height: 412)
            
            VStack {
                Spacer()
                
                VStack(alignment: .center, spacing: -15) {
                    Text("\(scores)")
                        .font(.custom("Acme-Regular", size: 71))
                        .foregroundColor(.white)
                        .shadow(
                            color: Color(red: 120/255, green: 0/255, blue: 68/255), /// shadow color
                                radius: 0, /// shadow radius
                                x: 0, /// x offset
                                y: 5 /// y offset
                            )
                    Text("LEVEL \(currentLevel)")
                        .font(.custom("Acme-Regular", size: 27))
                        .foregroundColor(.white)
                        .shadow(
                            color: Color(red: 120/255, green: 0/255, blue: 68/255), /// shadow color
                                radius: 0, /// shadow radius
                                x: 0, /// x offset
                                y: 5 /// y offset
                            )
                }
                .padding(.top, 110)
                
                VStack(alignment: .center, spacing: 6) {
                    Button {
                        onContinue()
                    } label: {
                        Image("continueButton")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 180, height: 40)
                    }

                    Button {
                        onSkip()
                    } label: {
                        Image("skipButton")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 23)
                    }
                }
                .padding(.bottom, 45)

            }
        }
    }
}
