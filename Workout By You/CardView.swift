import SwiftUI

// Sub view that adjusts the appearance of a workout for the selection view
struct CardView: View {
    
    // Workout to display
    let workout: Workout
    
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
        VStack (alignment:.leading) {
            // Display the workout title
            Text(workout.title)
                .font(.headline)
            Spacer()
            HStack {
                // Display the amount of sets in the workout
                Text("\(workout.sets) Sets")
                Spacer()
                // Display the length of the workout in minutes
                Image(systemName: "clock")
                Text("\(timeInMinutes)")
            }
            .font(.caption)
            
        }
        .padding()
        // Make sure the text is visible over the background color
        .foregroundColor(workout.theme.accentColor)
    }
}

// Used to view the scene while developing the app (not used in final product)
struct CardView_Previews: PreviewProvider {
    static var workout = Workout.sampleData[0]
    
    static var previews: some View {
        CardView(workout: workout)
            .background(workout.theme.mainColor)
            .previewLayout(.fixed(width: 400, height: 50))
    }
}
