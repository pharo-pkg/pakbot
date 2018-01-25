private - deserialization
deserializeDependencies: aListOfSerializedDependencies
	dependencies := aListOfSerializedDependencies 
		ifNil: [ OrderedCollection empty ]
		ifNotNil: [ aListOfSerializedDependencies collect:
				[ :association | CGOPackageDependency newFrom: association ] ]