"
I handle REST requests for /packages/{1}/latest
ex: /packages/foo/latest

I return full meta-information for the latest version of the specified package.
"
Class {
	#name : #CGORepositoryLatestPackageHandler,
	#superclass : #CGORepositoryRestCallHandler,
	#category : 'CargoPackageManager-Repository-ReST'
}

{ #category : #matching }
CGORepositoryLatestPackageHandler class >> order [
	^ 20
]

{ #category : #matching }
CGORepositoryLatestPackageHandler class >> pattern [
	^ #( 'packages' '*' 'latest')
]

{ #category : #public }
CGORepositoryLatestPackageHandler >> get [
	| packageName packageVersion |
	
	packageName := variables first asSymbol.
	[ packageVersion := self packageRepository
		latestVersionOfPackage: packageName 
		suitableForEnvironment: self platformValues ]
		on: CGOPackageNotFoundError
		do: [ ^ self notFound ].
	^ self stonResponse: packageVersion  
]
