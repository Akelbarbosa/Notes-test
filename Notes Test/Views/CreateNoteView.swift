//
//  CreateNoteView.swift
//  Notes Test
//
//  Created by Akel Barbosa on 24/03/24.
//

import SwiftUI

struct CreateNoteView: View {
    var viewModel: ViewModel
    @State var title: String = ""
    @State var text: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("", text: $title, prompt: Text("*Título"), axis: .vertical)
                    TextField("", text: $text, prompt: Text("*Texto"), axis: .vertical)
                } footer: {
                    Text("* Título es obligatorio")
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cerrar")
                    }
                }
                ToolbarItem {
                    Button {
                        viewModel.createNoteWith(title: title, text: text)
                        dismiss()
                    } label: {
                        Text("Crear Nota")
                            .bold()
                    }
                }
            }
            .navigationTitle("Nueva Nota")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    CreateNoteView(viewModel: .init())
}
