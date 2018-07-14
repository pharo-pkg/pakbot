Class {
	#name : #CGOGitHostedPackageVersionEnforcingProtocolTest,
	#superclass : #TestCase,
	#category : 'CargoPackageManager-FailingTests-SCM'
}

{ #category : #asserting }
CGOGitHostedPackageVersionEnforcingProtocolTest >> assertSrcPackageVersion: srcPackageVersion repositoryUrlEquals: aUrl [
	^ self
		assert:
			((srcPackageVersion instVarNamed: 'repository')
				instVarNamed: 'repositoryUrl')
		equals: aUrl
]

{ #category : #input }
CGOGitHostedPackageVersionEnforcingProtocolTest >> gitHttpsUrl [
	^ 'https://github.com/demarey/cargo'
]

{ #category : #input }
CGOGitHostedPackageVersionEnforcingProtocolTest >> gitSshUrl [
	^ 'git@github.com:demarey/cargo.git'
]

{ #category : #input }
CGOGitHostedPackageVersionEnforcingProtocolTest >> srcPackageVersionWithUrl: url [
	^ CGOGitHostedPackageVersionEnforcingProtocol
		repositoryUrl: url
		subdirectory: 'repository'
		packageName: 'CargoPackageManager-Minimal'
		commitish: 'b9ee048f40e500198120aedf8db60266caa9ece9'
]

{ #category : #tests }
CGOGitHostedPackageVersionEnforcingProtocolTest >> testShouldGetHttpsUrlWhenHttpsUrlProvidedAndUseHttpsIsTrue [
	| srcPackageVersion |
	self useHttpsUrl.
	srcPackageVersion := self srcPackageVersionWithUrl: self gitHttpsUrl.
	self 
		assertSrcPackageVersion: srcPackageVersion 
		repositoryUrlEquals: self gitHttpsUrl
]

{ #category : #tests }
CGOGitHostedPackageVersionEnforcingProtocolTest >> testShouldGetHttpsUrlWhenSshUrlProvidedAndUseHttpsIsTrue [
	| srcPackageVersion |
	self useHttpsUrl.
	srcPackageVersion := self srcPackageVersionWithUrl: self gitSshUrl.
	self 
		assertSrcPackageVersion: srcPackageVersion 
		repositoryUrlEquals: self gitHttpsUrl
]

{ #category : #tests }
CGOGitHostedPackageVersionEnforcingProtocolTest >> testShouldGetSshUrlWhenHttpUrlProvidedAndUseHttpsIsFalse [
	| srcPackageVersion |
	self useSshUrl.
	srcPackageVersion := self srcPackageVersionWithUrl: self gitHttpsUrl.
	self 
		assertSrcPackageVersion: srcPackageVersion 
		repositoryUrlEquals: self gitSshUrl
]

{ #category : #tests }
CGOGitHostedPackageVersionEnforcingProtocolTest >> testShouldGetSshUrlWhenSshUrlProvidedAndUseHttpsIsFalse [
	| srcPackageVersion |
	self useSshUrl.
	srcPackageVersion := self srcPackageVersionWithUrl: self gitSshUrl.
	self 
		assertSrcPackageVersion: srcPackageVersion 
		repositoryUrlEquals: self gitSshUrl
]

{ #category : #configuring }
CGOGitHostedPackageVersionEnforcingProtocolTest >> useHttpsUrl [
	CGOGitHostedPackageVersionEnforcingProtocol useHttpsUrl
]

{ #category : #configuring }
CGOGitHostedPackageVersionEnforcingProtocolTest >> useSshUrl [
	CGOGitHostedPackageVersionEnforcingProtocol useSshUrl
]
