Extension { #name : #CGOAbstractDependency }

{ #category : #'*CargoPackageManager-UI' }
CGOAbstractDependency >> balloonText [
	self isInstalled ifFalse: [ ^ 'The dependency is not installed in the image' ].
	^ nil
]

{ #category : #'*CargoPackageManager-UI' }
CGOAbstractDependency >> iconName [
	^ self isInstalled
		ifTrue: [ #package ]
		ifFalse: [ #error ]
]
