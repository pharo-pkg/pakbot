"
This class is used to hold package metadata loaded directly from a Source Code Management system.
It implements the minimial set of messages of CGOPackageRegistry needed by the Cargo solver to work.
"
Class {
	#name : #CGOScmPackageMetadata,
	#superclass : #Object,
	#instVars : [
		'repository',
		'projects'
	],
	#category : #'CargoPackageManager-Minimal-Model'
}

{ #category : #'versions fetching' }
CGOScmPackageMetadata >> fetch: aPackageName version: aVersion [
	| package version |
	package := self package: aPackageName.
	
	(aVersion beginsWith: '0.0.0-')
		ifFalse: [ CGOPackageVersionNotFoundError signal ].
	version := aVersion allButFirst: 6. "Remove useless version number 0.0.0 as ti comes from SCM"
	(version at: 1) = $# ifTrue: [ version := version allButFirst asSymbol ].
	
	^ ((package version = aVersion asSemanticVersion) or: [ package version = version ])
 		ifTrue: [ package ]
		ifFalse: [ CGOPackageVersionNotFoundError signal ]
]

{ #category : #initialization }
CGOScmPackageMetadata >> initialize [
	projects := Dictionary new.
]

{ #category : #testing }
CGOScmPackageMetadata >> isVirtual: aPackageName [
	^ (self package: aPackageName) isVirtual
]

{ #category : #'versions fetching' }
CGOScmPackageMetadata >> latestVersionOfPackage: aPackageName suitableForEnvironment: platformAttributes [ 
	"just pick the current version in the SCM"
	^ (self package: aPackageName) asPackageVersionReference
]

{ #category : #accessing }
CGOScmPackageMetadata >> package: aPackageName [
	| dependency |
	dependency := PBPackageDependency on: aPackageName.
	^ dependency hasScope
		ifTrue: [ "For now, only Metacello projects have a scope"
			(projects 
				at: dependency scope
				ifAbsent: [ PBPackageNotFoundError signal: dependency dependencyName ]) 
					detect: [ :each | each hasPackage: dependency targetedPackage ] ]
		ifFalse: [ self packageVersions
			detect: [ :each | each packageName = aPackageName ]
			ifNone: [ "package name could be the name of a project"
				(projects 
					at: aPackageName 
					ifAbsent: [ PBPackageNotFoundError signal: aPackageName ]) 
						detect: [ :each | each hasPackage: 'default' ] ] ]
]

{ #category : #accessing }
CGOScmPackageMetadata >> packageVersions [
	self flag: 'in the future, we should check in which external project to find the package'.
	^ projects values flattened
]

{ #category : #'versions fetching' }
CGOScmPackageMetadata >> packagesProviding: aName version: aSemanticVersion forEnvironment: platformAttributes [
	"We ignore virtual package version as we load from SCM, eveything should be in sync."
	"We also ignore platformAttributes as a virtual package has no platform attribute"
	| virtualPkgVersion |
	virtualPkgVersion := (CGOPackageVersionReference packageName: aName version: aSemanticVersion).
	^ self packageVersions 
		select: [ :each | 
			each isUnit
			and: [ (each provisions includes: virtualPkgVersion) 
			and: [ CGOPackageRepository new does: each fitPlatformRequirements: platformAttributes ] ] ]
]

{ #category : #private }
CGOScmPackageMetadata >> registerExternalProjectsOf: aCGOProject [
	"Add external projects metadata to this SCM package repository"
	aCGOProject pakbotProjectDependencies
		do: [ :projectDependency | 
			self
				registerProjectFromSourceRepository: projectDependency repository
				at: projectDependency name ].
	aCGOProject metacelloProjects
		do:
			[ :cgoMetacelloProject | self registerProject: cgoMetacelloProject at: cgoMetacelloProject name ]
]

{ #category : #adding }
CGOScmPackageMetadata >> registerProject: aCGOProject at: projectIdentifier [
	"Add external projects metadata to this SCM package repository"
	| packageVersions |
	
	packageVersions := Set new.
	packageVersions add: aCGOProject.
	aCGOProject packageUnits , aCGOProject assemblies, aCGOProject virtualPackages
		do: [ :pkgVersion | packageVersions add: pkgVersion ].
		
	projects
		at: (projectIdentifier ifNil: [ aCGOProject packageName ])
		put: packageVersions.
	self registerExternalProjectsOf: aCGOProject.
	^ aCGOProject
]

{ #category : #adding }
CGOScmPackageMetadata >> registerProjectFromSourceRepository: aCGOSourceRepository [
	^ self 
		registerProjectFromSourceRepository: aCGOSourceRepository
		at: nil
]

{ #category : #adding }
CGOScmPackageMetadata >> registerProjectFromSourceRepository: aCGOSourceRepository at: projectId [
	^ self 
		registerProject: (PBProjectVersion fromRepository: aCGOSourceRepository)
		at: projectId
]
