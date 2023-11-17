//
//  notesAppApp.swift
//  notesApp
//
//  Created by Adesh Shah on 2023-11-17.
//

import SwiftUI
import Firebase

@main
struct notesAppApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(NotesModel())
        }
    }
}
