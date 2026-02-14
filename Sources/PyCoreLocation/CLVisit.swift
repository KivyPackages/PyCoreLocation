//
//  CLVisit.swift
//  PyGps
//
import PySwiftKit
import PySwiftWrapper
import PySerializing

import CoreLocation

@PyClassByExtension(expr: """
    open var arrivalDate: Date { get }

    open var departureDate: Date { get }

    open var coordinate: CLLocationCoordinate2D { get }

    open var horizontalAccuracy: CLLocationAccuracy { get }
""")
extension CLVisit: @retroactive PySerializable {
    public func pyPointer() -> PyPointer {
        Self.asPyPointer(self)
    }
}
