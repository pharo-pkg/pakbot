"
Very simple implementation of Iceberg Working Copy for test purposes.
"
Class {
	#name : #PBTestIcebergWorkingCopy,
	#superclass : #IceWorkingCopy,
	#category : #'CargoPackageManager-UI-Tests'
}

{ #category : #initialization }
PBTestIcebergWorkingCopy >> initialize [

	repository workingCopy: self.
	
	super initialize.
]

{ #category : #'API-changes' }
PBTestIcebergWorkingCopy >> isModified [
	^ false
]
