Class {
	#name : #CGOPackageVersionPublisherTest,
	#superclass : #Object,
	#instVars : [
		'fs',
		'pkgRepository'
	],
	#category : 'CargoPackageManager-Utils-FailingTests'
}

{ #category : #running }
CGOPackageVersionPublisherTest >> setUp [
	fs := FileSystem memory.
	pkgRepository := CGODirectoryPackageRepository basicNew
		instVarNamed: 'rootDirectory' put: fs root;
		yourself
]

{ #category : #running }
CGOPackageVersionPublisherTest >> tearDown [
	ManifestFoo class removeSelector: #repositories.
]

{ #category : #tests }
CGOPackageVersionPublisherTest >> testCanPublishOnePackageVersion [
	[ (CGOPackageVersionPublisher on: pkgRepository) 
		manifests: { ManifestOneDependency };
		run ]
	on: CGOWorkingCopyNotFound 
	do: [ :ex | ex resume "ignore it. it is a test manifest" ].
	
	self assert: (fs / 'onedependency') isDirectory.
	self assert: (fs / 'onedependency' / ('onedependency@' , ManifestFoo version asSemanticVersion asString)) isFile.
]

{ #category : #tests }
CGOPackageVersionPublisherTest >> testCanPublishOnePackageVersionProvidingRepository [
	| repos |
	
	repos := #('http://smalltalkhub.com/mc/Pharo/Pharo60/main').

	[ (CGOPackageVersionPublisher on: pkgRepository)
		srcRepositories: repos;
		manifests: { ManifestOneDependency };
		run ]
	on: CGOWorkingCopyNotFound 
	do: [ :ex | ex resume "ignore it. it is a test manifest" ].
	
	self assert: (fs / 'onedependency') isDirectory.
	self assert: (fs / 'onedependency' / ('onedependency@' , ManifestOneDependency version asSemanticVersion asString)) isFile.
	self 
		assert: ManifestOneDependency repositories 
		equals: repos
]

{ #category : #tests }
CGOPackageVersionPublisherTest >> testCanPublishOnePackageVersionProvidingVersion [
	| version |
	
	version := '1.0'.

	[ (CGOPackageVersionPublisher on: pkgRepository)
		versionBlock: [:ongoing | version ];
		manifests: { ManifestOneDependency };
		run]
	on: CGOWorkingCopyNotFound 
	do: [ :ex | ex resume "ignore it. it is a test manifest" ].
	
	self assert: (fs / 'onedependency') isDirectory.
	self assert: (fs / 'onedependency' / ('onedependency@' , ManifestOneDependency version asSemanticVersion asString)) isFile.
	self 
		assert: ManifestOneDependency version
		equals: version
]

{ #category : #tests }
CGOPackageVersionPublisherTest >> testCanPublishPackageVersionAndItsDependencies [
	[ (CGOPackageVersionPublisher on: pkgRepository)
		publishDependencies;
		manifests: { ManifestOneDependency };
		run ]
	on: CGOWorkingCopyNotFound 
	do: [ :ex | ex resume "ignore it. it is a test manifest" ].
	
	self assert: (fs / 'onedependency') isDirectory.
	self assert: (fs / 'onedependency' / ('onedependency@' , ManifestOneDependency version asSemanticVersion asString)) isFile.
	self assert: (fs / 'nodependency' / ('nodependency@' , ManifestWithNoDependenciesForTest version asSemanticVersion asString)) isFile.
]

{ #category : #tests }
CGOPackageVersionPublisherTest >> testShouldPackageBeUpToDateAndCleanAfterPublishing [
	| pkgName wc manifest |
	
	pkgName := 'CGO-Foo'.
	RPackageOrganizer default registerPackageNamed: pkgName.
	wc := MCWorkingCopy forPackage: (MCPackage new name: pkgName).
	manifest := (TheManifestBuilder ofPackageNamed: pkgName) manifest.
	manifest class compile: 'packageName ^ ', pkgName printString.
	manifest class compile: 'sourcePackageVersion
	^ { #backend -> #monticello .
		#repositoryUrl -> ', '''file://' , MCCacheRepository cacheDirectory fullName , ''' .
		#packageName -> #''CGO-Foo'' .
		#versionString -> ''testRunner.1'' } asDictionary'.

	self assert: wc needsSaving.
	(CGOPackageVersionPublisher on: pkgRepository)
		manifests: { manifest };
		run.
	
	self 
		assert: manifest sourcePackageVersion 
		equals: { #backend -> #monticello .
		#repositoryUrl -> ('file://' , MCCacheRepository cacheDirectory fullName) .
		#packageName -> #'CGO-Foo' .
		#versionString -> 'testRunner.1' } asDictionary.
	self deny: wc needsSaving.
	wc unload

]
