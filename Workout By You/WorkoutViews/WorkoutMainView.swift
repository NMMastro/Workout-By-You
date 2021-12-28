//
//  WorkoutMainView.swift
//  Workout By You
//
//  Created by Dino Mastronardi on 2021-12-18.
//

import SwiftUI

// Defines the timer portion of the workout view (sub view)
struct WorkoutMainView: View {
    
    // Referene to the exercises for the active workout
    @Binding var exercises: [Workout.Exercise]
    
    // Reference to the exerciseTimer in the workoutView
    @ObservedObject var exerciseTimer: ExerciseTimer
    
    let theme: Theme
    
    private var currentExercise: Workout.Exercise {
        exercises[exerciseTimer.activeExerciseIndex]
    }
    
    // Calculated the progress for the timer (
    var progress:Double {
        // If the end screen is active fill the circle
        if exerciseTimer.isEnd { return 1 }
        return Double(exerciseTimer.elapsedSeconds)/Double(exerciseTimer.totalSeconds)
    }
    
    var body: some View {
        // Make the background circle
        Circle()
            .stroke(lineWidth: 30)
            .overlay {
                // Display text to middle of circle depending on state of the workout
                VStack {
                    if (exerciseTimer.isStart) {
                        Text("Starting in \(exerciseTimer.totalSeconds - Int(exerciseTimer.elapsedSeconds))")
                            .font(.title)
                    }
                    else if (exerciseTimer.isBreak) {
                        Text("Break Time")
                            .font(.title)
                        Text("\(exerciseTimer.totalSeconds) seconds")
                    }
                    else if (exerciseTimer.isEnd) {
                        Text("Workout Complete")
                            .font(.title)
                    }
                    else {
                        Text(currentExercise.title)
                            .font(.title)
                        Text("\(currentExercise.seconds) seconds")
                    }
                }
            }
            .overlay {
                // Display the progress for the timer
                Circle()
                    .trim(from: 0.0, to: min(progress, 1.0))
                    .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.blue)
                    .rotationEffect(Angle(degrees: 270.0))

            }
            .padding(.horizontal, 30.0)
    }
}

// Used to view the scene while developing the app (not used in final product)
struct WorkoutMainView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutMainView(exercises: .constant(Workout.sampleData[1].exercises), exerciseTimer: ExerciseTimer(), theme: .Lemon)
    }
}
