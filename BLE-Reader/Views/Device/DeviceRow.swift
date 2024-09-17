//
//  DeviceRow.swift
//  BLE-Reader
//
//  Created by Pasindu Vihangana on 2024-09-15.
//

import SwiftUI
import CoreBluetooth
import SwiftUIFontIcon

struct DeviceRow: View {
    var device: BluetoothDevice
    
    var body: some View {
        HStack(spacing: 20){
            // MARK: Peripheral Icon
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.icon.opacity(0.3))
                .frame(width: 44, height: 44)
                .overlay {
                    FontIcon.text(.awesome5Solid(code: device.icon), fontsize: 24, color: .white)
                }
            
            VStack(alignment: .leading, spacing: 6){
                // MARK: Peripheral Name
                Text(device.name)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                // MARK: Peripheral Info
//                let services = device.peripheral.services
//                ForEach(services) { service in
//                    Text(service.uuid)
//                        .font(.footnote)
//                        .opacity(0.7)
//                        .lineLimit(1)
//                }
                  
//                Text(device.manufacturer)
//                    .font(.footnote)
//                    .opacity(0.7)
//                    .lineLimit(1)
//                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // MARK: Transaction Amount
            Text("Connect")
                .bold()
                .foregroundColor(Color.text)
        }
        .padding([.top, .bottom], 8)
    }
}

//#Preview {
////    var bluetoothManager = BluetoothManager()
////    let bluetoothDevicePreviewData = bluetoothManager.getDevice(id: 0)
////    DeviceRow(device: bluetoothDevicePreviewData)
//}
