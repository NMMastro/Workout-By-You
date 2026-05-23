<div align="center">
  <img src="https://raw.githubusercontent.com/NMMastro/Workout-By-You/main/Workout%20By%20You/screenshots/appicon.png" width="120" alt="Workout By You App Icon" />
  
  # Workout By You

  A custom iOS workout builder and real-time exercise timer built in SwiftUI.

  ![Swift](https://img.shields.io/badge/Swift-%23F05138.svg?style=for-the-badge&logo=swift&logoColor=white)
  ![SwiftUI](https://img.shields.io/badge/SwiftUI-%23000000.svg?style=for-the-badge&logo=apple&logoColor=white)
  ![iOS](https://img.shields.io/badge/iOS-15%2B-blue?style=for-the-badge&logo=apple&logoColor=white)
</div>

---

Built as my CS50 final project during COVID, when my volleyball team was stuck doing home workouts from a plain document our coaches sent over. I wanted something more interactive — an app where we could actually set up the workout and follow along in real time.


## Screenshots

<div align="center">
  <img src="https://raw.githubusercontent.com/NMMastro/Workout-By-You/main/Workout%20By%20You/screenshots/homescreen.png" width="22%" alt="Home Screen" />
  <img src="https://raw.githubusercontent.com/NMMastro/Workout-By-You/main/Workout%20By%20You/screenshots/workoutdetails.png" width="22%" alt="Workout Details" />
  <img src="https://raw.githubusercontent.com/NMMastro/Workout-By-You/main/Workout%20By%20You/screenshots/workoutplan.png" width="22%" alt="Edit Workout" />
  <img src="https://raw.githubusercontent.com/NMMastro/Workout-By-You/main/Workout%20By%20You/screenshots/circle.png" width="22%" alt="Exercise Timer" />
</div>

---

## Features

- **Custom workout builder** — create plans with any exercises, durations, and sets
- **Real-time timer** — animated circular progress ring with play/pause and skip controls
- **Automatic progression** — moves through exercises and sets automatically, with optional breaks between exercises
- **12 color themes** — per-workout color theming (Navy, Seafoam, Lavender, BubbleGum, and more)
- **Persistent storage** — workout plans saved locally via iOS FileManager with full CRUD
- **Full lifecycle** — designed, built, and published to the App Store

---

## How It Works

1. Create a workout plan with a name, number of sets, and a list of exercises with durations
2. Optionally toggle breaks between exercises and pick a color theme
3. Start the workout — the app tracks your position across exercises and sets, showing a live countdown ring
4. Pause, skip forward, or jump back at any time

---

## Project Structure

```
Workout By You/
  Scripts/
    WorkoutPlan.swift      # Data model and Codable conformance
    FileManager.swift      # Local persistence (save, load, delete)
    ExerciseTimer.swift    # Timer logic, state machine, pause/resume
    Theme.swift            # Color theme definitions
  WorkoutViews/
    WorkoutView.swift      # Main workout session container
    WorkoutMainView.swift  # Circular progress ring and exercise display
    WorkoutHeaderView.swift
    WorkoutFooterView.swift
  SelectionView.swift      # Home screen — list of workout plans
  DetailWorkoutView.swift  # Workout detail and start screen
  EditWorkoutView.swift    # Create and edit workout plans
  ThemeView.swift          # Theme picker
  CardView.swift           # Color-coded workout card component
```

---

## Built With

- Swift & SwiftUI
- iOS FileManager for local persistence
- Custom `ExerciseTimer` state machine for accurate interval tracking with pause/resume