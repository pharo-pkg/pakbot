"
Error raised when a package (i.e. the package name) cannot be found.
"
Class {
	#name : #PBPackageNotFoundError,
	#superclass : #PBError,
	#category : #'CargoPackageManager-Minimal-Model'
}

{ #category : #signalling }
PBPackageNotFoundError >> signal: aPackageName [
	^ super signal: 'Cannot find ' , aPackageName , ' package!'
]
