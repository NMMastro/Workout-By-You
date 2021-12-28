import SwiftUI

// Displays the specific details of a workout

struct DetailWorkoutView: View {
    
    // Reference to the workout that's displayed
    @Binding var workout: Workout
    
    // Variable declarations for if the user wants to edit the workout
    @State private var editedWorkoutData = Workout()
    @State private var editWorkoutViewActive = false
    @State private var presentInvalidWorkoutAlert = false
    @State private var errorMessage = ""
    
    // Calculate the total length of a workout in minutes
    private var timeInMinutes: Int {
        //Count all the seconds from the exercises
        var totalSeconds: Int = 0
        for exercise in workout.exercises {
            totalSeconds += exercise.seconds
        }
        totalSeconds *= workout.sets
        // If the workout has breaks include that time
        if workout.hasBreaks {
            totalSeconds += (workout.breaksLengthInSeconds * workout.exercises.count * workout.sets - workout.breaksLengthInSeconds)
        }
        //Convert the seconds to minutes
        return Int((Double(totalSeconds) / 60.0).rounded(.up))
    }
    
    var body: some View {
        List {
            // Displays general details about the wokrout
            Section(header: Text("Workout Details")) {
                // Start button to begin the workout
                NavigationLink(destination: WorkoutView(workout: $workout)) {
                    Label("Start Workout", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                // The total length of the workout in minutes
                HStack {
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text("\(timeInMinutes) Minutes")
                }
                // The amount of sets specified for this workout
                HStack {
                    Label("Sets", systemImage: "repeat.circle")
                    Spacer()
                    Text("\(workout.sets)")
                }
                // If the workout has breaks display the length for each break
                if workout.hasBreaks {
                    HStack {
                        Text("Length of Breaks")
                        Spacer()
                        Text("\(workout.breaksLengthInSeconds) Seconds")
                    }
                }
                // Display the theme for the workout
                HStack {
                    Label("Theme", systemImage: "eyedropper.halffull")
                    Spacer()
                    Text(workout.theme.name)
                        .foregroundColor(workout.theme.accentColor)
                        .background(workout.theme.mainColor)
                        .cornerRadius(4)
                }
            }
            // Displays the exercises in a list and how long each exercise lasts in seconds
            Section(header: Text("Exercises")) {
                ForEach (workout.exercises) { exercise in
                    HStack {
                        Label(exercise.title, systemImage: "figure.walk")
                        Spacer()
                        Text("\(exercise.seconds) seconds")
                    }
                }
            }
            
        }
        // Display the workout title at the top of the page
        .navigationTitle(workout.title)
        .toolbar {
            // Add edit button to tool bar to open the EditWorkoutView (to edit the workout)
            Button("Edit") {
                editWorkoutViewActive = true
                editedWorkoutData = workout
            }
        }
        // If the edit button was pressed
        .sheet(isPresented: $editWorkoutViewActive) {
            NavigationView {
                // Open the editWorkoutView
                EditWorkoutView(workout: $editedWorkoutData)
                    .toolbar {
                        // If the user presses cancel forget changes
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                editWorkoutViewActive = false
                            }
                        }
                        // If the user confirms changes
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                // If there was an error show a popup message
                                if (editedWorkoutData.title == "") {
                                    errorMessage = "Workout title is empty"
                                    presentInvalidWorkoutAlert = true
                                }
                                else if (editedWorkoutData.exercises.isEmpty) {
                                    errorMessage = "No exercises are added"
                                    presentInvalidWorkoutAlert = true
                                }
                                // If there was no errors update the workout and close the EditWorkoutView
                                else {
                                    workout = editedWorkoutData
                                    editWorkoutViewActive = false
                                }
                            }
                        }
                    }
                    // Error alert popup
                    .alert("Invalid Workout!", isPresented: $presentInvalidWorkoutAlert, actions: {}, message: {Text(errorMessage)})
            }
        }
    }
}

// Used to view the scene while developing the app (not used in final product)
struct DetailWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailWorkoutView(workout: .constant(Workout.sampleData[0]))
        }
    }
}
