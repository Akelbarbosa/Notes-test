//
//  ContentView.swift
//  Notes Test
//
//  Created by Akel Barbosa on 24/03/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var viewModel: ViewModel = .init()
    @State var showCreateNote: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.notes) { note in
                    NavigationLink(value: note) {
                        VStack(alignment: .leading)  {
                            Text(note.title)
                                .foregroundStyle(.primary)
                            Text(note.getText)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .status) {
                    Button {
                        showCreateNote.toggle()
                    } label: {
                         Label("crear Nota", systemImage: "square.and.pencil")
                            .labelStyle(TitleAndIconLabelStyle())
                    }
                    .buttonStyle(.bordered)
                    .tint(.blue)
                    .bold()
                }
                
            }
            .navigationTitle("Notas")
            .navigationDestination(for: Note.self, destination: { note in
                UpdateNoteView(viewModel: viewModel, id: note.id, title: note.title, text: note.getText)
            })
            .fullScreenCover(isPresented: $showCreateNote, content: {
                CreateNoteView(viewModel: viewModel)
            })
        }
    }

}

#Preview {
    ContentView(viewModel: .init(notes: [
        .init(title: "First", text: "text of the notes", createAt: .now),
        .init(title: "Second", text: "second text of the notes", createAt: .now),
    ]))
}
