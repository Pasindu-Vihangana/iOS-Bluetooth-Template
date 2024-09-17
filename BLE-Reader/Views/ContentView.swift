//
//  ContentView.swift
//  BLE-Reader
//
//  Created by Pasindu Vihangana on 2024-08-09.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var bluetoothManager = BluetoothViewModel()
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading, spacing: 24) {
                    // MARK: Title
                    HStack {
                        // MARK: Header Title
                        Text("Bluetooth Scanner")
                            .font(.title2)
                            .bold()
                        
                        Spacer()
                        
                        // MARK: Header Link
                        NavigationLink {
                            DeviceList(bluetoothManager: bluetoothManager)
                        } label: {
                            HStack(spacing: 4) {
                                Text("Scan")
                                Image(systemName: "dot.radiowaves.left.and.right")
                            }
                            .foregroundColor(Color.text)
                        }
                    }
                    .padding(.top)
                }
                .padding()
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            }
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                // MARK: Scan Icons
                NavigationLink {
                    // Settings
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "gear")
                    }
                    .foregroundColor(Color.text)
                }
            }
        }
        .navigationViewStyle(.stack)
        .accentColor(.primary)
    }
}

#Preview {
    ContentView()
}
