Extension { #name : #PBAbstractDependency }

{ #category : #'*Pakbot-Browser' }
PBAbstractDependency >> statusIconName [
	^ self isInstalled
		ifTrue: [ #package ]
		ifFalse: [ 
			self isOutOfSync 
				ifTrue: [ #flag ]
				ifFalse: [ #error ]]
]
