//
//  noteView.swift
//  Notes
//
//  Created by r00t on 21/3/21.
//

import SwiftUI

struct NoteView: View {
    @ObservedObject var noteVm : NoteViewModel
    @Binding var itemEdited : Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 15.0){
            TextField("Note's title", text: Binding<String>(
                get: {(self.noteVm.note.title) },
                set: {self.noteVm.note.title = $0}
            ))
            .lineLimit(1)
            .textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                
            TextEditor(text: Binding<String>(
                get: {self.noteVm.note.content},
                set: {self.noteVm.note.content = $0}
            ))
            .overlay(RoundedRectangle(
                        cornerRadius: 8)
                        .stroke(Color(UIColor.systemGray.cgColor), lineWidth: 0.25)).padding(.horizontal)
            Button(
                action: {
                    self.noteVm.update()
                    self.itemEdited = false
                },
                label: { Text("Save") }
            ).padding()
        }
    }
}

#if DEBUG
struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(noteVm: NoteViewModel(note: NoteEntity(id: UUID().uuidString, title: "abc",content: "123")), itemEdited: .constant(false))
    }
}
#endif
