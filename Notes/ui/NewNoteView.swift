//
//  NewNoteView.swift
//  Notes
//
//  Created by r00t on 21/3/21.
//

import SwiftUI

struct NewNoteView: View {
    @ObservedObject var viewmodel : NewNoteViewModel
    @Binding var itemEdited : Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 15.0){
            TextField("Note's title", text: Binding<String>(
                get: {(self.viewmodel.title) },
                set: {self.viewmodel.title = $0}
            ))
            .lineLimit(1)
            .textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                
            TextEditor(text: Binding<String>(
                get: {self.viewmodel.content},
                set: {self.viewmodel.content = $0}
            ))
            .overlay(RoundedRectangle(
                        cornerRadius: 8)
                        .stroke(Color(UIColor.systemGray.cgColor), lineWidth: 0.25)).padding(.horizontal)
            Button(
                action: {
                    self.viewmodel.addNote()
                    self.itemEdited = false
                },
                label: { Text("Save") }
            ).padding()
        }
    }
}


//struct newNotevoew_Previews: PreviewProvider {
//    static var previews: some View {
//        NewNoteView()
//    }
//}
