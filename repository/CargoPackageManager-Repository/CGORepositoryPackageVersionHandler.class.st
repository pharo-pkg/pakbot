"
I handle REST requests for /packages/{1}/{2}
ex: /packages/foo/1.2

I return full meta-information for the specified package version.
"
Class {
	#name : #CGORepositoryPackageVersionHandler,
	#superclass : #CGORepositoryRestCallHandler,
	#category : 'CargoPackageManager-Repository-ReST'
}

{ #category : #matching }
CGORepositoryPackageVersionHandler class >> pattern [
	^ #( 'packages' '*' '*')
]

{ #category : #public }
CGORepositoryPackageVersionHandler >> get [
	| packageName version packageVersion |
	
	packageName := variables first asSymbol.
	version := variables second asSemanticVersion.
	[ packageVersion := self packageRepository fetch: packageName version: version ]
		on: CGOPackageVersionNotFoundError
		do: [ ^ self notFound ].
	^ self stonResponse: packageVersion  
]

{ #category : #public }
CGORepositoryPackageVersionHandler >> post [
	| packageVersion |
	
	packageVersion := self stonRequest.
	(packageVersion isKindOf: CGOPackageVersion)
		ifTrue: [ [ self packageRepository savePackageVersion: packageVersion.
						self created: (self uriFor: packageVersion) ]
						on: CGOPackageVersionAlreadyExistsError
						do: [ :error | self badRequest: error messageText ] ]
		ifFalse: [ self badRequest: 'STON PackageVersion expected' ]
]

{ #category : #private }
CGORepositoryPackageVersionHandler >> uriFor: aPackageVersion [
	^ '/' , self class pattern first , '/' , aPackageVersion packageName , '/' , aPackageVersion version asString
]
