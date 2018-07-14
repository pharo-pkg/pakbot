"
I represent a Virtual package vesrion ready to be serialized.
I map some instance variables of PackageVersion to an easily serialized form (e.g. String, Array)
"
Class {
	#name : #CGOSerializedVirtualPackageVersion,
	#superclass : #CGOSerializedPackageVersion,
	#category : 'CargoPackageManager-Minimal-Model-Serialization'
}

{ #category : #'instance creation' }
CGOSerializedVirtualPackageVersion class >> from: aVirtualPackageVersion [
	^ self basicNew
		initializeWith: aVirtualPackageVersion;
		yourself
]

{ #category : #'ston-core' }
CGOSerializedVirtualPackageVersion class >> stonName [
	^ #CGOPublishedVirtualPackage
]
