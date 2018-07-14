"
I handle REST requests for /packages

I return the list of registered packages in the repository.
"
Class {
	#name : #CGORepositoryPackageListHandler,
	#superclass : #CGORepositoryRestCallHandler,
	#category : 'CargoPackageManager-Repository-ReST'
}

{ #category : #matching }
CGORepositoryPackageListHandler class >> pattern [
	^ #( 'packages' )
]

{ #category : #public }
CGORepositoryPackageListHandler >> get [
	^ self stonResponse: self packageRepository packageNames
]
