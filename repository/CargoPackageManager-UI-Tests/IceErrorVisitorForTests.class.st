"
Do not signal again a caught exception so that tests can assert the error is handled.
"
Class {
	#name : #IceErrorVisitorForTests,
	#superclass : #IceErrorVisitor,
	#category : #'CargoPackageManager-UI-Tests'
}

{ #category : #visiting }
IceErrorVisitorForTests >> visitGenericError: anError [
	"Do nothing. Error handled"
]
