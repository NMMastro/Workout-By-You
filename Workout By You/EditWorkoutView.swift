import SwiftUI

// Allows the user to edit a workout
struct EditWorkoutView: View {
    
    // Reference to the workout that's going to be edited
    @Binding var workout: Workout
    
    // Note: Sliders in swiftUI requires a reference to a Double variable
    // To get integer values from a slider, a reference to a temperary double variable was provided, and then casted to an integer for the official variable
    
    // Double that represents the number of sets in the workout
    var setsDouble: Binding<Double> {
        // When the variable is called it returns the value from workout.sets casted to a double
        Binding<Double>(get: {
            return Double(workout.sets)
        // When the variable is updated, it updates workout.sets using a cast to an integer
        }, set: {
            workout.sets = Int($0)
        })
    }
    
    // Double that represents the length per break for this workout
    var BreaksLengthDouble: Binding<Double> {
        // When the variable is called it returns the value from workout.breaksLengthInSeconds casted to a double
        Binding<Double>(get: {
            return Double(workout.breaksLengthInSeconds)
        // When the variable is updated, it updates workout.breaksLengthInSeconds using a cast to an integer
        }, set: {
            workout.breaksLengthInSeconds = Int($0)
        })
    }
    
    @State private var newExercise: Workout.Exercise = Workout.Exercise()
    
    // Double that represents the length for an exercise
    var newExerciseLengthDouble: Binding<Double> {
        // When the variable is called it returns the value from newExercise.seconds casted to a double
        Binding<Double>(get: {
            return Double(newExercise.seconds)
        // When the variable is updated, it updates newExercise.seconds using a cast to an integer
        }, set: {
            newExercise.seconds = Int($0)
        })
    }
    
    var body: some View {
        Form {
            // Fields for general information for the workout
            Section (header: Text("Workout Details")) {
                // Workout title (text field)
                TextField("Title", text: $workout.title)
                
                // Number of sets in the workout (slider)
                HStack {
                    Slider(value: setsDouble, in: 1...5, step: 1) {
                        Text("Sets")
                    }
                    Spacer()
                    if Int(workout.sets) == 1 {
                        Text("\(Int(workout.sets)) set")
                    } else {
                        Text("\(Int(workout.sets)) sets")
                    }
                    
                }
                
                // If the workout has breaks between exercises (toggle)
                Toggle("Breaks between exercises", isOn: $workout.hasBreaks)
                // If the user wants breaks, display slider for the length of each break
                if workout.hasBreaks {
                    VStack {
                        Slider(value: BreaksLengthDouble, in: 5...100, step: 5) {
                            Text("Breaks Length in seconds")
                        }
                        Spacer()
                        Text("\(Int(workout.breaksLengthInSeconds)) seconds per break")
                    }
                }
                // Alows user to select theme for the workout (puts all themes in a list)
                Picker("Theme", selection: $workout.theme) {
                    ForEach(Theme.allCases) { theme in
                        ThemeView(theme: theme)
                            .tag(theme)
                    }
                }
            }
            
            // Allows user to edit the exercises in the workout
            Section (header: Text("Exercises")) {
                // Prints exercises in a list
                List {
                    ForEach(workout.exercises) { exercise in
                        HStack {
                            Text(exercise.title)
                            Spacer()
                            Text("\(Int(exercise.seconds)) seconds")
                        }
                    }
                    // Deletes a specific exercise if user slides left on the exercise
                    .onDelete { index in
                        workout.exercises.remove(atOffsets: index)
                    }
                }
                // Add more exercises
                VStack {
                    HStack {
                        // Name for new exercise
                        TextField("New Exercise", text: $newExercise.title)

                        // Submit button that adds new exercise to workouts and resets the newExercsie variable
                        Button(action: {
                            withAnimation {
                                let exercise = Workout.Exercise(title: newExercise.title, seconds: newExercise.seconds)
                                workout.exercises.append(exercise)
                                newExercise.title = ""
                                newExercise.seconds = 10
                            }
                        }) {
                            Image(systemName: "plus.circle.fill")
                        }
                        // Doesn't allow user to submit new exercise if they didn't specify a name
                        .disabled(newExercise.title.isEmpty)

                    }
                    // Slider for the length of the new exercise in seconds
                    HStack {
                        Slider(value: newExerciseLengthDouble, in: 10...180, step: 5) {
                            Text("Seconds")
                        }
                        Spacer()
                        Text("\(Int(newExercise.seconds)) seconds")
                    }

                }
            }
        }
    }
}


// Used to view the scene while developing the app (not used in final product)
struct EditWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        EditWorkoutView(workout: .constant(Workout.sampleData[0]))
    }
}
