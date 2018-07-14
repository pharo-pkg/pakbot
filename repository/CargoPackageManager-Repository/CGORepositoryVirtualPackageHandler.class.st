"
I handle REST requests for /virtualpackages/{1}/{2}

I return the list of registered packages in the repository providing the specified virtual package with the specified version.
"
Class {
	#name : #CGORepositoryVirtualPackageHandler,
	#superclass : #CGORepositoryRestCallHandler,
	#category : 'CargoPackageManager-Repository-ReST'
}

{ #category : #matching }
CGORepositoryVirtualPackageHandler class >> pattern [
	^ #( 'virtualpackages' '*' '*' )
]

{ #category : #public }
CGORepositoryVirtualPackageHandler >> get [
	| virtualPackageName version packageVersions platformAttributes |
	
	virtualPackageName := variables first asSymbol.
	version := variables second asSemanticVersion.
	platformAttributes := self platformValues.
	[ packageVersions := self packageRepository 
							packagesProviding: virtualPackageName
							version: version
							forPlatformAttributes: platformAttributes ]
		on: CGOPackageVersionNotFoundError
		do: [ ^ self notFound ].
	^ self stonResponse: packageVersions
]
