//
//  SearchField.swift
//  GIF Search
//
//  Created by Viktorija on 24/11/2022.
//

import SwiftUI
import Combine

struct SearchField: View {
    @StateObject private var searchModel = SearchFieldModel()
    let placeHolder : String = "Search GIPHY"
    var action : (_ : String) -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField(placeHolder, text: $searchModel.text)
                .onReceive(
                    searchModel.$text.debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
                ) {
                    guard !$0.isEmpty else { return }
                    print(">> searching for: \($0)")
                    self.action($0)
                }
                .foregroundColor(.gray)
        }.padding(10)
        
    }
}

struct SearchField_Previews: PreviewProvider {
    static var previews: some View {
        SearchField(
            action: { _ in
                // do nothing
            })
    }
}
