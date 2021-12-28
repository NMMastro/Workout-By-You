import SwiftUI

// Defines the footer of the workout view (sub view)
struct WorkoutFooterView: View {
    
    var activeSet: Int
    var totalSets: Int
    
    // Declare empty functions for skipping and going back exercises (They are declared when view is called)
    var nextExercise: ()->Void
    var previousExercise: ()->Void
    
    var body: some View {
        VStack {
            HStack {
                // Button to go back exercise
                Button(action:previousExercise) {
                    Image.init(systemName: "backward.fill")
                }
                Spacer()
                Text("Set \(activeSet) of \(totalSets)")
                Spacer()
                // Button to skip exercises
                Button(action: nextExercise) {
                    Image(systemName: "forward.fill")
                }
            }
        }
        .padding([.bottom, .horizontal])
    }
}

// Used to view the scene while developing the app (not used in final product)
struct MeetingFooterView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutFooterView(activeSet: 1, totalSets: 3, nextExercise: {}, previousExercise: {})
            .previewLayout(.sizeThatFits)
    }
}
