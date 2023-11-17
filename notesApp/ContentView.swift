//
//  ContentView.swift
//  notesApp
//
//  Created by Adesh Shah on 2023-11-17.
//

import SwiftUI
import Firebase

struct ContentView: View {
  @State var isUserLoggedIn = false
  
  var body: some View {
    NavigationView {
      if isUserLoggedIn {
        NotesListView()
      } else {
        AuthView()
      }
    }
    .onAppear {
      Auth.auth().addStateDidChangeListener { auth, user in
        if user != nil {
          isUserLoggedIn.toggle()
        }
      }
    }
  }
}


#Preview {
    ContentView()
}
