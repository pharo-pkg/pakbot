"
I'm an UI representation of a Packbot assembly
"
Class {
	#name : #PBAssemblyUIItem,
	#superclass : #PBAbstractUIItem,
	#instVars : [
		'assembly'
	],
	#category : #'Pakbot-Browser-Items'
}

{ #category : #'instance creation' }
PBAssemblyUIItem class >> forAssembly: aPBAssembly presenter: aSpPresenter [
	^ self new
		assembly: aPBAssembly;
		presenter: aSpPresenter;
		yourself
]

{ #category : #initialization }
PBAssemblyUIItem >> assembly: aPBAssembly [ 
	assembly := aPBAssembly
]

{ #category : #accessing }
PBAssemblyUIItem >> commands [
	^ { 
		PBAddPackageToAssemblyCommand .
		PBDeleteAssemblyCommand .
	} collect: [ :cmd | cmd forSpecContext: presenter ]
]

{ #category : #accessing }
PBAssemblyUIItem >> displayName [
	^ assembly name
]

{ #category : #accessing }
PBAssemblyUIItem >> iconName [ 
	^ #image
]

{ #category : #testing }
PBAssemblyUIItem >> isAssembly [

	^ true
]

{ #category : #accessing }
PBAssemblyUIItem >> items [ 
	^ assembly packages collect: [ :assemblyPart | self uiItemFor: assemblyPart ]
]

{ #category : #accessing }
PBAssemblyUIItem >> pakbotItem [
	
	^ assembly
]

{ #category : #accessing }
PBAssemblyUIItem >> project [

	^ assembly project
]

{ #category : #accessing }
PBAssemblyUIItem >> uiItemFor: assemblyPart [
	^ assemblyPart uiItemIn: assembly presenter: presenter
]
