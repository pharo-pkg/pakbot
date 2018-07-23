Extension { #name : #CGOAbstractDependency }

{ #category : #'*CargoPackageManager-UI' }
CGOAbstractDependency >> balloonText [
	self isInstalled ifTrue: [ ^ nil ].
	self isOutSync ifTrue: [ ^ 'The installed version of this dependency is not the same as required' ].
	^ 'The dependency is not installed in the image'
]

{ #category : #'*CargoPackageManager-UI' }
CGOAbstractDependency >> iconName [
	^ self isInstalled
		ifTrue: [ #package ]
		ifFalse: [ 
			self isOutSync 
				ifTrue: [ #flag ]
				ifFalse: [ #error ]]
]
