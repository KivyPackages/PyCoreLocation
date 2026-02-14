//
//  CLHeading.swift
//  PyGps
//
import PySwiftKit
import PySwiftWrapper
import PySerializing

import CoreLocation

@PyClassByExtension(expr: """
    open var magneticHeading: CLLocationDirection { get }

    open var trueHeading: CLLocationDirection { get }

    open var headingAccuracy: CLLocationDirection { get }

    open var x: Double { get }

    open var y: Double { get }

    open var z: Double { get }

    open var timestamp: Date { get }    
""")
extension CLHeading: @retroactive PySerializable, @retroactive PyClassProtocol {
    public func pyPointer() -> PyPointer {
        Self.asPyPointer(self)
    }
}
