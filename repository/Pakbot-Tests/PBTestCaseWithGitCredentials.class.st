"
This class contains test set up and tear down to use git credentials to interact with predefined github project.
"
Class {
	#name : #PBTestCaseWithGitCredentials,
	#superclass : #TestCase,
	#instVars : [
		'oldRemoteTypeSelector',
		'iceCredentialsProviderBackup'
	],
	#category : #'Pakbot-Tests-Repository'
}

{ #category : #running }
PBTestCaseWithGitCredentials >> setUp [
	super setUp.
	
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
PBTestCaseWithGitCredentials >> tearDown [
	IceCredentialsProvider providerType: iceCredentialsProviderBackup.
	Iceberg remoteTypeSelector: oldRemoteTypeSelector.
	
	super tearDown.
]
