//
//  BluetoothHelper.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 27/08/2020.
//

import UIKit
import CoreBluetooth

protocol BluetoothInterface {
    func scanForDevices()
    func stopScan()
    func disconnect()
}

class BluetoothHelper: NSObject, BluetoothInterface {
    
    let pm5CBUUID = CBUUID(string: "CE060000-43E5-11E4-916C-0800200C9A66")
    
    static let shared = BluetoothHelper()
    var manager: CBCentralManager?
    var pm5Peripheral: CBPeripheral!
    
    var didUpdateCharacteristics:((CBCharacteristic?, CBPeripheral?) ->())?
    
    override init() {
        super.init()
        
        if manager == nil {
            manager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
        }
    }
    
    func scanForDevices() {
        if let deviceManager = self.manager, deviceManager.state == .poweredOn {
            deviceManager.scanForPeripherals(withServices: [pm5CBUUID], options: nil)
        } else {
            print("Bluetooth has not been enabled.")
        }
    }
    
    func stopScan() {
        //
    }
    
    func disconnect() {
        //
    }
    
    
}

extension BluetoothHelper: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        // Need to read PM5 docs.
        switch central.state {
            
        case .unknown:
            print("State is unknown.")
        case .resetting:
            print("State is resetting.")
        case .unsupported:
            print("State is unsupported.")
        case .unauthorized:
            print("State is unauthorised.")
        case .poweredOff:
            print("State is Off.")
        case .poweredOn:
            print("State is On.")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        //print(peripheral)
        pm5Peripheral = peripheral
        manager?.stopScan()
        print(pm5Peripheral)
    }
}

//https://www.raywenderlich.com/231-core-bluetooth-tutorial-for-ios-heart-rate-monitor
// https://www.concept2.com/files/pdf/us/monitors/PM5_BluetoothSmartInterfaceDefinition.pdf
