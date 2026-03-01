import SwiftUI

enum Move: String, CaseIterable {
    case rock = "Rock"
    case paper = "Paper"
    case scissors = "Scissors"

    var emoji: String {
        switch self {
        case .rock: return "🪨"
        case .paper: return "📄"
        case .scissors: return "✂️"
        }
    }

    var winningMove: Move {
        switch self {
        case .rock: return .paper
        case .paper: return .scissors
        case .scissors: return .rock
        }
    }
    
    var losingMove: Move {
        switch self {
        case .rock: return .scissors
        case .paper: return .rock
        case .scissors: return .paper
        }
    }
}

enum GameMode: String, CaseIterable {
    case win = "Win"
    case lose = "Lose"
}

struct ContentView: View {
    @State private var appMove = Move.allCases.randomElement()!
    @State private var appMode = GameMode.allCases.randomElement()!    
    @State private var userScore = 0

    func checkAnswer(_ userMove: Move) {
        let correctAnswer: Move
        
        if appMode == .win {
            correctAnswer = appMove.winningMove
        } else {
            correctAnswer = appMove.losingMove
        }
        
        if userMove == correctAnswer {
            userScore += 1
        } else {
            userScore -= 1
        }
        
        appMove = Move.allCases.randomElement()!
        appMode = GameMode.allCases.randomElement()!
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Score Header
                Text("Score: \(userScore)")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                
                Spacer()
                
                // App's Move Section
                VStack(spacing: 20) {
                    Text("App played")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                        .textCase(.uppercase)
                    
                    Text(appMove.emoji)
                        .font(.system(size: 100))
                        .shadow(color: .black.opacity(0.1), radius: 10, y: 5)
                    
                    Text(appMove.rawValue)
                        .font(.title.bold())
                }
                
                Spacer()
                
                // Objective Section
                HStack(spacing: 8) {
                    Text("You must")
                        .font(.title3)
                    Text(appMode.rawValue.uppercased())
                        .font(.title3.bold())
                        .foregroundStyle(appMode == .win ? .green : .red)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(.ultraThinMaterial)
                .clipShape(Capsule())
                .shadow(color: .black.opacity(0.05), radius: 8, y: 4)
                
                Spacer()
                
                // User Action Section
                HStack(spacing: 15) {
                    ForEach(Move.allCases, id: \.self) { move in
                        Button {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                checkAnswer(move)
                            }
                        } label: {
                            VStack(spacing: 12) {
                                Text(move.emoji)
                                    .font(.system(size: 40))
                                Text(move.rawValue)
                                    .font(.headline)
                                    .foregroundStyle(.primary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 24)
                            .background(.regularMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(color: .black.opacity(0.08), radius: 5, y: 4)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
            .navigationTitle("Brain Teaser")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
