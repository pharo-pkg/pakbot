"
I'm an UI representation of a Packbot package
"
Class {
	#name : #PBPackageUIItem,
	#superclass : #PBAbstractUIItem,
	#instVars : [
		'package'
	],
	#category : #'Pakbot-Browser-Items'
}

{ #category : #'instance creation' }
PBPackageUIItem class >> forPackage: aPBPackage [
	^ self new
		package: aPBPackage;
		yourself
]

{ #category : #accessing }
PBPackageUIItem >> displayName [
	^ package name
]

{ #category : #accessing }
PBPackageUIItem >> iconName [
	^ #package
]

{ #category : #testing }
PBPackageUIItem >> isPackage [
	^ true
]

{ #category : #accessing }
PBPackageUIItem >> items [
	^ #()
]

{ #category : #accessing }
PBPackageUIItem >> package: aPBPackage [ 
	package := aPBPackage
]

{ #category : #accessing }
PBPackageUIItem >> pakbotItem [
	
	^ package
]

{ #category : #accessing }
PBPackageUIItem >> project [
	^ package project
]
