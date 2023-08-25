//
//  TCA_TODO_SwiftUIApp.swift
//  TCA-TODO-SwiftUI
//
//  Created by Bekzhan Talgat on 25.08.2023.
//

import SwiftUI

@main
struct TCA_TODO_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            AppView(
                store: .init(initialState: Todos.State()) {
                    Todos()._printChanges()
                }
            )
        }
    }
}
