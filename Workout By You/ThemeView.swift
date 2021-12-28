//
//  ThemeView.swift
//  Workout By You
//
//  Created by Dino Mastronardi on 2021-12-24.
//

import SwiftUI

// Sub view that declares the appearance of a theme when called in a list
struct ThemeView: View {
    let theme: Theme
    
    var body: some View {
        ZStack {
            // Make rectangle background
            RoundedRectangle(cornerRadius: 4)
                .fill(theme.mainColor)
            // Display name of theme and eyedropper symbol
            Label(theme.name, systemImage: "eyedropper.halffull")
                .padding(4)
        }
        .foregroundColor(theme.accentColor)
        .fixedSize(horizontal: false, vertical: true)
    }
}

// Used to view the scene while developing the app (not used in final product)
struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView(theme: .Poppy)
    }
}
