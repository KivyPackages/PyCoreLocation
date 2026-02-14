from typing import Callable, Protocol

class PyLocationManager():
	@staticmethod
	def shared() -> "PyLocationManager": ...

	def add_callback(self, callback: object): ...

	def remove_callback(self, callback: object): ...

	@staticmethod
	def locationServicesEnabled() -> bool: ...

	@staticmethod
	def headingAvailable() -> bool: ...

	@staticmethod
	def significantLocationChangeMonitoringAvailable() -> bool: ...

	authorizationStatus: "CLAuthorizationStatus"

	activityType: "CLActivityType"

	distanceFilter: "CLLocationDistance"

	desiredAccuracy: "CLLocationAccuracy"

	pausesLocationUpdatesAutomatically: bool

	allowsBackgroundLocationUpdates: bool

	showsBackgroundLocationIndicator: bool

	location: "CLLocation | None"

	headingFilter: float

	headingOrientation: "CLDeviceOrientation"

	heading: "CLHeading | None"

	maximumRegionMonitoringDistance: "CLLocationDistance"

	monitoredRegions: "Set<CLRegion>"

	rangedBeaconConstraints: "Set<CLBeaconIdentityConstraint>"

	def requestWhenInUseAuthorization(self): ...

	def requestAlwaysAuthorization(self): ...

	def requestTemporaryFullAccuracyAuthorization(self, purposeKey: str, completion: Callable[str | None, None]): ...

	def startUpdatingLocation(self): ...

	def stopUpdatingLocation(self): ...

	def requestLocation(self): ...

	def startUpdatingHeading(self): ...

	def stopUpdatingHeading(self): ...

	def dismissHeadingCalibrationDisplay(self): ...

	def startMonitoringSignificantLocationChanges(self): ...

	def stopMonitoringSignificantLocationChanges(self): ...

	def startMonitoringLocationPushes(self, completion: Callable[[bytes | None, str | None], None]): ...

	def stopMonitoringLocationPushes(self): ...

	def stopMonitoring(self, region: "CLRegion"): ...

	def startMonitoring(self, region: "CLRegion"): ...

	def requestState(self, region: "CLRegion"): ...

	def startRangingBeacons(self, constraint: "CLBeaconIdentityConstraint"): ...

	def stopRangingBeacons(self, constraint: "CLBeaconIdentityConstraint"): ...

class CLBeacon():
	id: str

	timestamp: "Date"

	proximity: "CLProximity"

	accuracy: "CLLocationAccuracy"

	rssi: int

class CLBeaconIdentityConstraint():
	major: int | None

	minor: int | None

class CLFloor():
	level: int

class CLHeading():
	magneticHeading: "CLLocationDirection"

	trueHeading: "CLLocationDirection"

	headingAccuracy: "CLLocationDirection"

	x: float

	y: float

	z: float

	timestamp: "Date"

class CLLocation():
	coordinate: "CLLocationCoordinate2D"

	altitude: "CLLocationDistance"

	horizontalAccuracy: "CLLocationAccuracy"

	verticalAccuracy: "CLLocationAccuracy"

	course: "CLLocationDirection"

	speed: "CLLocationSpeed"

	speedAccuracy: "CLLocationSpeedAccuracy"

	timestamp: "Date"

	floor: "CLFloor | None"

	def distance(self, location: "CLLocation") -> "CLLocationDistance": ...

class CLRegion():
	identifier: str

	notifyOnEntry: bool

	notifyOnExit: bool

class CLVisit():
	arrivalDate: "Date"

	departureDate: "Date"

	coordinate: "CLLocationCoordinate2D"

	horizontalAccuracy: "CLLocationAccuracy"