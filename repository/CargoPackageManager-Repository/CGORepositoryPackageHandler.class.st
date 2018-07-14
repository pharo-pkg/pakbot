"
I handle REST requests for /package

I return the existing package if it exists.
"
Class {
	#name : #CGORepositoryPackageHandler,
	#superclass : #CGORepositoryRestCallHandler,
	#category : 'CargoPackageManager-Repository-ReST'
}

{ #category : #matching }
CGORepositoryPackageHandler class >> pattern [
	^ #( 'package' '*')
]

{ #category : #public }
CGORepositoryPackageHandler >> get [
	| packageName package |
	packageName := variables first asSymbol.
	[ package := self packageRepository package: packageName ]
		on: CGOPackageNotFoundError
		do: [ ^ self notFound ].
	^ self stonResponse: package
]
