//
//  ButtonStyle.swift
//  GIF Search
//
//  Created by Viktorija on 24/11/2022.
//

import SwiftUI

struct ButtonStyle: View {
    @State private var tap:Bool = false
    var value : String
    var action : (_ : String) -> Void
    
    var body: some View {
        Button("\(value)", action: { self.action(self.value) })
        .font(.caption)
        .padding(10)
        .foregroundColor(tap ? Color.black : Color.gray)
        .background(tap ? Color(UIColor.lightGray) : Color.white)
        .cornerRadius(30)
    }
}

struct ButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        ButtonStyle(
            value: "DEMO",
            action: { text in
                print(text)
            }
        )
    }
}
