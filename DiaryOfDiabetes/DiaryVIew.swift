import SwiftUI

struct DiaryView: View {
    
    @EnvironmentObject var todaysDate: TodaysDate
    
    @State private var dayModel: DayModel?
    let day: Int
    let month: Int
    let year: Int
    
    var body: some View {
        VStack {
            Text("Diary for \(day)/\(month)/\(year % 100)")
                .font(.title)
                .padding()
            
            if let dayModel {
                List {
                    HStack {
                        Text("Meal Type")
                            .frame(width: 100, alignment: .leading)
                        Spacer()
                        Text("Sugar")
                            .frame(width: 60, alignment: .leading)
                        Spacer()
                        Text("Insulin")
                            .frame(width: 60, alignment: .leading)
                        Spacer()
                        Text("Grain Units")
                            .frame(width: 80, alignment: .leading)
                    }
                    .padding()
                    
                    // Данные таблицы (тип приема пищи, уровень сахара, инсулин, хлебные единицы)
                    ForEach(dayModel.meals.indices) { index in
                        HStack {
                            Text("\(dayModel.meals[index].type)")
                                .frame(width: 100, alignment: .leading)
                            Spacer()
                            TextField("Sugar", text: Binding(
                                get: { String(dayModel.meals[index].sugar) },
                                set: { dayModel.meals[index].sugar = Float($0) ?? 0.0 }
                            ))
                            .frame(width: 60, alignment: .leading)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            Spacer()
                            TextField("Insulin", text: Binding(
                                get: { String(dayModel.meals[index].insulin) },
                                set: { dayModel.meals[index].insulin = Int($0) ?? 0 }
                            ))
                            .frame(width: 60, alignment: .leading)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            Spacer()
                            TextField("Grain Units", text: Binding(
                                get: { String(dayModel.meals[index].grainUnits) },
                                set: { dayModel.meals[index].grainUnits = Float($0) ?? 0.0 }
                            ))
                            .frame(width: 80, alignment: .leading)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        .padding(.vertical, 5)
                    }
                    
                    VStack(alignment: .leading) {
                        TextField("Enter notes", text: Binding(
                            get: { dayModel.notes },
                            set: { dayModel.notes = $0 }
                        ))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    }
                }
            }
            
            else {
                Text("No entries for this day.")
            }
            
///                         DANGER - DELETE ALL FILES
//            Button(action: {
//                deleteAllEntries()
//            }) {
//                Text("Delete All Entries")
//                    .foregroundColor(.red)
//                    .padding()
//                    .background(Color.gray.opacity(0.2))
//                    .cornerRadius(8)
//            }
//            .padding()
        }
        .onAppear {
            // Загружаем данные при открытии представления
            loadEntriesForDay()
        }
        .onDisappear {
            // Сохраняем данные при закрытии представления
            saveEntriesForDay()
        }
    }
    
    
    func loadEntriesForDay() {
        if let data = UserDefaults.standard.data(forKey: "\(day)-\(month)-\(year)") {
            let decoder = JSONDecoder()
            if let loadedDay = try? decoder.decode(DayModel.self, from: data) {
                self.dayModel = loadedDay
            }
        } else {
            // Если запись не найдена, создаем новый dayModel
            let mealModels = [
                MealModel(type: "Breakfast"),
                MealModel(type: "Second Breakfast"),
                MealModel(type: "Lunch"),
                MealModel(type: "Snack"),
                MealModel(type: "Dinner"),
                MealModel(type: "Bedtime")
            ]
            self.dayModel = DayModel(date: todaysDate.date, meals: mealModels)
        }
    }
    
    func saveEntriesForDay() {
        if let dayModel = dayModel {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(dayModel) {
                UserDefaults.standard.set(encoded, forKey: "\(day)-\(month)-\(year)")
            }
        }
    }
    
///                             DANGER
//    func deleteAllEntries() {
//        print("Deleting all entries")
//        let defaults = UserDefaults.standard
//        let keys = defaults.dictionaryRepresentation().keys
//        for key in keys {
//            if key.contains("-") { // Assuming the keys for diary entries contain hyphens
//                defaults.removeObject(forKey: key)
//                print("Deleted entry for key: \(key)")
//            }
//        }
//        self.dayModel = nil
//    }
}

#Preview {
    DiaryView(day: 1, month: 1, year: 2024)
}
