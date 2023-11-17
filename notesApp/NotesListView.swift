//
//  NotesListView.swift
//  notesApp
//
//  Created by Adesh Shah on 2023-11-17.
//

import SwiftUI
import Firebase
import UserNotifications

struct NotesListView: View {
    @EnvironmentObject var model: NotesModel
    @State var showAddNewNoteView = false
    @State var note = Note()
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        List(model.notes, id: \.id) { note in
            Text(note.title)
                .onTapGesture {
                    self.note = note
                    showAddNewNoteView.toggle()
                }
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive){
                        model.deleteNote(note: note)
                    } label: {
                        Label("Delete",  systemImage: "trash")
                    }
                }
        }
        .navigationTitle("Notes")
        .toolbar {
            ToolbarItemGroup {
                Button("Logout") {
                    logout()
                    isLoggedIn = false
                }
                Button {
                    self.note = Note()
                    showAddNewNoteView.toggle()
                } label: {
                    Image(systemName: "note.text.badge.plus")
                }
                Button {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) {
                        success, error in
                        if (success){
                            print("all good with the auth")
                        } else if let error = error {
                            print("error")
                        }
                    }
                    let content = UNMutableNotificationContent()
                    content.title = note.title
                    // todo
                    content.subtitle = note.text
                    // todo
                    content.sound = UNNotificationSound.default
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                    let req = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    UNUserNotificationCenter.current().add(req)
                } label: {
                    Image(systemName: "bell.badge")
                    
                }
            }
        }
        .sheet(isPresented: $showAddNewNoteView) {
            NoteView(note: self.note)
        }
    }
    
    // Logout
    func logout() {
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
        }catch let signOutError as NSError {
            print("error signing out: %@", signOutError)
        }
        
    }
    
}


//#Preview {
//    NotesListView()
//}
