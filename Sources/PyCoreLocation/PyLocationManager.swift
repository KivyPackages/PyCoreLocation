//
//  CLLocationManager.swift
//  PyGps
//
import PySwiftKit
import PySwiftWrapper
import PySerializing

import CoreLocation


@PyClass
public final class PyLocationManager {
    
    fileprivate static let sharedInstance = PyLocationManager()
    
    let manager: CLLocationManager = .init()
    
    private var callbacks: [Callbacks] = []
    
    private var pyInstance: PyPointer?
    
    init() {
        
    }
    
    @PyMethod
    public static func shared() -> PyLocationManager { sharedInstance }
    
    @PyMethod
    public func add_callback(callback: PyPointer) throws {
        callbacks.append(try .init(object: callback))
    }
    
    @PyMethod
    public func remove_callback(callback: PyPointer) {
        callbacks.removeAll { cb in
            cb.py_target == callback
        }
    }
    
    @PyMethod
    public static func locationServicesEnabled() -> Bool {
        CLLocationManager.locationServicesEnabled()
    }
    
    @PyMethod
    public static func headingAvailable() -> Bool {
        CLLocationManager.headingAvailable()
    }
    
    @PyMethod
    public static func significantLocationChangeMonitoringAvailable() -> Bool {
        CLLocationManager.significantLocationChangeMonitoringAvailable()
    }
    
    @PyProperty
    public var authorizationStatus: CLAuthorizationStatus {
        if #available(iOS 14, *) {
            manager.authorizationStatus
        } else {
            CLLocationManager.authorizationStatus()
        }
    }
    
//    @available(iOS 14.0, *)
//    open var accuracyAuthorization: CLAccuracyAuthorization { get }
//    
//
//    @available(iOS 14.0, *)
//    open var isAuthorizedForWidgetUpdates: Bool { get }
    
    //weak open var delegate: (any CLLocationManagerDelegate)?
    
    @PyProperty()
    public var activityType: CLActivityType {
        get { manager.activityType }
        set { manager.activityType = newValue }
    }
    
    @PyProperty()
    public var distanceFilter: CLLocationDistance {
        get { manager.distanceFilter }
        set { manager.distanceFilter = newValue }
    }
    
    @PyProperty()
    public var desiredAccuracy: CLLocationAccuracy {
        get { manager.desiredAccuracy }
        set { manager.desiredAccuracy = newValue }
    }
    
    @PyProperty()
    public var pausesLocationUpdatesAutomatically: Bool {
        get { manager.pausesLocationUpdatesAutomatically }
        set { manager.pausesLocationUpdatesAutomatically = newValue }
    }
    
    @PyProperty()
    public var allowsBackgroundLocationUpdates: Bool {
        get { manager.allowsBackgroundLocationUpdates }
        set { manager.allowsBackgroundLocationUpdates = newValue }
    }
    
    @PyProperty()
    public var showsBackgroundLocationIndicator: Bool {
        get { manager.showsBackgroundLocationIndicator }
        set { manager.showsBackgroundLocationIndicator = newValue }
    }
    
    @PyProperty()
    public var location: CLLocation? { manager.location }
    
    @PyProperty()
    public var headingFilter: Double {
        get { manager.headingFilter }
        set { manager.headingFilter = newValue }
    }
    
    @PyProperty()
    public var headingOrientation: CLDeviceOrientation {
        get { manager.headingOrientation }
        set { manager.headingOrientation = newValue }
    }
    
    @PyProperty()
    public var heading: CLHeading? { manager.heading }
    
    @PyProperty()
    public var maximumRegionMonitoringDistance: CLLocationDistance { manager.maximumRegionMonitoringDistance }
    
    @PyProperty()
    public var monitoredRegions: Set<CLRegion> { manager.monitoredRegions }
    
//    @available(iOS, introduced: 7.0, deprecated: 13.0, message: "Use -rangedBeaconConstraints")
//    open var rangedRegions: Set<CLRegion> { get }
    
    @available(iOS 13.0, *)
    @PyProperty()
    public var rangedBeaconConstraints: Set<CLBeaconIdentityConstraint> { manager.rangedBeaconConstraints }
    
    @PyMethod
    public func requestWhenInUseAuthorization() { manager.requestWhenInUseAuthorization() }
    
    @PyMethod
    public func requestAlwaysAuthorization() { manager.requestAlwaysAuthorization() }
    
    @PyMethod
    public func requestTemporaryFullAccuracyAuthorization(withPurposeKey purposeKey: String, completion: @escaping @Sendable (String?) -> Void) {
        if #available(iOS 15, *) {
            manager.requestTemporaryFullAccuracyAuthorization(withPurposeKey: purposeKey) { err in
                completion(err?.localizedDescription)
            }
        }
    }
    
    @PyMethod
    public func startUpdatingLocation() { manager.startUpdatingLocation() }
    
    @PyMethod
    public func stopUpdatingLocation() { manager.stopUpdatingLocation() }
    
    @PyMethod
    public func requestLocation() { manager.requestLocation() }
    
    @PyMethod
    public func startUpdatingHeading() { manager.startUpdatingHeading() }
    
    @PyMethod
    public func stopUpdatingHeading() { manager.stopUpdatingHeading() }
    
    @PyMethod
    public func dismissHeadingCalibrationDisplay() { manager.dismissHeadingCalibrationDisplay() }
    
    @PyMethod
    public func startMonitoringSignificantLocationChanges() { manager.startMonitoringSignificantLocationChanges() }
    
    @PyMethod
    public func stopMonitoringSignificantLocationChanges() { manager.stopMonitoringSignificantLocationChanges() }
    
    @PyMethod
    public func startMonitoringLocationPushes(completion: @escaping @Sendable (Data?, String?) -> Void) {
        if #available(iOS 15, *) {
            manager.startMonitoringLocationPushes { data, err in
                completion(data, err?.localizedDescription)
            }
        }
    }
    
    //@available(iOS 15.0, *)
    @PyMethod
    public func stopMonitoringLocationPushes() {
        if #available(iOS 15, *) {
            manager.stopMonitoringLocationPushes()
        }
    }
    
    @PyMethod
    public func stopMonitoring(for region: CLRegion) { manager.stopMonitoring(for: region) }
    
    @PyMethod
    public func startMonitoring(for region: CLRegion) { manager.startMonitoring(for: region) }
    
    @PyMethod
    public func requestState(for region: CLRegion) { manager.requestState(for: region) }
    
    @available(iOS 13.0, *)
    @PyMethod
    public func startRangingBeacons(satisfying constraint: CLBeaconIdentityConstraint) { manager.startRangingBeacons(satisfying: constraint) }
    
    @available(iOS 13.0, *)
    @PyMethod
    public func stopRangingBeacons(satisfying constraint: CLBeaconIdentityConstraint) { manager.stopRangingBeacons(satisfying: constraint) }
    
}

