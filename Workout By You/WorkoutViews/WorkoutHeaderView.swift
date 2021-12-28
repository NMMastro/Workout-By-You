import SwiftUI

// Defines the header of the workout view (sub view)
struct WorkoutHeaderView: View {
    
    // Variable declarations
    let theme: Theme
    let totalExercises: Int
    
    // A reference to the exerciseTimer in the workoutView
    @ObservedObject var exerciseTimer: ExerciseTimer
    
    // Calculate progress for slider (represented by a decimal 0-1)
    private var progress: Double {
        // If the end screen is enabled fill the slider
        if exerciseTimer.isEnd {return 1}
        
        // Otherwise return the decimal for the slider
        return Double(exerciseTimer.activeExerciseIndex) / Double(totalExercises)
    }
    
    // Choose the text for underneath the slider
    private var exerciseText: String {
        if exerciseTimer.isEnd {return "No more exercises"}
        return "Exercise \(exerciseTimer.activeExerciseIndex + 1) of \(totalExercises)"
    }
    
    var body: some View {
        VStack {
            ZStack {
                //Make background for the slider
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(theme.accentColor)
                    .frame(height: 20.0)
                //Display slider
                ProgressView(value:progress)
                    .frame(height: 12.0)
                    .padding(.horizontal)
            }
            HStack {
                Spacer()
                Text("\(exerciseText)")
                Spacer()
                // Display pause button that triggers the pauseTimer functino from exerciseTimer
                Button(action: {exerciseTimer.pauseTimer(pause: !exerciseTimer.isPaused)}) {
                    Image(systemName: "playpause.fill")
                }
            }
        }
        .padding([.top, .horizontal])
    }
}

// Used to view the scene while developing the app (not used in final product)
struct WorkoutHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutHeaderView(theme: .Poppy, totalExercises: 6, exerciseTimer: ExerciseTimer())
            .previewLayout(.sizeThatFits)
    }
}
