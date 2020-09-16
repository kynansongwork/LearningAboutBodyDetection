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
        pm5Peripheral.delegate = self
        manager?.stopScan()
        
        //TODO: Will need to move this to somewhere where selection can be done, in cases of more than one machine.
        print(pm5Peripheral)
        manager?.connect(pm5Peripheral)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected son!")
        pm5Peripheral.discoverServices(nil)
    }
}

extension BluetoothHelper: CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        
        guard let pm5Services = peripheral.services else { return }
        
        for service in pm5Services {
            print(service)
        }
    }
}

//https://www.raywenderlich.com/231-core-bluetooth-tutorial-for-ios-heart-rate-monitor
// https://www.concept2.com/files/pdf/us/monitors/PM5_BluetoothSmartInterfaceDefinition.pdf
