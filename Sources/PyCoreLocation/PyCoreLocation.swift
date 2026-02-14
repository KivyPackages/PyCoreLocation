
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
}
