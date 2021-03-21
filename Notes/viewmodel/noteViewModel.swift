//
//  noteViewModel.swift
//  Notes
//
//  Created by r00t on 21/3/21.
//

import Foundation
import Resolver
import Combine

class NoteViewModel : ObservableObject, Identifiable {
    @Injected var repository : Repository
    
    @Published var note : NoteEntity
    
    private var cancellables = Set<AnyCancellable>()
    
    init(note: NoteEntity) {
        self.note = note
    }
    
    func update() {
        repository.editNote(entity: note)
    }
}
