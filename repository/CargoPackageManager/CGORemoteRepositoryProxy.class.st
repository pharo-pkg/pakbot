"
A PPMRemoteRepositoryProxy is a simply proxy to a remote PPM repository exposing the same API with Rest. This proxy hides the remote / networking part.

- endpoint is the base URL from where the ReST service is available.
- znClient holds an already configured Zinc client to perform requests.
"
Class {
	#name : #CGORemoteRepositoryProxy,
	#superclass : #CGOPackageRepository,
	#instVars : [
		'endpoint',
		'znClient',
		'packageVersionCache'
	],
	#category : 'CargoPackageManager-Model'
}

{ #category : #'versions fetching' }
CGORemoteRepositoryProxy >> fetch: aPackageName version: aVersion [
	| pkgVersion |
	[ pkgVersion := znClient
		url: baseUrl;
		addPathSegment: 'packages';
		addPathSegment: aPackageName;
		addPathSegment: aVersion asString;
		get ]
	on: ZnHttpUnsuccessful 
	do: [ :error |
		znClient isNotFound 
			ifTrue: [ CGOPackageVersionNotFoundError signal: 'Cannot find ' , aPackageName, ' version: ', aVersion asString ]
			ifFalse: [ error signal ] ].
	self packageVersionCache saveDescription: pkgVersion.
	^ pkgVersion
]

{ #category : #initialization }
CGORemoteRepositoryProxy >> initialize [
	super initialize.
	znClient := ZnClient new
		accept: ZnMimeType applicationSton;
		enforceHttpSuccess: true;
		contentReader: [ :entity | entity ifNotNil: [ STON fromString: entity contents ] ];
		contentWriter: [ :object | ZnEntity with: (CGOPackageVersionWriter toStringPretty: object) type: ZnMimeType applicationSton ];
		yourself
]

{ #category : #'versions fetching' }
CGORemoteRepositoryProxy >> latestVersionOfPackage: aPackageName suitableForEnvironment: platformAttributes [
	[ ^ znClient
		url: baseUrl;
		addPathSegment: 'packages';
		addPathSegment: aPackageName;
		addPathSegment: 'latest';
		queryAt: #platform put: ($, join: platformAttributes);
		get ]
	on: ZnHttpUnsuccessful 
	do: [ :error |
		znClient isNotFound 
			ifTrue: [ CGOPackageNotFoundError signal: aPackageName ]
			ifFalse: [ error signal ] ]
]

{ #category : #fetching }
CGORemoteRepositoryProxy >> package: aPackageName [
	[ ^ znClient
		url: baseUrl;
		addPathSegment: 'package';
		addPathSegment: aPackageName;
		get ]
	on: ZnHttpUnsuccessful 
	do: [ :error |
		znClient isNotFound 
			ifTrue: [ CGOPackageNotFoundError signal: aPackageName ]
			ifFalse: [ error signal ] ]
]

{ #category : #'versions fetching' }
CGORemoteRepositoryProxy >> packageNames [
	^ znClient
		url: baseUrl;
		addPathSegment: 'packages';
		get
]

{ #category : #fetching }
CGORemoteRepositoryProxy >> packageVersionCache [
	^ packageVersionCache ifNil: [ packageVersionCache := CGOPackageVersionCache new ]
]

{ #category : #'versions fetching' }
CGORemoteRepositoryProxy >> packagesProviding: aName version: aSemanticVersion forEnvironment: platformAttributes [
	[ ^ znClient
		url: baseUrl;
		addPathSegment: 'virtualpackages';
		addPathSegment: aName;
		addPathSegment: aSemanticVersion asString;
		queryAt: #platform put: ($, join: platformAttributes);
		get ]
	on: ZnHttpUnsuccessful 
	do: [ :error |
		znClient isNotFound 
			ifTrue: [ CGOPackageVersionNotFoundError 
						signal: 'Cannot find virtual package ' , aName , ' in version: ' , aSemanticVersion asString , ' for: ' platformAttributes ]
			ifFalse: [ error signal ] ]
]

{ #category : #'versions posting' }
CGORemoteRepositoryProxy >> savePackageVersion: aPackageVersion [
	[ znClient
		url: baseUrl;
		addPathSegment: 'packages';
		addPathSegment: aPackageVersion packageName asString;
		addPathSegment: aPackageVersion version asString;
		entity: ( (ZnEntity text: (CGOPackageVersionWriter toStringPretty: aPackageVersion))
						contentType: ZnMimeType applicationSton );
		post ]
	on: ZnHttpUnsuccessful 
	do: [ :error |
		znClient isBadRequest 
			ifTrue: [ CGOPackageVersionAlreadyExistsError signal: 'Package ' , aPackageVersion asString, ' already exists!' ]
			ifFalse: [ Error signal: error messageText ] ]
]

{ #category : #'versions fetching' }
CGORemoteRepositoryProxy >> versionStringsOf: aPackageName [
	[ ^ znClient
		url: baseUrl;
		addPathSegment: 'packages';
		addPathSegment: aPackageName;
		get ]
	on: ZnHttpUnsuccessful 
	do: [ :error |
		znClient isNotFound 
			ifTrue: [ CGOPackageNotFoundError signal: aPackageName ]
			ifFalse: [ error signal ] ]
]
