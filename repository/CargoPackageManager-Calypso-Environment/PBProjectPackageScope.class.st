Class {
	#name : #PBProjectPackageScope,
	#superclass : #ClyTypedScope,
	#category : #'CargoPackageManager-Calypso-Environment-Queries'
}

{ #category : #accessing }
PBProjectPackageScope >> classGroupProvidersDo: aBlock [ 
	| providers |
	
	environment pluginsDo: [ :plugin |
		providers := plugin collectClassGroupProviders.
		providers do: aBlock]
]

{ #category : #accessing }
PBProjectPackageScope >> classGroupsDo: aBlockClosure [

	self classGroupProvidersDo: [ :groupProvider | groupProvider 
				classGroupsIn: self 
				do: [ :group | 
					aBlockClosure value: group ] ]
]

{ #category : #iterating }
PBProjectPackageScope >> classesDo: aBlockClosure [

	^ self basisObjects select: [ :each | each isInstalled ] thenDo: [ :each | each systemPackage classes do: aBlockClosure ]
]

{ #category : #accessing }
PBProjectPackageScope >> packagesDo: aBlockClosure [

	^ self basisObjects
		select: [ :each | each isInstalled ]
		thenDo: [ :each | aBlockClosure value: each systemPackage ]
]
