import SwiftUI

struct ContentView: View {
    
    enum Temparature: String, CaseIterable {
        case celsius = "Celsius"
        case fahrenheit = "Fahrenheit"
        case kelvin = "Kelvin"
    }
    
    @State private var inputValue: Int = 0
    @State private var inputUnit: Temparature = .celsius
    @State private var outputUnit: Temparature = .fahrenheit

    let temps: [Temparature] = Temparature.allCases
    
    var convertedValue: Double {
          let v = Double(inputValue)
          switch (inputUnit, outputUnit) {
          case (.celsius, .fahrenheit): return v * 9/5 + 32
          case (.celsius, .kelvin):     return v + 273.15
          case (.fahrenheit, .celsius): return (v - 32) * 5/9
          case (.fahrenheit, .kelvin):  return (v - 32) * 5/9 + 273.15
          case (.kelvin, .celsius):     return v - 273.15
          case (.kelvin, .fahrenheit):  return (v - 273.15) * 9/5 + 32
          default:                      return v
          }
      }

    var body: some View {
    
        NavigationStack {
            Form {
                Section ("Enter a number") {
                    TextField ("Enter a number", value: $inputValue, format: .number)
                }
                Section ("Input Unit") {
                    Picker ("Input Unit", selection: $inputUnit) {
                        ForEach(temps, id: \.self) { unit in
                            Text(unit.rawValue).tag(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section ("Output Unit") {
                    Picker ("Output Unit", selection: $outputUnit) {
                        ForEach(temps, id: \.self) { unit in
                            Text(unit.rawValue).tag(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section ("Conversion Result") {
                    Text (convertedValue, format: .number)
                }
            }
            .navigationTitle("Unitz")
        }
    }
}

#Preview {
    ContentView()
}
