//
//  File.swift
//  PyGps
//
import PySwiftKit
import PySwiftWrapper
import PySerializing

import CoreLocation


@PyClassByExtension(expr: """
    //init(uuid: UUID)
    
    public var major: UInt16? { get }

    public var minor: UInt16? { get }
""")
extension CLBeaconIdentityConstraint: @retroactive PySerializable, @retroactive PyClassProtocol {
    
    public func pyPointer() -> PyPointer {
        Self.asPyPointer(self)
    }
}
