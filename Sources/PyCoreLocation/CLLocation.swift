//
//  CLLocation.swift
//  PyCoreLocation
//
import PySwiftKit
import PySwiftWrapper
import PySerializing

import CoreLocation


@PyClassByExtension(expr: """
    open var coordinate: CLLocationCoordinate2D { get }

    open var altitude: CLLocationDistance { get }

    open var horizontalAccuracy: CLLocationAccuracy { get }

    open var verticalAccuracy: CLLocationAccuracy { get }

    open var course: CLLocationDirection { get }

    //open var courseAccuracy: CLLocationDirectionAccuracy { get }

    open var speed: CLLocationSpeed { get }

    open var speedAccuracy: CLLocationSpeedAccuracy { get }

    open var timestamp: Date { get }

    @NSCopying open var floor: CLFloor? { get }

    open func distance(from location: CLLocation) -> CLLocationDistance

    public init(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
""")
extension CLLocation: @retroactive PySerializable {
    
    public func pyPointer() -> PyPointer {
        Self.asPyPointer(self)
    }
}
