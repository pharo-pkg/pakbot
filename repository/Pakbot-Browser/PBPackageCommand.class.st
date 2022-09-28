"
Abstract class for all the commands that works on packages.
"
Class {
	#name : #PBPackageCommand,
	#superclass : #PBCommand,
	#instVars : [
		'package'
	],
	#category : #'Pakbot-Browser-Commands'
}

{ #category : #accessing }
PBPackageCommand >> package [

	^ package ifNil: [ self context selectedPackage ]
]
