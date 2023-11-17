//
//  NotesListView.swift
//  notesApp
//
//  Created by Adesh Shah on 2023-11-17.
//

import SwiftUI
import Firebase

struct NotesListView: View {
  @EnvironmentObject var model: NotesModel
  @State var showAddNewNoteView = false
  @State var note = Note()
  
  var body: some View {
    List(model.notes, id: \.id) { note in
      Text(note.title)
        .onTapGesture {
          self.note = note
          showAddNewNoteView.toggle()
        }
    }
    .navigationTitle("Notes")
    .toolbar {
      ToolbarItem {
        Button {
          self.note = Note()
          showAddNewNoteView.toggle()
        } label: {
          Image(systemName: "note.text.badge.plus")
        }
      }
    }
    .sheet(isPresented: $showAddNewNoteView) {
      NoteView(note: self.note)
    }
  }
}


#Preview {
    NotesListView()
}
