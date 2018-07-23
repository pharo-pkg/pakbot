"
A PackageUnit without at least one source repository defined is not valid.
This error is signaled when no source repository can be found!
"
Class {
	#name : #CGOMissingSourcePackageDefinition,
	#superclass : #AnObsoleteCGOPackageManagerError,
	#category : #'CargoPackageManager-Model'
}

{ #category : #private }
CGOMissingSourcePackageDefinition >> isResumable [
	^ true
]
