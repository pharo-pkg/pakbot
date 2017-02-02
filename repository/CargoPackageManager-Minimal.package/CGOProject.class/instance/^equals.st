comparing
= other
	"An ongoingProject and a project with the same name refers to the same entity."
	^ (other isKindOf: CGOProject)
		ifTrue: [ name == other name ]
		ifFalse: [ ^ false ]	