"
Error raised when a package (i.e. the package name) cannot be found.
"
Class {
	#name : #CGOPackageNotFoundError,
	#superclass : #PBError,
	#category : #'CargoPackageManager-Minimal-Model'
}

{ #category : #signalling }
CGOPackageNotFoundError >> signal: aPackageName [
	^ super signal: 'Cannot find ' , aPackageName , ' package!'
]
