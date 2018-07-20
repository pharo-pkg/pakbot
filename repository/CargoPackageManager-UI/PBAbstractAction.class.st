Class {
	#name : #PBAbstractAction,
	#superclass : #Object,
	#category : #'CargoPackageManager-UI-Actions'
}

{ #category : #execution }
PBAbstractAction >> doExecute [
	^ self subclassResponsibility 
]

{ #category : #execution }
PBAbstractAction >> execute [

	[ ^ self doExecute ]
		on: PBError
		do: [ :ex | ex acceptVisitor: PBErrorVisitor default ]
]
