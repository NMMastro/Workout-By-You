import SwiftUI

// Allows the user to view all of their workouts and navigate between them
struct SelectionView: View {
    
    // reference to the users workouts
    @Binding var workouts: [Workout]
    
    // Variable declarations for if the user wants to make a new workout
    @State private var newWorkoutData = Workout()
    @State private var newWorkoutViewActive = false
    @State private var presentInvalidWorkoutAlert = false
    @State private var errorMessage = ""
    
    // Contains the current phase of the scene
    @Environment(\.scenePhase) private var scenePhase
    
    // Save function thats declared in Workout_By_YouApp
    let saveFunction: ()->Void

    
    var body: some View {
        // Displays all the workouts in a list
        List {
            ForEach($workouts) { $workout in
                // If the user clicks on the workout the DetailWorkoutView will be loaded
                NavigationLink(destination: DetailWorkoutView(workout:$workout)) {
                    // Show the workout using the cardView
                    CardView(workout: workout)
                }
                // Make the background of each workout it's theme's main color
                .listRowBackground(workout.theme.mainColor)
            }
            // If the user slides left on a workout it will delete
            .onDelete { index in
                workouts.remove(atOffsets: index)
            }
        }
        .navigationTitle("Workout Plans")
        .toolbar {
            // Add button in tool bar to add a new Workout
            Button(action: {newWorkoutViewActive = true}) {
                Image(systemName: "plus")
            }
        }
        // If new workout button was pressed
        .sheet(isPresented: $newWorkoutViewActive) {
            NavigationView {
                // Open editWorkoutView and pass in an empty workout
                EditWorkoutView(workout: $newWorkoutData)
                    .toolbar {
                        // If the user chossed to dismiss the changes put everything back to normal
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                newWorkoutViewActive = false
                                newWorkoutData = Workout()
                            }
                        }
                        // If the user wanted to confirm the changes
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                //If there was an error make a popup
                                if (newWorkoutData.title == "") {
                                    errorMessage = "Workout title is empty"
                                    presentInvalidWorkoutAlert = true
                                }
                                else if (newWorkoutData.exercises.isEmpty) {
                                    errorMessage = "No exercises are added"
                                    presentInvalidWorkoutAlert = true
                                }
                                // If everything worked update workouts and close the editWorkoutView
                                else {
                                    let newWorkout = newWorkoutData
                                    workouts.append(newWorkout)
                                    newWorkoutData = Workout()
                                    newWorkoutViewActive = false
                                }
                            }
                        }
                    }
                    // Error alert popup
                    .alert("Invalid Workout!", isPresented: $presentInvalidWorkoutAlert, actions: {}, message: {Text(errorMessage)})
            }
        }
        // If the scene is inactive save the workouts
        .onChange(of: scenePhase) { phase in
            if phase == .inactive {
                saveFunction()
            }
        }
        
    }
}

// Used to view the scene while developing the app (not used in final product)
struct SelectionView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            SelectionView(workouts: .constant(Workout.sampleData), saveFunction: {})
        }
    }
}
