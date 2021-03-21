//
//  reposiotry.swift
//  Notes
//
//  Created by r00t on 21/3/21.
//

import Foundation
import Disk

class ListRepository {
    @Published var notes = [NoteEntity]()
}

protocol IRepository {
    func addNote(entity : NoteEntity)
    func deleteNote(entity : NoteEntity)
    func editNote(entity : NoteEntity)
}

class Repository : ListRepository, IRepository, ObservableObject {
    
    override init() {
        super.init()
        loadAllNotes()
    }
    
    func addNote(entity: NoteEntity) {
        self.notes.append(entity)
        saveNotes()
        loadAllNotes()
    }
    
    func deleteNote(entity: NoteEntity) {
        if let i = self.notes .firstIndex(where: {$0.id == entity.id }) {
            self.notes.remove(at: i)
            saveNotes()
        }
    }
    
    func editNote(entity: NoteEntity) {
        if let i = self.notes.firstIndex(where: { $0.id == entity.id }) {
            self.notes[i] = entity
            saveNotes()
        } else {
            addNote(entity: entity)
        }
    }
    
    private func loadAllNotes() {
        if let loadData = try? Disk.retrieve("notes.json", from: .documents, as: [NoteEntity].self) {
            self.notes = loadData
        }
    }
    
    
    private func saveNotes(){
        do {
          try Disk.save(self.notes, to: .documents, as: "notes.json")
        }
        catch let error as NSError {
            print(error)
        }
    }
}
