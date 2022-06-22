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
PBPackageUIItem class >> forPackage: aPBPackage presenter: aSpPresenter [

	^ self new
		package: aPBPackage;
		presenter: aSpPresenter;
		yourself
]

{ #category : #testing }
PBPackageUIItem >> canBeRemovedFromAssembly [
	
	^ false
]

{ #category : #accessing }
PBPackageUIItem >> commands [
	^ { 
		PBBrowsePackageCommand .
		PBLoadPackageCommand .
		PBCommitProjectCommand .
		PBRemovePackageFromProjectCommand .
		PBRemovePackageFromSystemCommand .
	} collect: [ :cmd | cmd forSpecContext: presenter ]
]

{ #category : #accessing }
PBPackageUIItem >> displayName [
	^ package name
]

{ #category : #accessing }
PBPackageUIItem >> icon [
	| icon |
	
	icon := super icon.
	^ self isInstalled
		ifTrue: [ icon ]
		ifFalse: [ (icon asAlphaImageMorph
						alpha: 0.6;
						yourself) ]
]

{ #category : #accessing }
PBPackageUIItem >> iconName [
	^ #package
]

{ #category : #testing }
PBPackageUIItem >> isInstalled [
	
	^ package isInstalled
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
