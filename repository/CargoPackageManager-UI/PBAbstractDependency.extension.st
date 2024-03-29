Extension { #name : #PBAbstractDependency }

{ #category : #'*CargoPackageManager-UI' }
PBAbstractDependency >> balloonText [
	self isInstalled ifTrue: [ ^ nil ].
	self isOutOfSync ifTrue: [ ^ 'The installed version of this dependency is not the same as required' ].
	^ 'The dependency is not installed in the image'
]
