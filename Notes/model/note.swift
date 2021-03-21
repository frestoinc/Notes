//
//  note.swift
//  Notes
//
//  Created by r00t on 21/3/21.
//

import Foundation


struct NoteEntity: Codable, Identifiable{
    var id: String
    var title : String
    var content : String
}
