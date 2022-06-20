"
I allow to browse a Packbot project package with the system browser
"
Class {
	#name : #PBBrowsePackageCommand,
	#superclass : #CmCommand,
	#category : #'Pakbot-Browser-Commands'
}

{ #category : #converting }
PBBrowsePackageCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #glamorousBrowse;
		name: 'Browse package';
		shortcutKey: $b meta;
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #executing }
PBBrowsePackageCommand >> execute [
	
	self package ifNotNil: [ :pkg | pkg systemPackage browse ].
]

{ #category : #executing }
PBBrowsePackageCommand >> package [
	^ self context selectedPackage
]
