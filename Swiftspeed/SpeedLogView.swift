import SwiftUI

struct SpeedLogView: View {
    @Environment(\.presentationMode) var presentationMode
    let speedLogs: [(Date, Double)]
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()
    let onResetLogs: () -> Void

    var body: some View {
        NavigationView {
            List(speedLogs.indices, id: \.self) { index in
                let (timestamp, speed) = speedLogs[index]
                HStack {
                    VStack(alignment: .leading) {
                        Text(String(format: "%.1f mph", speed))
                            .font(.headline)
                        Text(dateFormatter.string(from: timestamp))
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
            }
            .navigationBarTitle("Speed Logs")
            .navigationBarItems(leading: Button("Reset Logs", action: onResetLogs), trailing: Button("Done", action: {
                presentationMode.wrappedValue.dismiss()
            }))
        }
    }
}

struct SpeedLogView_Previews: PreviewProvider {
    static var previews: some View {
        SpeedLogView(speedLogs: [(Date(), 35.0), (Date().addingTimeInterval(3), 45.6), (Date().addingTimeInterval(6), 52.3)], onResetLogs: {})
    }
}
