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
    
    static let shared = BluetoothHelper()
    var manager: CBCentralManager?
    
    var didUpdateCharacteristics:((CBCharacteristic?, CBPeripheral?) ->())?
    
    override init() {
        super.init()
        
        if manager == nil {
            manager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
        }
    }
    
    func scanForDevices() {
        //
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
}

//https://www.raywenderlich.com/231-core-bluetooth-tutorial-for-ios-heart-rate-monitor
