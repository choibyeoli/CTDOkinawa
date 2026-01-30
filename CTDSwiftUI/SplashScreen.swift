

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack{
            //RadialGradient(gradient: Gradient(colors:[Color.blue,Color.green,Color.purple]), center: .center, startRadius: 210, endRadius: 30)
            //LinearGradient(gradient: Gradient(colors: [.blue, .white, .pink]), startPoint: .topLeading, endPoint: .bottomTrailing)
            //AngularGradient(gradient: Gradient(colors: [.blue,.indigo,.purple,.blue]), center: .center)
            LinearGradient(gradient: Gradient(colors:[Color(hex: "#87CEEB"), Color(hex:"6BB2CF"),Color(hex: "#003366")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack{
                Text("CTD")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.black)
            }
            
            
        }
    }
}

#Preview {
    ContentView()
}
