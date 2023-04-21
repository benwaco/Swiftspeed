import SwiftUI
import CoreLocation

struct ContentView: View {
    @State private var currentSpeed: CLLocationSpeed = 0.0
    @State private var topSpeed: CLLocationSpeed = 0.0
    @State private var speedLogs: [(Date, Double)] = []
    @State private var logFrequency: Double = UserDefaults.standard.double(forKey: "logFrequency") != 0 ? UserDefaults.standard.double(forKey: "logFrequency") : 3
    @ObservedObject var locationManager = LocationManager()
    
    var body: some View {
        VStack {
            Text("Speedometer")
                .font(.headline)
                .padding()

            Text(String(format: "%.1f mph", currentSpeed))
                .font(.system(size: 30))
                .padding()

            Text("Top Speed: \(String(format: "%.1f mph", topSpeed))")
                .font(.caption)
                .padding()
        }
        .onReceive(locationManager.speedPublisher) { speed in
            if speed >= 0 {
                let speedInMph = speed * 2.23694 // Convert m/s to mph
                currentSpeed = speedInMph
                topSpeed = max(topSpeed, speedInMph)
            }
        }
        .onReceive(Timer.publish(every: logFrequency, on: .main, in: .common).autoconnect()) { _ in
            speedLogs.append((Date(), currentSpeed))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
