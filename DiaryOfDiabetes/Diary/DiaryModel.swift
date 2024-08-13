import Foundation

class DayModel: Codable {
    var date: Date
    var meals: [MealModel]
    var notes: String
    
    init(date: Date, meals: [MealModel] = [], notes: String = "") {
        self.date = date
        self.meals = meals
        self.notes = notes
    }
}

class MealModel: Codable {
    var type: String 
    var sugar: Float
    var insulin: Int
    var grainUnits: Float
    
    init(type: String, sugar: Float = 0, insulin: Int = 0, grainUnits: Float = 0) {
        self.type = type
        self.sugar = sugar
        self.insulin = insulin
        self.grainUnits = grainUnits
    }
}
