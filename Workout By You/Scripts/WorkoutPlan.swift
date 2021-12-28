import Foundation

// Defines the foundation for the Workout data type and exercise data type

struct Workout: Identifiable, Codable {
    // Workout variable declarations
    let id: UUID
    var title: String
    
    // Array of exercises in the workout
    var exercises: [Exercise]
    
    // Number of sets in the workout
    var sets: Int
    
    // Defines if there are breaks between exercises
    var hasBreaks: Bool
    var breaksLengthInSeconds: Int
    
    var theme: Theme
    
    //Initializer for workout with default values
    init(id: UUID = UUID(), title: String = "", exercises: [Exercise] = [], sets: Int = 1, hasBreaks: Bool = false, breaksLengthInSeconds: Int = 5, theme: Theme = .Slime) {
        self.id = id
        self.title = title
        self.exercises = exercises
        self.sets = sets
        self.hasBreaks = hasBreaks
        self.breaksLengthInSeconds = breaksLengthInSeconds
        self.theme = theme
    }
    
    // Exercise structer (sub structure of workout)
    struct Exercise: Identifiable, Codable {
        // Variable declarations
        let id: UUID
        var title: String
        
        // Length of exercise in seconds
        var seconds: Int
        
        // Has the exercise been completed or not (helps find the current exercise)
        var completed: Bool
        
        // Initializer for exercise with default values
        init(id: UUID = UUID(), title: String = "", seconds: Int = 10, completed: Bool = false) {
            self.id = id
            self.title = title
            self.seconds = seconds
            self.completed = completed
        }
    }
    
    // Sample workout data for app development process (not used in final product)
    static let sampleData: [Workout] =
    [
        Workout(title: "Warmup", exercises: [Exercise(title: "Jumping jacks", seconds: 40), Exercise(title: "Arm circles", seconds: 30), Exercise(title: "Lunges", seconds: 40), Exercise(title: "Toe Touches", seconds: 35)], sets: 2, theme: .Lavender),
        Workout(title: "All round", exercises: [Exercise(title: "Pushups", seconds: 30), Exercise(title: "Squats", seconds: 45), Exercise(title: "Plank", seconds: 30), Exercise(title: "Sit ups", seconds: 60)], sets: 2, theme: .Poppy),
        Workout(title: "High Intensity", exercises: [Exercise(title: "Lateral Shuffles", seconds: 40), Exercise(title: "180 degree Squat Jumps", seconds: 40), Exercise(title: "High Knees", seconds: 40), Exercise(title: "Mountain Climbers", seconds: 40), Exercise(title: "Tuck Jumps", seconds: 40), Exercise(title: "Burpees", seconds: 40)], theme: .Seafoam)
    ]
}
