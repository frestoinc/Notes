//
//  NewNoteView.swift
//  Notes
//
//  Created by r00t on 21/3/21.
//

import SwiftUI

struct NewNoteView: View {
    @ObservedObject var viewModel = NewNoteViewModel()
    @Environment(\.presentationMode) var presentationMode
    @Binding var newItem : Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 15.0){
            TextField("Note's title", text: $viewModel.title)
            .lineLimit(1)
            .textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                
            TextEditor(text: $viewModel.content)
            .overlay(RoundedRectangle(
                        cornerRadius: 8)
                        .stroke(Color(UIColor.systemGray.cgColor), lineWidth: 0.25)).padding(.horizontal)
            Button(
                action: {
                    self.viewModel.addNote()
                    self.newItem = false //doesnt work, not sure why. and since view is not destroyed, data is persisted.
                    presentationMode.wrappedValue.dismiss()
                },
                label: { Text("Add Note") }
            ).padding()
        }.navigationBarTitle("New Note")
        .onDisappear {viewModel.reset()}
    }
}

#if DEBUG
struct NewNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NewNoteView(viewModel: NewNoteViewModel(), newItem: .constant(false))
    }
}
#endif
