"
Abstract class for all the commands that works on assemblies.
"
Class {
	#name : #PBAssemblyCommand,
	#superclass : #CmCommand,
	#instVars : [
		'assembly'
	],
	#category : #'Pakbot-Browser-Commands'
}

{ #category : #accessing }
PBAssemblyCommand >> assembly [

	^ assembly ifNil: [ self context selectedAssembly ]
]
