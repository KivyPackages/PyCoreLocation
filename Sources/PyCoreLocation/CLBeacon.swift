//
//  CLBeacon.swift
//  PyGps
//
import PySwiftKit
import PySwiftWrapper
import PySerializing

import CoreLocation

//extension NSNumber: @retroactive PySerialize {
//}
//
//fileprivate extension PySerialize where Self: NSNumber {
//    func pyPointer() -> PyPointer {
//        <#code#>
//    }
//}

@PyClassByExtension(expr: """
    @available(iOS 13.0, *)
    open var timestamp: Date { get }

    @available(iOS 13.0, *)
    //open var uuid: UUID { get }

    //@NSCopying open var major: NSNumber { get }

    //@NSCopying open var minor: NSNumber { get }

    open var proximity: CLProximity { get }

    open var accuracy: CLLocationAccuracy { get }

    open var rssi: Int { get }
""")
@available(iOS 7.0, *)
extension CLBeacon : @retroactive PySerializable, @retroactive PyClassProtocol {
    
    @PyProperty var id: String { uuid.uuidString }
    
    public func pyPointer() -> PyPointer {
        Self.asPyPointer(self)
    }
}
