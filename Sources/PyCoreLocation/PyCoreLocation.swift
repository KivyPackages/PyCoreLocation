
import PySwiftKit
import PySwiftWrapper
import PySerializing

import CoreLocation


func test() {
    //CLBeaconIdentityConstraint(uuid: UUID)
    
}



@PyModule
struct PyCoreLocation: PyModuleProtocol {
    static let py_classes: [any (PyClassProtocol & AnyObject).Type] = [
        CLBeacon.self,
        CLBeaconIdentityConstraint.self,
        CLFloor.self,
        CLHeading.self,
        CLLocation.self,
        CLRegion.self,
        CLVisit.self,
        PyLocationManager.self
        
    ]
    
    static var pyserializableTypes: [(PySerializable.Type, String)] = [
        (CLAuthorizationStatus.self, "int"),
        (CLActivityType.self, "int"),
        (CLRegionState.self, "int"),
        (CLProximity.self, "int"),
        (CLDeviceOrientation.self, "int"),
        
        (CLLocationDistance.self, "float"),
        (CLLocationAccuracy.self, "float"),
        (CLLocationDirection.self, "float"),
        (CLLocationSpeed.self, "float"),
        (CLLocationSpeedAccuracy.self, "float"),
        
        (CLLocationCoordinate2D.self, "tuple[float, float]"),
    ]
}