extension PyLocationManager: PySerializable {
    
    public func pyPointer() -> PyPointer {
        if let pyInstance { return Py_NewRef(pyInstance) }
        // adding PyLocationManager as weak ref in the PyInstance, but always passing same py ref.
        // how keep a singleton in PySwiftKit in general
        let new = Self.asPyPointer(unretained: self)
        pyInstance = new
        return Py_NewRef(pyInstance)
    }
}

extension PyLocationManager {
    
    @PyContainer
    public final class Callbacks: NSObject {
        
        private weak var py_manager: PyLocationManager?
        
        @PyCall func didChangeAuthorization(_ manager: PyLocationManager)
        
        @PyCall func didPauseLocationUpdates(_ manager: PyLocationManager)
        
        @PyCall func didResumeLocationUpdates(_ manager: PyLocationManager)
        
        @PyCall func shouldDisplayHeadingCalibration(_ manager: PyLocationManager) throws -> Bool
        
        @PyCall func didVisit(_ manager: PyLocationManager, _ visit: CLVisit)
        
        @PyCall func didExitRegion(_ manager: PyLocationManager, _ region: CLRegion)
        
        @PyCall func didEnterRegion(_ manager: PyLocationManager, _ region: CLRegion)
        
        @PyCall func didUpdateHeading(_ manager: PyLocationManager, _ newHeading: CLHeading)
        
        @PyCall func didUpdateLocations(_ manager: PyLocationManager, _ locations: [CLLocation])
        
        @PyCall func didFailWithError(_ manager: PyLocationManager, _ error: String)
        
        @PyCall func didRangeBeacons(_ manager: PyLocationManager, _ beacons: [CLBeacon], _ beaconConstraint: CLBeaconIdentityConstraint)
        
        @PyCall func didStartMonitoringFor(_ manager: PyLocationManager, _ region: CLRegion)
        
        @PyCall func didDetermineState(_ manager: PyLocationManager, _ state: CLRegionState, _ region: CLRegion)
        
        @PyCall func didFailRangingFor(_ manager: PyLocationManager, _ beaconConstraint: CLBeaconIdentityConstraint, _ error: String)
        
        @PyCall func didFinishDeferredUpdatesWithError(_ manager: PyLocationManager, _ error: String?)
        
        @PyCall func monitoringDidFailFor(_ manager: PyLocationManager, _ region: CLRegion?, _ error: String)
        
    }
}

extension PyLocationManager.Callbacks: CLLocationManagerDelegate {
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if let py_manager {
            didChangeAuthorization(py_manager)
        }
    }
    
    public func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
        if let py_manager {
            didPauseLocationUpdates(py_manager)
        }
    }
    
    public func locationManagerDidResumeLocationUpdates(_ manager: CLLocationManager) {
        if let py_manager {
            didResumeLocationUpdates(py_manager)
        }
    }
    
    public func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
        if let py_manager {
            return (try? shouldDisplayHeadingCalibration(py_manager)) ?? false
        }
        return false
    }
    
    public func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
        if let py_manager {
            didVisit(py_manager, visit)
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if let py_manager {
            didExitRegion(py_manager, region)
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if let py_manager {
            didEnterRegion(py_manager, region)
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        if let py_manager {
            didUpdateHeading(py_manager, newHeading)
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let py_manager {
            didUpdateLocations(py_manager, locations)
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        if let py_manager {
            didFailWithError(py_manager, error.localizedDescription)
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        if let py_manager {
            didRangeBeacons(py_manager, beacons, beaconConstraint)
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        if let py_manager {
            didStartMonitoringFor(py_manager, region)
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        if let py_manager {
            didDetermineState(py_manager, state, region)
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailRangingFor beaconConstraint: CLBeaconIdentityConstraint, error: any Error) {
        if let py_manager {
            didFailRangingFor(py_manager, beaconConstraint, error.localizedDescription)
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didFinishDeferredUpdatesWithError error: (any Error)?) {
        if let py_manager {
            didFinishDeferredUpdatesWithError(py_manager, error?.localizedDescription)
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: any Error) {
        if let py_manager {
            monitoringDidFailFor(py_manager, region, error.localizedDescription)
        }
    }
}
