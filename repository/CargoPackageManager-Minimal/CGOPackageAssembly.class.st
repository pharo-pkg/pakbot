"
I'm a composite containing packages (assemblies and/or units). I have no explicit dependency. My dependencies are transitive dependencies of my package units.

- parts is the list of package names I'm containing
- projectRepository is the reference source code repostiory of the project
"
Class {
	#name : #CGOPackageAssembly,
	#superclass : #CGOPackageVersion,
	#instVars : [
		'parts'
	],
	#category : 'CargoPackageManager-Minimal-Model'
}

{ #category : #serialization }
CGOPackageAssembly class >> stonName [
	^ #'PackageAssembly'
]

{ #category : #accessing }
CGOPackageAssembly >> allPackageUnits [
	" returns the list of package units part of the assembly recursively, flattening package assemblies"
	
	| units |
	units := (self assemblies flatCollect: #allPackageUnits as: Set).
	units addAll: self packageUnitNames.
	^ units
]

{ #category : #converting }
CGOPackageAssembly >> asSerializablePackageVersion [
	^ CGOSerializedPackageAssembly from: self
]

{ #category : #accessing }
CGOPackageAssembly >> assemblies [
	^ parts
		collect: [ :each | registry packageNamed: each packageName ifAbsent: [ nil ] ]
		thenSelect: [ :each | each notNil and: [ each isAssembly ] ]
]

{ #category : #accessing }
CGOPackageAssembly >> dependencies [
	^ parts
]

{ #category : #testing }
CGOPackageAssembly >> fitsPlatformRequirements [
	"At this time, we do not consider assemblies to be platform specific. Only their parts could be."
	^ true
]

{ #category : #ston }
CGOPackageAssembly >> fromSton: stonReader [
	"Decode the specific PackageVersion serialization format."
	| serializedPkgVersion |
	serializedPkgVersion := CGOSerializedPackageAssembly new fromSton: stonReader.
	serializedPkgVersion flushIn: self.
]

{ #category : #initialization }
CGOPackageAssembly >> initializeFrom: aDictionary [
	super initializeFrom: aDictionary.
	parts := self partsFrom: aDictionary.
]

{ #category : #initialization }
CGOPackageAssembly >> initializeFromOngoing: aCGOOngoingPackageAssembly project: aCGOProject [
	super initializeFromOngoing: aCGOOngoingPackageAssembly project: aCGOProject.
	parts := aCGOOngoingPackageAssembly parts deepCopy.
]

{ #category : #testing }
CGOPackageAssembly >> isAssembly [
	^ true
]

{ #category : #accessing }
CGOPackageAssembly >> packageUnitNames [
	| foundPackage |
	^ parts
		select: [ :each | 
			foundPackage := registry packageNamed: each packageName ifAbsent: [ nil ].
			foundPackage notNil and: [ foundPackage isUnit ] ]
]

{ #category : #accessing }
CGOPackageAssembly >> packages [
	^ self packageUnits , self assemblies
]

{ #category : #accessing }
CGOPackageAssembly >> parts [
	^ parts
]

{ #category : #'initialization - private' }
CGOPackageAssembly >> partsFrom: aDictionary [
	^ (self mandatoryKey: #parts from: aDictionary)
		collect: #asPackageDependency
]

{ #category : #printing }
CGOPackageAssembly >> printOn: aStream [
	aStream << self packageName << '@' << (self version asString) << ' (assembly)'
]

{ #category : #accessing }
CGOPackageAssembly >> projectRepository [
	^ projectRepository
]

{ #category : #ston }
CGOPackageAssembly >> stonOn: stonWriter [
	self asSerializablePackageVersion stonOn: stonWriter
]
