import SwiftUI

struct SettingsView: View {
    @Binding var logFrequency: Double

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Log Frequency")) {
                    Stepper(value: $logFrequency, in: 1...10, step: 1) {
                        Text("\(Int(logFrequency)) seconds")
                    }
                }
            }
            .navigationBarTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(logFrequency: .constant(3))
    }
}
