import SwiftUI

struct WeatherView: View {
    @StateObject var viewModel = WeatherViewModel()
    @State private var city: String = ""

    var body: some View {
        ZStack {
            // 📌 Arka Plan Resmi
            Image("backgr")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all) // Tam ekran yap
            
            VStack {
                TextField("Şehir Adı", text: $city)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onSubmit {
                        viewModel.fetchWeather(for: city)
                    }
                
                Button("Hava Durumunu Getir") {
                    viewModel.fetchWeather(for: city)
                }
                .padding()
                .background(Color.blue.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(10)

                if !viewModel.temperature.isEmpty {
                    Text("🌡 Sıcaklık: \(viewModel.temperature)")
                        .font(.largeTitle)
                        .padding()
                        .background(Color.white.opacity(0.3)) // Yazıları okunur yapmak için

                    Text("🌤 Açıklama: \(viewModel.description)")
                        .font(.title2)
                        .padding()
                        .background(Color.white.opacity(0.3))
                }
            }
            .padding()
        }
    }
}
