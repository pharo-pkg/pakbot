Extension { #name : #CGOAbstractDependency }

{ #category : #'*CargoPackageManager-UI' }
CGOAbstractDependency >> balloonText [
	self isInstalled ifTrue: [ ^ nil ].
	self isOutOfSync ifTrue: [ ^ 'The installed version of this dependency is not the same as required' ].
	^ 'The dependency is not installed in the image'
]

{ #category : #'*CargoPackageManager-UI' }
CGOAbstractDependency >> statusIconName [
	^ self isInstalled
		ifTrue: [ #package ]
		ifFalse: [ 
			self isOutOfSync 
				ifTrue: [ #flag ]
				ifFalse: [ #error ]]
]
