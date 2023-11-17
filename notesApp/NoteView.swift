//
//  NoteView.swift
//  notesApp
//
//  Created by Adesh Shah on 2023-11-17.
//

import SwiftUI


struct NoteView: View {
  @EnvironmentObject var model: NotesModel
  @Environment(\.dismiss) var dismissMe
  @State var note: Note
  
  var body: some View {
    NavigationStack {
      VStack {
        TextField("Title", text: $note.title)
          .font(.title)
          .frame(height: 30)
          .padding()
        
        TextEditor(text: $note.text)
          .background(
            .gray.opacity(0.2)
          )
          .padding()
      }
      .toolbar {
        ToolbarItem {
          Button("Save") {
            model.saveNote(note: note)
            dismissMe()
          }
        }
      }
    }
  }
}

