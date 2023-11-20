//
//  AlarmPickerView.swift
//  hello-world-alarm
//
//  Created by James Hsu on 2023/11/15.
//

import SwiftUI

struct AlarmPickerView: View {
    @Binding var hour: Int
    @Binding var minute: Int
    var body: some View {
        HStack{
            Picker("Hour", selection: $hour){
                ForEach((0..<24), id:\.self) { number in
                    Text("\(number)")
                }
            }.pickerStyle(.wheel)
            Text(":")
            Picker("Minute", selection: $minute) {
                ForEach((0..<60)) { number in
                    Text(String(format: "%02d", number))
                }
            }.pickerStyle(.wheel)
        }
    }
}

#Preview {
    AlarmPickerView(hour: .constant(0), minute: .constant(0))
}
