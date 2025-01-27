
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
                CustomStrokeText(text: "\(LevelManeger.shared.maxScore)", width: 1.5, color: Color(red: 1.0, green: 0.463, blue: 0.761))
                    .font(.custom("Acme-Regular", size: 30))
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.bottom, 5)
            }
            .frame(width: 180, height: 73)
        }
        .frame(width: 180, height: 73)
    }
}

//MARK: - Highest Level record
struct HighestLevelView: View {
    var body: some View {
        ZStack {
            Image("hightestLevelView")
                .resizable()
                .scaledToFit()
                .frame(width: 180, height: 73)
            VStack {
                Spacer()
                CustomStrokeText(text: "\(LevelManeger.shared.maxLevel)", width: 1.5, color: Color(red: 1.0, green: 0.463, blue: 0.761))
                    .font(.custom("Acme-Regular", size: 30))
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.bottom, 5)
            }
            .frame(width: 180, height: 73)
        }
        .frame(width: 180, height: 73)
    }
}
