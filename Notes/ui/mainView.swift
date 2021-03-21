//
//  MainView.swift
//  Notes
//
//  Created by r00t on 21/3/21.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = MainViewModel()
    @State var itemEdited : Bool = false
    @State var newItem : Bool = false
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List{
                    ForEach(viewModel.noteVm) { noteVm in
                        NoteDetail(noteVm: noteVm, itemEdited: self.$itemEdited)
                    }.onDelete{ index in
                        viewModel.deleteNote(at: index)
                    }
                }.listStyle(PlainListStyle())
            }
            .navigationBarTitle(Text("Notes"), displayMode: .inline)
            .navigationBarItems(trailing: NavigationButton(newItem: self.$newItem))
        }
    }
}

struct NoteDetail : View {
    @ObservedObject var noteVm : NoteViewModel
    @Binding var itemEdited : Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 0, content: {
            NavigationLink(
                destination: NoteView(noteVm: noteVm, itemEdited: self.$itemEdited), isActive: self.$itemEdited) {
                EmptyView()
            }.hidden()
            Button(
                action: { self.itemEdited = true },
                label: { Text("\(noteVm.note.title )") }
            )
        })
    }
}

struct NavigationButton : View {
    @Binding var newItem : Bool
    var body: some View {
        VStack {
            NavigationLink(
                destination: NewNoteView(newItem: self.$newItem), isActive: self.$newItem) {
                EmptyView()
            }
            Button(
                action: { self.newItem = true },
                label: { Image(systemName: "plus").resizable() }
            )
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
