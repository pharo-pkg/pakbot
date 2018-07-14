"
I'm the root class for all PPMRepository Rest call handlers.

API:

GET
/packages : get a list of all package names present in the repository
/packages/{1} : get the list of versions available for this package
/packages/{1}/{2} : get the description for the specified package version
/packages/{1}/{2}/files : get the source files for the specified package version
/packages/{1}/latest : get the latest version available for this package
/virtualpackages/{1}/{2} : get the list of packages implementing the virtual package specified as parameter

packages?tag=xx&tag=xx&platform=xx&&platform=xx&&provides=foo@1.2

/packages/{1}/{2}/loadlist : get the description for the specified package version
/packages/{1}/{2}/loadlist?installedpackage=foo@1.2&installledPackage=var@2.2/{1}/{2}
	=> /configuration POST

Use a POST request to create a request with filters (pass arguments as attachments) and get back an unique id.
Then do a get request on this unique id to execute the request and get the result.

list of available filters:
* tag : only select packages with the given tag. If multiple tags are given, only packages with all tags will be selected
* platform :

POST
""how to pass all data needed to create a package version?""
/package/?? : create a new package version in the repository
"
Class {
	#name : #CGORepositoryRestCallHandler,
	#superclass : #ZnAutoMatchedRestCall,
	#category : 'CargoPackageManager-Repository-ReST'
}

{ #category : #testing }
CGORepositoryRestCallHandler class >> isAbstract [
	^ self = CGORepositoryRestCallHandler  
]

{ #category : #'response handling' }
CGORepositoryRestCallHandler >> created: uri [
	^ (super created: uri)
		entity: (ZnEntity 
				with: (self toSton: uri)
				type: ZnMimeType applicationSton);
		yourself
]

{ #category : #serializing }
CGORepositoryRestCallHandler >> fromStonString: data [
	^ STON fromString: data
]

{ #category : #accessing }
CGORepositoryRestCallHandler >> packageRepository [
	^ delegate packageRepository
]

{ #category : #accessing }
CGORepositoryRestCallHandler >> platformValues [
	| value |
	value := self queryAt: #platform ifAbsent: [ #() ].
	value ifEmpty: [ ^ #() ].
	^ value isArray
		ifTrue: [ value collect: #asSymbol as: Array ]
		ifFalse: [ ($, split: value) collect: #asSymbol as: Array ]
]

{ #category : #'response handling' }
CGORepositoryRestCallHandler >> stonRequest [
	^ (self request contentType matches: ZnMimeType applicationSton)
		ifTrue: [ self fromStonString: self request contents ]
		ifFalse: [ self error: 'STON content expected' ]
]

{ #category : #'response handling' }
CGORepositoryRestCallHandler >> stonResponse: data [
	| entity |
	entity := ZnEntity 
				with: (self toSton: data)
				type: (ZnMimeType applicationSton).
	self response: (ZnResponse ok: entity)
]

{ #category : #serializing }
CGORepositoryRestCallHandler >> toSton: data [
	^ CGOPackageVersionWriter toStringPretty: data
]
