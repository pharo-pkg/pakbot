"
I'm an UI representation of a Packbot project.
"
Class {
	#name : #PBProjectUIItem,
	#superclass : #PBAbstractUIItem,
	#instVars : [
		'project'
	],
	#category : #'Pakbot-Browser-Items'
}

{ #category : #'instance creation' }
PBProjectUIItem class >> forProject: aPBProjectVersion presenter: aSpPresenter [
	^ self new
		project: aPBProjectVersion;
		presenter: aSpPresenter;
		yourself
]

{ #category : #accessing }
PBProjectUIItem >> assemblyItems [
	^ (project assemblies 
		collect: [ :assembly | PBAssemblyUIItem forAssembly: assembly presenter: presenter ])
			sorted: [ :a :b | a displayName < b displayName ]
]

{ #category : #accessing }
PBProjectUIItem >> commands [
	^ { 
		PBLoadFullProjectCommand .
		PBRepairProjectCommand .
		PBCreatePackageInProjectCommand .
		PBImportPackageInProjectCommand .
		PBCreateAssemblyCommand .
		PBCommitProjectCommand .
		PBPublishProjectCommand .
		PBRemoveProjectCommand .
	} collect: [ :cmd | cmd forSpecContext: presenter ]
]

{ #category : #accessing }
PBProjectUIItem >> displayName [
	^ project name
]

{ #category : #accessing }
PBProjectUIItem >> iconName [
	self flag: 'TODO: handle not loaded projects, projects in error (#error)'.
	
	^ #configLoaded
]

{ #category : #testing }
PBProjectUIItem >> isProject [ 
	^ true
]

{ #category : #accessing }
PBProjectUIItem >> items [
	^ OrderedCollection new
		addAll: self packageItems;
		addAll: self assemblyItems;
		yourself
]

{ #category : #accessing }
PBProjectUIItem >> packageItems [
	^ (project packages 
		collect: [ :package | PBPackageUIItem forPackage: package presenter: presenter ])
			sort: [ :a :b | a displayName < b displayName ]
]

{ #category : #accessing }
PBProjectUIItem >> pakbotItem [
	
	^ project
]

{ #category : #accessing }
PBProjectUIItem >> project [
	^ project
]

{ #category : #initialization }
PBProjectUIItem >> project: aPBProjectVersion [ 
	project := aPBProjectVersion
]
