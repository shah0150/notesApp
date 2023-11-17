//
//  NotesModel.swift
//  notesApp
//
//  Created by Adesh Shah on 2023-11-17.
//

import SwiftUI
import Firebase

class NotesModel: ObservableObject {
  @Published var notes: [Note] = []
  private let notesCollectionRef = Firestore.firestore().collection("Notes")
  
  init() {
    fetchAllNotes()
  }
  
  func fetchAllNotes() {
    self.notes.removeAll()
    notesCollectionRef.getDocuments {
      snapshot,
      error in
      guard error == nil else {
        print(error?.localizedDescription as Any)
        return
      }
      
      if let snapshot = snapshot {
        for document in snapshot.documents {
          let data = document.data()
          
          let id = data["id"] as? String ?? ""
          let title = data["title"] as? String ?? ""
          let text = data["text"] as? String ?? ""
          
          let note = Note(
            id: id,
            title: title,
            text: text
          )
          self.notes.append(note)
        }
      }
    }
  }
  
  func saveNote(note: Note){
    let ref = notesCollectionRef.document(note.id)
    
    ref.setData(
      [
        "id": note.id,
        "title": note.title,
        "text":note.text
      ]
    ) {
      error in
      if let error = error {
        print(error.localizedDescription)
      } else {
        if !self.notes.contains(where: { $0.id == note.id }) {
          self.notes.append(note)
        }
      }
    }
  }
    
    func deleteNote(note: Note) {
        let ref = notesCollectionRef.document(note.id)
        
        ref.delete() { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Note deleted.")
            }
        }
    }
}

