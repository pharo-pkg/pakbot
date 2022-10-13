"
Root error class for all Cargo package manager errors.
"
Class {
	#name : #PBError,
	#superclass : #Error,
	#category : #'Pakbot-Minimal-Model'
}

{ #category : #visiting }
PBError >> acceptVisitor: aVisitor [

	^ aVisitor visitGenericError: self
]
