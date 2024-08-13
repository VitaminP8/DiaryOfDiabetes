import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var todaysDate: TodaysDate
    
    var body: some View {
        NavigationView {
            VStack(spacing: 1) {
                MonthScrollerView()
                    .environmentObject(todaysDate)
                    .padding()
                dayOfWeekStack
                calendarGrid
            }
        }
    }
    
    var dayOfWeekStack: some View {
        HStack(spacing: 1) {
            Text("Mon").dayOfWeek()
            Text("Tue").dayOfWeek()
            Text("Wed").dayOfWeek()
            Text("Thu").dayOfWeek()
            Text("Fri").dayOfWeek()
            Text("Sat").dayOfWeek()
            Text("Sun").dayOfWeek()
        }
    }
    
    var calendarGrid: some View {
        VStack(spacing: 1) {
            let daysInMonth = CalendarInfo().daysInMonth(todaysDate.date)
            let firstDayOfMonth = CalendarInfo().firstOfMonth(todaysDate.date)
            let startingSpaces = CalendarInfo().weekDay(firstDayOfMonth)
            let prevMonth = CalendarInfo().minusMonth(todaysDate.date)
            let daysInPrevMonth = CalendarInfo().daysInMonth(prevMonth)
            let month = CalendarInfo().Month(todaysDate.date)
            let year = CalendarInfo().Year(todaysDate.date)
            
            ForEach(0..<6) { row in
                HStack(spacing: 1){
                    ForEach(1..<8) { column in
                        let count = column + row * 7
                        CalendarPageView(count: count, month: month, year: year, startingSpaces: startingSpaces, daysInMonth: daysInMonth, daysInPrevMonth: daysInPrevMonth)
                            .environmentObject(todaysDate)
                    }
                }
            }
        }
        .frame(maxHeight: .infinity)
    }
}

//#Preview {
//    ContentView()
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let todaysDate = TodaysDate()
        ContentView()
            .environmentObject(todaysDate)
    }
}
//расширение для добавления нового функционала
extension Text {
    func dayOfWeek() -> some View {
        self.frame(maxWidth: .infinity)
            .padding(.top, 1)
            .lineLimit(1)
    }
}
