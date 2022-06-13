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
PBProjectUIItem class >> forProject: aPBProjectVersion [
	^ self new
		project: aPBProjectVersion;
		yourself
]

{ #category : #accessing }
PBProjectUIItem >> assemblyItems [
	^ project assemblies collect: [ :assembly | PBAssemblyUIItem forAssembly: assembly ]
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

{ #category : #accessing }
PBProjectUIItem >> items [
	^ OrderedCollection new
		addAll: self packageItems;
		addAll: self assemblyItems;
		yourself
]

{ #category : #accessing }
PBProjectUIItem >> packageItems [
	^ project packages collect: [ :package | PBPackageUIItem forPackage: package ]
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
