"
super class used to set up credentials to perform git operations (i.e. clone)
"
Class {
	#name : #PBGitCreationTest,
	#superclass : #TestCase,
	#instVars : [
		'iceCredentialsProviderBackup',
		'oldRemoteTypeSelector',
		'repository',
		'iceRepositoryLocation'
	],
	#category : #'CargoPackageManager-Tests-SCM'
}

{ #category : #accessing }
PBGitCreationTest >> iceRepositoryLocation [
	^ iceRepositoryLocation
		ifNil: [ iceRepositoryLocation := FileLocator temp
				/ ('pharo-tests-' , DateAndTime now asFileNameCompatibleString) ]
]

{ #category : #running }
PBGitCreationTest >> setUp [
	oldRemoteTypeSelector := Iceberg remoteTypeSelector.
	iceCredentialsProviderBackup := IceCredentialsProvider providerType.

	CGOGitHostedPackageVersionEnforcingProtocol useHttpsUrl.
	
	Iceberg remoteTypeSelector: #httpsUrl.
	
	"usable with pharo-counter project on GitHub"
	IceCredentialStore current
		storeCredential: (IcePlaintextCredentials new 
			username: 'cargo-test';
			password: 'cargo2017';
			host: 'github.com';
			yourself).
	
	IceCredentialsProvider providerType: IceNonInteractiveCredentialsProvider.
]

{ #category : #running }
PBGitCreationTest >> tearDown [
	IceCredentialsProvider providerType: iceCredentialsProviderBackup.
	Iceberg remoteTypeSelector: oldRemoteTypeSelector.

	repository ifNotNil: 
		[ (repository instVarNamed: 'iceRepository') ifNotNil: "do not call the accessor that will force the repository clone"
			[ :aRepository | aRepository delete ] ].
	
	iceRepositoryLocation ifNotNil: #ensureDeleteAll.
]
