import SwiftUI

struct ContentView: View {
    let people = ["John", "Paul", "George", "Ringo"]
    var body: some View {
        List (people, id: \.self) {
            Text ($0)
        }
    }
    func testBundles() {
        guard let fileURL = Bundle.main.url(forResource: "test", withExtension: "txt") else {
            return
        }
        guard let fileContents = try? String(contentsOf: fileURL) else {
            return
        }
        print(fileContents)
    }
    func testStrings() {
        var input = "a b c"
        var letters = input.components(separatedBy: " ")
        var lowerCased = input.lowercased()
        
        input = """
                    a
                    b
                    c
                    """
        letters = input.components(separatedBy: "\n")
        let letter = letters.randomElement()
        let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let word = "swift"
        let checker = UITextChecker()
        
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        let allGood = misspelledRange.location == NSNotFound
        
    }
}
#Preview {
    ContentView()
}
