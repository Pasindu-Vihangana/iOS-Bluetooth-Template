//
//  DeviceList.swift
//  BLE-Reader
//
//  Created by Pasindu Vihangana on 2024-09-15.
//

import SwiftUI
import CoreBluetooth

struct DeviceList: View {
    @State var bluetoothManager : BluetoothViewModel
    @State private var runScan: Int = 0
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack {
                    HStack {
                        // MARK: Header Title
                        Text("Bluetooth Devices")
                            .bold()
                        
                        Spacer()
                        
                        // MARK: Header Link
                        HStack(spacing: 4) {
                            Button(action: {
                                runScan += 1
//                                bluetoothManager.startScanning()
//                                while true {
//                                    print(bluetoothManager.isScanning)
//                                    if !bluetoothManager.isScanning {
//                                        runScan += 1
//                                        break
//                                    }
//                                }
                            }) {
                                Text("Scan")
                                Image(systemName: "arrow.clockwise")
                            }
                            
                        }
                        .foregroundColor(Color.text)
                    }
                    .padding(.top)
                    
                    //MARK: Device List
                    VStack {
                        let devices = bluetoothManager.getDevices()
                        ForEach(devices, id: \.self) { device in
                            DeviceRow(device: device)
                        }
                    }
                    .id(runScan)
                }
                .padding()
                .background(Color.background)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: Color.primary.opacity(0.2), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 5)
            }
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
        .accentColor(.primary)
    }
}
//
//#Preview {
//    @ObservedObject var bluetoothManager = BluetoothViewModel()
//    DeviceList(bluetoothManager : bluetoothManager)
//}
