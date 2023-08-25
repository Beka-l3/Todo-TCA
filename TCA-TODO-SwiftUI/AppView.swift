//
//  AppView.swift
//  TCA-TODO-SwiftUI
//
//  Created by Bekzhan Talgat on 25.08.2023.
//
// Hello

import SwiftUI
import ComposableArchitecture

struct AppView: View {
    let store: StoreOf<Todos>
    
    var body: some View {
        WithViewStore(store, observe: ViewState.init) { viewStore in
            NavigationStack {
                VStack {
                    Picker("Filter", selection: viewStore.$filter.animation()) {
                        ForEach(Filter.allCases, id: \.self) { filter in
                            Text(filter.rawValue).tag(filter)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                    
                    List {
                        ForEachStore(
                            self.store.scope(state: \.filteredTodos, action: Todos.Action.todo(id:action:))
                        ) {
                            TodoView(store: $0)
                        }
                        .onDelete { viewStore.send(.delete($0)) }
                        .onMove { viewStore.send(.move($0, $1)) }
                    }
                }
                .navigationTitle("Todos")
                .navigationBarItems(
                    trailing: HStack(spacing: 20) {
                        EditButton()
                        
                        Button("Clear completed") {
                            viewStore.send(.clearCompletedButtonTapped, animation: .default)
                        }
                        .disabled(viewStore.isClearCompletedButtonDisabled)
                        
                        Button("Add todo") {
                            viewStore.send(.addTodoButtonTapped, animation: .default)
                        }
                    }
                )
                .environment(\.editMode, viewStore.$editMode)
                
            }
        }
    }
}


extension AppView {
    struct ViewState: Equatable {
        let isClearCompletedButtonDisabled: Bool
        
        @BindingViewState var editMode: EditMode
        @BindingViewState var filter: Filter
        
        init(store: BindingViewStore<Todos.State>) {
            self.isClearCompletedButtonDisabled = !store.todos.contains(where: \.isComplete)
            self._editMode = store.$editMode
            self._filter = store.$filter
        }
    }
}

extension IdentifiedArray where ID == Todo.State.ID, Element == Todo.State {
    static let mock: Self = [
        Todo.State(
            id: UUID(),
            description: "Check Mail",
            isComplete: false
        ),
        Todo.State(
            id: UUID(),
            description: "Buy Milk",
            isComplete: false
        ),
        Todo.State(
            id: UUID(),
            description: "Call Mom",
            isComplete: true
        ),
    ]
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(store: .init(
            initialState: Todos.State(),
            reducer: {
                Todos()
            }
        ))
        .preferredColorScheme(.dark)
    }
}
