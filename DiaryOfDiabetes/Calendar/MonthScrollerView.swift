import SwiftUI

struct MonthScrollerView: View {
    
    @EnvironmentObject var todaysDate: TodaysDate
    
    var body: some View {
        HStack{
            Spacer()
            Button(action: previousMonth){
                Image(systemName: "arrow.left")
                    .imageScale(.large)
                    .font(.title.weight(.bold))
                    .foregroundColor(.black)
            }
            Text(CalendarInfo().monthYearString(todaysDate.date))
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity)
            Button(action: nextMonth){
                Image(systemName: "arrow.right")
                    .imageScale(.large)
                    .font(.title.weight(.bold))
                    .foregroundColor(.black)
            }
            Spacer()
        }
    }
    
    func previousMonth(){
        todaysDate.date = CalendarInfo().minusMonth(todaysDate.date)
    }
    
    func nextMonth() {
        todaysDate.date = CalendarInfo().plusMonth(todaysDate.date)
    }
}

#Preview {
    MonthScrollerView()
}
