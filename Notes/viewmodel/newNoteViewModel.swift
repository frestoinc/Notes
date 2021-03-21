//
//  newNoteViewModel.swift
//  Notes
//
//  Created by r00t on 21/3/21.
//

import Foundation
import Resolver
import Combine

class NewNoteViewModel : ObservableObject, Identifiable {
    @Injected private var repository : Repository
    
    @Published var title : String = ""
    @Published var content : String = ""
    
    func reset() {
        self.title = ""
        self.content = ""
    }
    
    func addNote() {
        if (title.isEmpty || content.isEmpty) {
            return
        }
        repository.addNote(entity: NoteEntity(id: UUID().uuidString, title: title.isEmpty ? "New Note" : title, content: content))
    }
}
