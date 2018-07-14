"
Error raised when no working copy is found in the image for the given package unit.
"
Class {
	#name : #CGOWorkingCopyNotFound,
	#superclass : #CGOPackageManagerError,
	#instVars : [
		'packageUnit'
	],
	#category : 'CargoPackageManager-Model'
}

{ #category : #signalling }
CGOWorkingCopyNotFound class >> signalFor: aCGOPackageUnit [
	^ self new 
		packageUnit: aCGOPackageUnit;
		signal
]

{ #category : #private }
CGOWorkingCopyNotFound >> isResumable [
	^ true
]

{ #category : #accessing }
CGOWorkingCopyNotFound >> messageText [
	^ packageUnit packageName , ' has no working copy!'
]

{ #category : #private }
CGOWorkingCopyNotFound >> packageUnit: aCGOPackageUnit [
	packageUnit := aCGOPackageUnit
]
