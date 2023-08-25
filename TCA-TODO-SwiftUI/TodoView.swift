//
//  TodoView.swift
//  TCA-TODO-SwiftUI
//
//  Created by Bekzhan Talgat on 25.08.2023.
//

import SwiftUI
import ComposableArchitecture

struct TodoView: View {
    let store: StoreOf<Todo>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            HStack {
                Button {
                    viewStore.$isComplete.wrappedValue.toggle()
                } label: {
                    Image(systemName: viewStore.isComplete ? "checkmark.square" : "square" )
                }
                .buttonStyle(.plain)
                
                TextField("Untitled Todo", text: viewStore.$description)
            }
            .foregroundColor(viewStore.isComplete ? .gray : nil)
        }
    }
}


struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView(store: .init(
            initialState: Todo.State(id: .init()),
            reducer: {
                Todo()
            })
        )
    }
}


