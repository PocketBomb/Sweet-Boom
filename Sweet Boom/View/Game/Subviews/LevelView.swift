
import SwiftUI

// MARK: - LevelView
struct LevelView: View {
    @Binding var currentLevel: Int
    let totalLevels = 5
    
    var body: some View {
        VStack(spacing: 3) {
            StrokeText(text: currentLevel % 5 == 0 ? "Special level" :"Level \(currentLevel)", width: 2, color: Color(red: 1.0, green: 0.463, blue: 0.761))
                .font(.custom("Acme-Regular", size: 46))
                .foregroundColor(.white) //text color
            HStack(spacing: 12) {
                ForEach(0..<totalLevels, id: \.self) { index in
                    Image(levelImage(for: index))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .foregroundColor(levelColor(for: index))
                }
            }
        }
        .position(x: UIScreen.main.bounds.width / 2, y: ScreenData.shared.isSmallScreen ? 120 : 170) // Располагаем по центру с отступом от верхней части
    }
    
    // Метод для выбора изображения в зависимости от уровня
    private func levelImage(for index: Int) -> String {
        if (index+1) < currentLevel % 5 {
            return "levelCompletedImage" // Уровень пройден
        } else if (index+1) % 5 == 0 && (index+1) >= 5 {
            return "bossLevelImage" // boss
        } else {
            return "baseLevelImage" // Уровень не пройден
        }
    }
    
    // Метод для выбора цвета для уровня
    private func levelColor(for index: Int) -> Color {
        if index < currentLevel % 5 {
            return .green // Пройденный уровень
        } else if index == currentLevel % 5 {
            return .yellow // Текущий уровень
        } else {
            return .gray // Не пройденный уровень
        }
    }
}

