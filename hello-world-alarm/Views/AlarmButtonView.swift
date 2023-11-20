//
//  AlarmButtonView.swift
//  hello-world-alarm
//
//  Created by James Hsu on 2023/11/16.
//

import SwiftUI

struct AlarmButtonView: View {
    var label: String
    var action: ()->Void
    var body: some View {
        HStack {
            Spacer()
            Button(label, action: action)
            .padding()
            .background(.orange)
            .clipShape(Capsule())
            .foregroundColor(.black)
            .bold()
            Spacer()
        }
    }
}

#Preview {
    AlarmButtonView(label: "Button", action: {}).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
