//
//  CLRegion.swift
//  PyGps
//
import PySwiftKit
import PySwiftWrapper
import PySerializing

import CoreLocation


@PyClassByExtension(expr: """


    init() 
    
    @available(iOS 4.0, *)
    open var identifier: String { get }

    @available(iOS 7.0, *)
    open var notifyOnEntry: Bool

    @available(iOS 7.0, *)
    open var notifyOnExit: Bool
""")
extension CLRegion: @retroactive PySerializable, @retroactive PyClassProtocol {
    public func pyPointer() -> PyPointer {
        Self.asPyPointer(self)
    }
}
