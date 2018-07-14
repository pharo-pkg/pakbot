"
Warning signaled to alert the user that the package is dirty and needs to be saved.
"
Class {
	#name : #CGODirtyPackageWarning,
	#superclass : #Warning,
	#category : 'CargoPackageManager-Model'
}

{ #category : #testing }
CGODirtyPackageWarning >> isResumable [
	^ true
]
