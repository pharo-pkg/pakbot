"
I'm the class used to start/stop a Package repository.
I manage the HTTP server and the database connection.
"
Class {
	#name : #CGOPackageRepositoryServer,
	#superclass : #Object,
	#instVars : [
		'server',
		'repository'
	],
	#category : 'CargoPackageManager-Repository'
}

{ #category : #template }
CGOPackageRepositoryServer class >> startupScript [
	| repository |
	
	ZnServer defaultOn: 8080.
	"ZnServer default logToStandardOutput."
	repository := CGOMongoRepository newWithDbName: 'package-repository'.
	ZnServer default delegate: (CGORepositoryRestServerDelegate newWith: repository).

]

{ #category : #resetting }
CGOPackageRepositoryServer >> resetDatabase [
	repository reset "remove old data"
]

{ #category : #starting }
CGOPackageRepositoryServer >> setUpDataBase [
	repository := CGOMongoRepository newWithDbName: 'PPM-experiments'
]

{ #category : #starting }
CGOPackageRepositoryServer >> start [
	self 
		setUpDataBase;
		startWebServer 
]

{ #category : #starting }
CGOPackageRepositoryServer >> startWebServer [
	| delegate |
	delegate := CGORepositoryRestServerDelegate newWith: repository.
	server := ZnServer startOn: 8080.
	server 
		delegate: delegate;
		debugMode: true;
		yourself.
]

{ #category : #stopping }
CGOPackageRepositoryServer >> stop [
	server stop
]
