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
PBAssemblyUIItem class >> forAssembly: aPBAssembly [
	^ self new
		assembly: aPBAssembly;
		yourself
]

{ #category : #initialization }
PBAssemblyUIItem >> assembly: aPBAssembly [ 
	assembly := aPBAssembly
]

{ #category : #accessing }
PBAssemblyUIItem >> displayName [
	^ assembly name
]

{ #category : #accessing }
PBAssemblyUIItem >> iconName [ 
	^ #image
]

{ #category : #accessing }
PBAssemblyUIItem >> items [ 
	^ assembly parts collect: [ :assemblyPart | self uiItemFor: assemblyPart ]
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
	^ assemblyPart uiItemIn: assemblyPart presenter: presenter
]
