import SwiftUI

// The scene that's displayed during the workout (combines many sub scenes)
struct WorkoutView: View {
    
    // Active workout
    @Binding var workout: Workout
    
    // Initialize timer for workout
    @StateObject var exerciseTimer = ExerciseTimer()
    
    var totalExercises: Int {
        workout.exercises.count
    }
    
    var body: some View {
        
        ZStack {
            // Make background for scene that's the same color as the theme
            RoundedRectangle(cornerRadius: 16)
                .fill(workout.theme.mainColor)
            VStack {
                // Load the header, main, and footer view all together
                WorkoutHeaderView(theme: workout.theme, totalExercises: totalExercises, exerciseTimer: exerciseTimer)
                WorkoutMainView(exercises: $workout.exercises, exerciseTimer: exerciseTimer, theme: workout.theme)
                WorkoutFooterView(activeSet: exerciseTimer.activeSet, totalSets: workout.sets, nextExercise: exerciseTimer.skipExercise, previousExercise: exerciseTimer.goBackExercise)
            }
        }
        .padding()
        //Make the text the accent color for the theme
        .foregroundColor(workout.theme.accentColor)
        .onAppear {
            // When the scene is loaded start the workout timer
            exerciseTimer.reset(workout: workout)
            exerciseTimer.startExercise()
        }
        .onDisappear {
            // When the scene is closed stop the workout timer
            exerciseTimer.stopExercise()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Used to view the scene while developing the app (not used in final product)
struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView(workout: .constant(Workout.sampleData[0]))
    }
}
