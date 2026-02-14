//
//  CLLocationCoordinate2D.swift
//  PyGps
//


import PySwiftKit
import PySwiftWrapper
import PySerializing

import CoreLocation


extension CLLocationCoordinate2D: @retroactive PySerializable {
    public static func casted(from object: PyPointer) throws -> CLLocationCoordinate2D {
        guard PyObject_TypeCheck(object, .PyTuple) else {
            print("CLLocationCoordinate2D only accepts Tuple[float, float] as type")
            throw PyStandardException.typeError
        }
        return try casted(unsafe: object)
    }
    
    public static func casted(unsafe object: PyPointer) throws -> CLLocationCoordinate2D {
        return .init(
            latitude: try PyTuple_GetItem(object, index: 0),
            longitude: try PyTuple_GetItem(object, index: 0)
        )
    }
    
    public func pyPointer() -> PyPointer {
        let new = PyTuple_New(2)!
        try? PyTuple_SetItem(new, index: 0, value: latitude)
        try? PyTuple_SetItem(new, index: 1, value: longitude)
        return new
    }
}
