"
I represent a Cargo virtual package ready to be serialized on a Version Control System (e.g. git).
"
Class {
	#name : #CGOVcsSerializedVirtualPackage,
	#superclass : #CGOVcsSerializedPackage,
	#category : #'CargoPackageManager-Minimal-Model-Serialization'
}

{ #category : #'instance creation' }
CGOVcsSerializedVirtualPackage class >> from: aVirtualPackageVersion [
	^ self basicNew
		initializeWithOngoing: aVirtualPackageVersion;
		yourself
]
