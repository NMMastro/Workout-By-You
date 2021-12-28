//
//  FileManager.swift
//  Workout By You
//
//  Created by Dino Mastronardi on 2021-12-27.
//

import Foundation

// Class for saving and loading workouts into files
class WorkoutFileManager: ObservableObject {
    
    // Defines array of workouts
    // @Published defines that workouts autoupdates all of its exeternal instances when it's changed
    @Published var workouts: [Workout] = []
    
    // constant string for accessing workouts in files
    let accessKey: String = "SAVEDWORKOUTS"
    
    //Object used for interacting with system storage
    let defaults: UserDefaults
    
    // Initialize userDefaults object 
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    
    // Load workouts from files
    func loadWorkout() {
        
        // Checks for workouts in files using the access key and sets the data equal to savedWorkouts
        if let savedWorkouts = defaults.object(forKey: accessKey) as? Data {
            
            // Initiallise a decoder
            let decoder = JSONDecoder()
            
            // If the decoding was successful load the workouts and return
            if let loadedWorkouts = try? decoder.decode(Array.self, from: savedWorkouts) as [Workout] {
                workouts = loadedWorkouts
                return
            }
        }
        // If something went wrong or there were no workouts in the files initialize to empty
        workouts = []
    }
    
    
    // Saves workouts to files
    func saveWorkout(workouts: [Workout]) {
        
        // Initiallize encoder
        let encoder = JSONEncoder()
        
        // If the encoding was successful submit the encoded workouts into the systems files
        if let encoded = try? encoder.encode(workouts) {
            defaults.set(encoded, forKey: accessKey)
        }
    }

    
}
