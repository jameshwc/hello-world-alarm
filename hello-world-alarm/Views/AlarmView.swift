//
//  ContentView.swift
//  hello-world-alarm
//
//  Created by James Hsu on 2023/11/14.
//

import SwiftUI

extension View {
    /// Sets the text color for a navigation bar title.
    /// - Parameter color: Color the title should be
    ///
    /// Supports both regular and large titles.
    @available(iOS 14, *)
    func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)
    
        // Set appearance for both normal and large sizes.
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor ]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor ]
    
        return self
    }
}

struct AlarmView: View {
    @State private var hour: Int = 0
    @State private var minute: Int = 0
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                Spacer()
                HStack{
                    Spacer()
                    Text("\(hour)").font(.title)
                    Spacer()
                    Text(":")
                    Spacer()
                    Text("\(minute)").font(.title)
                    Spacer()
                }
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
                Spacer()
            }
            .navigationTitle("Alarm").navigationBarTitleTextColor(.white)
            .padding()
        }
    }
}

#Preview {
    AlarmView().preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
