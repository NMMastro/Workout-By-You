import Foundation
 
// Used to manage the timer for the workouts, and update the current exercise/set when neccessary
class ExerciseTimer: ObservableObject {
    
    // Defines active exercise and set
    @Published var activeExerciseIndex: Int = 0
    @Published var activeSet: Int = 1
    
    // Defines if the workout is on a break (assuming breaks are enabled)
    @Published var isBreak = false
    // Defines if its the start of the workouts before any exercises
    @Published var isStart = false
    // Defines if its the end of the workout after any exercise
    @Published var isEnd = false
    
    // Initialize a workout variable that will be set to the selected workout
    var workout: Workout = Workout()
    
    // The seconds that has passed for a specific exercise (updated for every exercise change)
    @Published var elapsedSeconds: Double = 0 // Note that elapsedSeconds is a double so that the timer flows smoother
    // The total seconds for an exercise (updated for every exercise change)
    @Published var totalSeconds: Int = 0
    
    // All time related variable declarations
    private var frequency: TimeInterval { 1.0 / 60.0 }
    private var timer: Timer?
    private var startInterval: TimeInterval? // Used to store when an exercise is started
    private var pausedInterval: TimeInterval? // Used to store when a the user paused
    
    @Published var isPaused = false
        
    // Starts the flow of the workout
    func startExercise() {
        // Displays a start screen that runs for 10 seconds before any exercise begins
        self.isStart = true
        self.totalSeconds = 5
        runTimer()
    }
    
    // Stop the timer after the workout is complete
    func stopExercise() {
        timer?.invalidate()
        timer = nil
    }
    
    // Skip to the next exercise
    func skipExercise() {
        
        // If the start screen is enabled, unable it and change to the first exercise
        if isStart {
            isStart = false
            changeToExercise(at: 0)
        }
        // If the current exercise is the last exercise, show the end screen
        else if (activeExerciseIndex + 1) >= workout.exercises.count && activeSet >= workout.sets {
            workout.exercises[activeExerciseIndex].completed = true
            isEnd = true
        }
        // If the workout has breaks and is coming from an exercise, show a break screen
        else if workout.hasBreaks && !isBreak {
            changeToBreak()
        }
        // Move to the next exercise
        else {
            changeToExercise(at: self.activeExerciseIndex + 1)
        }
        
    }
    
    func goBackExercise() {
        // if the current exercise is the first exercise of the set, return
        if activeExerciseIndex <= 0 { return }
        
        // If the end screen is enabled, disable the end screen and play the last exercise
        if isEnd {
            isEnd = false
            workout.exercises[self.activeExerciseIndex ].completed = false
            changeToExercise(at: self.activeExerciseIndex)
        }
        // Go back exercise
        else {
            workout.exercises[self.activeExerciseIndex - 1].completed = false
            changeToExercise(at: self.activeExerciseIndex - 1)
        }
    }
    
    // Changes current exercise to specified index
    private func changeToExercise(at index: Int) {
        
        // set the last exercise to completed
        if index > 0 {
            workout.exercises[index - 1].completed = true
        }
        
        // If the new index is too big for the amount of exercises, switch to the next set if available or enable the end screen
        if index >= workout.exercises.count {
            if (activeSet < workout.sets) {
                activeExerciseIndex = 0
                activeSet += 1
            }
            else {
                isEnd = true
            }
        }
        // If the index is valid make it the current exercise
        else {
            activeExerciseIndex = index
        }
        
        // Set the total seconds to the length of the current exercise
        self.totalSeconds = workout.exercises[activeExerciseIndex].seconds
        isBreak = false
        // Start the timer for the exercise
        runTimer()
    }
    
    // Enable break
    private func changeToBreak() {
        // set the total seconds to the specified length for a break
        self.totalSeconds = workout.breaksLengthInSeconds
        isBreak = true
        // Start the timer for the break
        runTimer()
 
    }
    
    
    // Manages the timer that is displayed in the large circle in the workout view
    private func runTimer() {
        
        //If the timer is paused when the exercise changed, update the pauseInterval to the start of the exercise to avoid a bug
        if(isPaused) {
            pausedInterval = Date().timeIntervalSince1970
        }
        
        // Reset the elapsedSeconds and startInterval
        self.elapsedSeconds = 0.0
        startInterval = Date().timeIntervalSince1970
        
        // Initialize the timer
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { timer in

            // If the startInterval is not null
            if let startInterval = self.startInterval {
                // If the timer is not paused update the seconds
                if !self.isPaused {
                    self.elapsedSeconds = Date().timeIntervalSince1970 - startInterval
                }
                
                // If the timer has reached the specified length skip to the next exercise
                if self.elapsedSeconds >= Double(self.totalSeconds) {
                    self.skipExercise()
                }
                
            }
        }
    }
    
    func pauseTimer(pause: Bool) {
        // If the user wants to pause the timer
        if pause {
            //set the pauseInterval to the current time so that we can track how long the timer has been paused
            pausedInterval = Date().timeIntervalSince1970
            isPaused = true
        }
        // If the use wants to unpause the timer
        else {
            // Adjust the startInterval with the pausedInterval so that the timer is unajusted and can continue from where it left off
            startInterval! -= (pausedInterval! - Date().timeIntervalSince1970)
            isPaused = false
            pausedInterval = nil
        }
        
    }
    
    // Prepares exerciseTimer for new workout
    func reset(workout: Workout) {
        
        // Sets workout to specific workout
        self.workout = workout
        
        // Sets variables to default values
        totalSeconds = workout.exercises[0].seconds
        activeSet = 1
        isBreak = false
    }
}
 
 

