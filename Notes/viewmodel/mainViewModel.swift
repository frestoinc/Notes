//
//  mainViewModel.swift
//  Notes
//
//  Created by r00t on 21/3/21.
//

import Foundation
import Resolver
import Combine

class MainViewModel : ObservableObject {
    @Published var repository : Repository = Resolver.resolve()
    @Published var noteVm = [NoteViewModel]()

    private var cancellables = Set<AnyCancellable>()
        
    init() {
        repository.$notes.map { notes in
            notes.map { note in
                NoteViewModel(note: note)
            }
        }
        .assign(to: \.noteVm, on: self)
        .store(in: &cancellables)
    }
        
    func deleteNote(at index: IndexSet) {
        let viewModels = index.lazy.map { self.noteVm[$0] }
            viewModels.forEach { row in
                repository.deleteNote(entity: row.note)
        }
    }
}
