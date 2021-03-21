//
//  MainView.swift
//  Notes
//
//  Created by r00t on 21/3/21.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = MainViewModel()
    @State var newItem : Bool = false
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List{
                    ForEach(viewModel.noteVm) { noteVm in
                        NoteDetail(noteVm: noteVm)
                    }.onDelete{ index in
                        viewModel.deleteNote(at: index)
                    }
                }.listStyle(PlainListStyle())
            }
            .navigationBarTitle(Text("Notes"), displayMode: .inline)
            .navigationBarItems(trailing: NavigationButton(newItem: $newItem))
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct NoteDetail : View {
    @ObservedObject var noteVm : NoteViewModel
    @State var itemEdited : Bool = false
    var body: some View {
        ZStack(alignment: .leading, content: {
            NavigationLink(
                destination: NoteView(noteVm: noteVm, itemEdited: self.$itemEdited),
                isActive: self.$itemEdited,
                label: { EmptyView() }
            )
            .buttonStyle(PlainButtonStyle())
            .opacity(0.0)
            HStack {
                Text("\(noteVm.note.title )").font(.body)
                Spacer()
            }
        })
    }
}

struct NavigationButton : View {
    @Binding var newItem : Bool
    var body: some View {
        NavigationLink(
            destination: NewNoteView(newItem: self.$newItem),
            isActive: self.$newItem,
            label: {Image(systemName: "plus").resizable()}
        ).isDetailLink(false)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
