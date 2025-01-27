
import SwiftUI

//MARK: - Score record
struct ScoreRecordView: View {
    var body: some View {
        ZStack {
            Image("scoreRecordView")
                .resizable()
                .scaledToFit()
                .frame(width: 180, height: 73)
            VStack {
                Spacer()
                Text("\(LevelManeger.shared.maxScore)")
                    .font(.custom("Acme-Regular", size: 30))
                    .foregroundColor(.white)
                    .padding(.bottom, 5)
            }
            .frame(width: 180, height: 73)
        }
        .frame(width: 180, height: 73)
    }
}

//MARK: - Score record
struct HighestLevelView: View {
    var body: some View {
        ZStack {
            Image("hightestLevelView")
                .resizable()
                .scaledToFit()
                .frame(width: 180, height: 73)
            VStack {
                Spacer()
                Text("\(LevelManeger.shared.maxLevel)")
                    .font(.custom("Acme-Regular", size: 30))
                    .foregroundColor(.white)
                    .padding(.bottom, 5) 
            }
            .frame(width: 180, height: 73)
        }
        .frame(width: 180, height: 73)
    }
}
