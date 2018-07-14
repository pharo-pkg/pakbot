"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestCargoPackageManager,
	#superclass : #PackageManifest,
	#category : 'CargoPackageManager'
}

{ #category : #'meta-data' }
ManifestCargoPackageManager class >> dependencies [
	^ {(#A -> #('=1.1')).
	(#'Athens-Balloon' -> #('=1' '=2' '=3' '=4'))}
]

{ #category : #'meta-data' }
ManifestCargoPackageManager class >> description [
	^ 'I''m the core package of the Cargo package manager.
I hold core classes to represent a package meta-data with objects.'
]

{ #category : #'meta-data' }
ManifestCargoPackageManager class >> packageName [
	^ #CargoPackageManager
]

{ #category : #'meta-data' }
ManifestCargoPackageManager class >> platformRequirements [
	^ #('pharo' 'pharo4.x')
]

{ #category : #'meta-data' }
ManifestCargoPackageManager class >> provisions [
	^ #(#a #b #'foo-bar')
]

{ #category : #'meta-data' }
ManifestCargoPackageManager class >> repositories [
	^ #('http://smalltalkhub.com/mc/demarey/PPM/main/')
]

{ #category : #'code-critics' }
ManifestCargoPackageManager class >> ruleContainsRuleV1FalsePositive [
^ #(#(#(#RGMethodDefinition #(#CGOOngoingPackageUnit #updateDependenciesWith: #false)) #'2015-01-20T13:14:26.351538+01:00') )
]

{ #category : #'code-critics' }
ManifestCargoPackageManager class >> ruleEmptyExceptionHandlerRuleV1FalsePositive [
^ #(#(#(#RGMethodDefinition #(#CGOPackageVersionReference #fetchFromRepositories #false)) #'2015-01-20T12:59:09.096635+01:00') )
]

{ #category : #'code-critics' }
ManifestCargoPackageManager class >> ruleMissingSubclassResponsibilityRuleV1FalsePositive [
^ #(#(#(#RGMethodDefinition #(#CGORepositoryPackageLoadInstructionsHandler #get #false)) #'2015-01-20T13:14:26.566429+01:00') #(#(#RGMethodDefinition #(#CGORepositoryVirtualPackageHandler #get #false)) #'2015-01-20T13:14:26.566429+01:00') #(#(#RGMethodDefinition #(#CGORepositoryPackageVersionListHandler #get #false)) #'2015-01-20T13:14:26.566429+01:00') #(#(#RGMethodDefinition #(#CGORepositoryPackageVersionHandler #get #false)) #'2015-01-20T13:14:26.566429+01:00') #(#(#RGMethodDefinition #(#CGORepositoryPackageListHandler #get #false)) #'2015-01-20T13:14:26.566429+01:00') #(#(#RGMethodDefinition #(#CGORepositoryLatestPackageHandler #get #false)) #'2015-01-20T13:14:26.566429+01:00') )
]

{ #category : #'code-critics' }
ManifestCargoPackageManager class >> ruleMissingYourselfRuleV1FalsePositive [
^ #(#(#(#RGMethodDefinition #(#CGORemoteRepositoryProxy #versionStringsOf: #false)) #'2015-01-20T13:01:10.912183+01:00') #(#(#RGMethodDefinition #(#CGOLoadInstructionsBuilder #graph #false)) #'2015-01-20T13:01:10.912183+01:00') #(#(#RGMethodDefinition #(#CGORemoteRepositoryProxy #packagesProviding:version:forEnvironment: #false)) #'2015-01-20T13:01:10.912183+01:00') #(#(#RGMethodDefinition #(#CGORemoteRepositoryProxy #latestVersionOfPackage:suitableForEnvironment: #false)) #'2015-01-20T13:01:10.912183+01:00') #(#(#RGMethodDefinition #(#CGORemoteRepositoryProxy #packages #false)) #'2015-01-20T13:01:10.912183+01:00') #(#(#RGMethodDefinition #(#CGORemoteRepositoryProxy #fetch:version: #false)) #'2015-01-20T13:01:10.912183+01:00') )
]

{ #category : #'code-critics' }
ManifestCargoPackageManager class >> ruleTempsReadBeforeWrittenRuleV1FalsePositive [
^ #(#(#(#RGMethodDefinition #(#CGORepositoryLatestPackageHandler #get #false)) #'2015-01-20T13:14:26.460167+01:00') #(#(#RGMethodDefinition #(#CGORepositoryVirtualPackageHandler #get #false)) #'2015-01-20T13:14:26.460167+01:00') #(#(#RGMethodDefinition #(#CGORepositoryPackageVersionListHandler #get #false)) #'2015-01-20T13:14:26.460167+01:00') #(#(#RGMethodDefinition #(#CGORepositoryPackageVersionHandler #get #false)) #'2015-01-20T13:14:26.460167+01:00') #(#(#RGMethodDefinition #(#CGORemoteRepositoryProxy #fetch:version: #false)) #'2015-01-20T13:14:26.460167+01:00') #(#(#RGMethodDefinition #(#CGOSolver #versionFor: #false)) #'2015-01-20T13:14:26.460167+01:00') )
]

{ #category : #'meta-data' }
ManifestCargoPackageManager class >> version [
	^ '0.2-dev'
]
