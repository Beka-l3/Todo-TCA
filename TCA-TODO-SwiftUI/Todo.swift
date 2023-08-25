//
//  Todo.swift
//  TCA-TODO-SwiftUI
//
//  Created by Bekzhan Talgat on 25.08.2023.
//

import Foundation
import ComposableArchitecture

struct Todo: Reducer {
    struct State: Equatable, Identifiable {
        let id: UUID
        
        @BindingState var description: String = ""
        @BindingState var isComplete: Bool = false
    }
    
    enum Action: BindableAction, Equatable, Sendable {
        case binding(BindingAction<State>)
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
    }    
}
