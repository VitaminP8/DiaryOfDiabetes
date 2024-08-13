import SwiftUI

struct CalendarPageView: View {
    
    @EnvironmentObject var todaysDate: TodaysDate
    let count: Int
    let month: Int
    let year: Int
    let startingSpaces: Int
    let daysInMonth: Int
    let daysInPrevMonth: Int
    
    var body: some View {
        if (monthStruct().monthType == .Current) {
            NavigationLink(destination: DiaryView (day: monthStruct().dayInt, month: month, year: year)) {
                VStack {
                    Text(monthStruct().day())
                        .foregroundColor(textColor(type: monthStruct().monthType))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .environmentObject(todaysDate)
            .buttonStyle(PlainButtonStyle())
        }
        else {
            VStack {
                Text(monthStruct().day())
                    .foregroundColor(textColor(type: monthStruct().monthType))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }

    
    func textColor(type: MonthType) -> Color {
        return type == MonthType.Current ? Color.black : Color.gray
    }
    
    func monthStruct() -> MonthStruct {
        let start = startingSpaces == 0 ? startingSpaces + 7 : startingSpaces
        if (count <= start) {
            let day = daysInPrevMonth + count - start
            return MonthStruct(monthType: MonthType.Previous, dayInt: day)
        }
        else if (count - start > daysInMonth) {
            let day = count - start - daysInMonth
            return MonthStruct(monthType: MonthType.Next, dayInt: day)
        }
        let day = count - start
        return MonthStruct(monthType: MonthType.Current, dayInt: day)
    }
}

#Preview {
    CalendarPageView(count: 1, month: 1, year: 2024, startingSpaces: 1, daysInMonth: 30, daysInPrevMonth: 31)
        .environmentObject(TodaysDate())
}
