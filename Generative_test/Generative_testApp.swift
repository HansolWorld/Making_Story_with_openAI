//
//  Generative_testApp.swift
//  Generative_test
//
//  Created by apple on 2023/08/22.
//

import SwiftUI

@main
struct Generative_testApp: App {
    @StateObject var user = User()
    @StateObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                StartView()
            }
            .id(appState.startViewId)
            .environmentObject(user)
            .environmentObject(appState)
        }
    }
}
