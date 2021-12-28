import SwiftUI

//Called When the app is opened
@main
struct Workout_By_YouApp: App {
    
    // Define a workoutFileManager object to access premade workouts
    @StateObject private var workoutFileManager = WorkoutFileManager()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                // Call the selection view where the user can view all the workouts
                SelectionView(workouts: $workoutFileManager.workouts) {
                    // Defines save function that's used in the selection view
                    workoutFileManager.saveWorkout(workouts: workoutFileManager.workouts)
                }
            }
            .onAppear() {
                // When the app opens load the workouts from files
                workoutFileManager.loadWorkout()
            }
        }
    }
}
