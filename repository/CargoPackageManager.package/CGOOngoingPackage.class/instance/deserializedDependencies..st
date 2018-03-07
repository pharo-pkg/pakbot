private - deserialization
deserializedDependencies: aListOfSerializedDependencies
	^ aListOfSerializedDependencies 
		ifNil: [ OrderedCollection empty ]
		ifNotNil: [ aListOfSerializedDependencies collect:
				[ :associationOrString | | association |
					association := associationOrString isString 
						ifTrue: [ associationOrString -> #() ]
						ifFalse: [ associationOrString ].
					CGOPackageDependency newFrom: association ] ]