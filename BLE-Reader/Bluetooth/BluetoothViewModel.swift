//
//  BluetoothViewModel.swift
//  nRF Reader
//
//  Created by Pasindu Vihangana on 2024-09-17.
//

import CoreBluetooth
import SwiftUIFontIcon
import UIKit


struct CBUUIDs{
    static let kBLEService_UUID = "6e400001-b5a3-f393-e0a9-e50e24dcca9e"
    static let kBLE_Characteristic_uuid_Tx = "6e400002-b5a3-f393-e0a9-e50e24dcca9e"
    static let kBLE_Characteristic_uuid_Rx = "6e400003-b5a3-f393-e0a9-e50e24dcca9e"
    static let MaxCharacters = 20

    static let BLEService_UUID = CBUUID(string: kBLEService_UUID)
    static let BLE_Characteristic_uuid_Tx = CBUUID(string: kBLE_Characteristic_uuid_Tx)//(Property = Write without response)
    static let BLE_Characteristic_uuid_Rx = CBUUID(string: kBLE_Characteristic_uuid_Rx)// (Property = Read/Notify)
}


struct BluetoothDevice: Identifiable, Hashable {
    let id: Int
    let name: String
    let peripheral: CBPeripheral
    let icon: FontAwesomeCode
}

class BlePeripheral {
 static var connectedPeripheral: CBPeripheral?
 static var connectedService: CBService?
 static var connectedTXChar: CBCharacteristic?
 static var connectedRXChar: CBCharacteristic?
}



class BluetoothViewModel: NSObject, ObservableObject, CBCentralManagerDelegate {
    private var centralManager: CBCentralManager?
    private var timer = Timer()
    
    private var discoveredPeripherals: [CBPeripheral] = []
    private var discoveredDeviceCount: Int = 0
    @Published var discoveredDevices: [BluetoothDevice] = []
    
    @Published var isScanning: Bool = false
    
    
    
    override init() {
        print("[BluetoothVeiwModel] -> init")
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: .main)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        var state : String
        switch central.state {
        case .poweredOn:
            state = "Powered ON"
            self.startScanning()
        case .poweredOff:
            state = "Powered OFF"
            // TODO: Add UIAlertController
        case .resetting:
            state = "Resetting"
        case .unauthorized:
            state = "Unauthorized"
        case .unsupported:
            state = "Unsupported"
        default:
            state = "Unknown"
        }
        
        print("[Callback] Central Manager did update state to: \(state)")
    }
    
    func startScanning() -> Void {
        // Start Scanning
        print("Scanning Started...")
        isScanning = true
        self.discoveredDevices.removeAll()
        self.discoveredPeripherals.removeAll()
        self.discoveredDeviceCount = 0
        centralManager?.scanForPeripherals(withServices: nil)
        Timer.scheduledTimer(withTimeInterval: 10, repeats: false) {_ in
            self.stopScanning()
        }
    }
    
    func stopTimer() -> Void {
        // Stops Timer
        self.timer.invalidate()
    }

    func stopScanning() -> Void {
        print("Scanning Stopped!")
        print("Discovered \(discoveredPeripherals.count) devices")
        
        centralManager?.stopScan()
        isScanning = false
        
        Timer.scheduledTimer(withTimeInterval: 10, repeats: false) {_ in
            self.startScanning()
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("did discover")
        if !discoveredPeripherals.contains(peripheral) {
            self.discoveredPeripherals.append(peripheral)
            self.discoveredDeviceCount += 1
            let newDevice = BluetoothDevice(
                id: discoveredDeviceCount,
                name: peripheral.name ?? "N/A",
                peripheral: peripheral,
                icon: .dumbbell
            )
            self.discoveredDevices.append(newDevice)
        }
        
        print("Peripheral name: \(peripheral.name ?? "N/A")")
//        print("Peripheral Discovered: \(peripheral)")
//        print ("Advertisement Data : \(advertisementData)")
        
//        centralManager?.stopScan()
    }
    
    func getDevice(id: Int) -> BluetoothDevice{
        print("device loaded")
        return discoveredDevices[id]
    }
    
    func getDevices() -> [BluetoothDevice]{
        print("devices loaded")
        print(discoveredDevices.count)
        return discoveredDevices
    }
}
