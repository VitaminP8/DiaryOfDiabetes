import SwiftUI

@main
struct DiaryOfDiabetesApp: App {
    var body: some Scene {
        WindowGroup {
            let todaysDate = TodaysDate()
            ContentView()
                .environmentObject(todaysDate)
        }
    }
}
