Extension { #name : #AssemblyManifest }

{ #category : #'*CargoPackageManager' }
AssemblyManifest class >> asOngoingPackageVersion [
	^ CGOOngoingAssembly on: self
]

{ #category : #'*CargoPackageManager' }
AssemblyManifest class >> gtInspectorDescriptionIn: composite [
	<gtInspectorPresentationOrder: 30>  
	
	(CGOOngoingAssembly on: self)
		gtInspectorDescriptionIn: composite
]

{ #category : #'*CargoPackageManager' }
AssemblyManifest class >> gtInspectorPartsIn: composite [
	<gtInspectorPresentationOrder: 35>  
	
	(CGOOngoingAssembly on: self)
		gtInspectorPartsIn: composite
]

{ #category : #'*CargoPackageManager' }
AssemblyManifest class >> gtInspectorVersionIn: composite [
	<gtInspectorPresentationOrder: 40>
	
	(CGOOngoingAssembly on: self)
		gtInspectorVersionIn: composite
]

{ #category : #'*CargoPackageManager' }
AssemblyManifest class >> packageNamed: aString [
	^ self subclasses detect: 
		[ :manifest | 
		[ manifest packageName = aString asSymbol ]
			on: ShouldBeImplemented
			do: [ false ] ]
]
