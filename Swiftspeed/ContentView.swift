import SwiftUI
import CoreLocation

struct ContentView: View {
    @State private var currentSpeed: CLLocationSpeed = 0.0
    @State private var topSpeed: CLLocationSpeed = 0.0
    @State private var speedLogs: [(Date, Double)] = []
    @ObservedObject var locationManager = LocationManager()
    @State private var showSpeedLogs = false
    
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Speedometer")
                    .font(.largeTitle)
                    .padding()
                
                Text("\(currentSpeed, specifier: "%.1f") mph")
                    .font(.system(size: 60))
                    .padding()
                
                Text("Top Speed: \(topSpeed, specifier: "%.1f") mph")
                    .font(.headline)
                    .padding()
                
                HStack {
                    Button(action: {
                        topSpeed = 0.0
                    }) {
                        Text("Reset Top Speed")
                            .font(.headline)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        showSpeedLogs = true
                    }) {
                        Text("View Logs")
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }.sheet(isPresented: $showSpeedLogs) {
                        SpeedLogView(speedLogs: speedLogs, onResetLogs: {
                            speedLogs.removeAll()
                        })
                    }
                }
                Spacer()
            }
            .onReceive(locationManager.speedPublisher) { speed in
                let speedInMph = speed * 2.23694 // Convert m/s to mph
                currentSpeed = speedInMph
                topSpeed = max(topSpeed, speedInMph)
            }
            .onReceive(timer) { _ in
                speedLogs.append((Date(), currentSpeed))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
