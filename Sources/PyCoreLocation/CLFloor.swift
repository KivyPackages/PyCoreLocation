//
//  CLFloor.swift
//  PyGps
//
import PySwiftKit
import PySwiftWrapper
import PySerializing

import CoreLocation


@PyClassByExtension(expr: """
    open var level: Int { get }

""")
extension CLFloor: @retroactive PySerializable, @retroactive PyClassProtocol {
    
    public func pyPointer() -> PyPointer {
        Self.asPyPointer(self)
    }
}


