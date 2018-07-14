Extension { #name : #AssemblyManifest }

{ #category : #'*CargoPackageManager' }
AssemblyManifest class >> asOngoingPackageVersion [
	^ CGOOngoingPackageAssembly on: self
]

{ #category : #'*CargoPackageManager' }
AssemblyManifest class >> gtInspectorDescriptionIn: composite [
	<gtInspectorPresentationOrder: 30>  
	
	(CGOOngoingPackageAssembly on: self)
		gtInspectorDescriptionIn: composite
]

{ #category : #'*CargoPackageManager' }
AssemblyManifest class >> gtInspectorPartsIn: composite [
	<gtInspectorPresentationOrder: 35>  
	
	(CGOOngoingPackageAssembly on: self)
		gtInspectorPartsIn: composite
]

{ #category : #'*CargoPackageManager' }
AssemblyManifest class >> gtInspectorVersionIn: composite [
	<gtInspectorPresentationOrder: 40>
	
	(CGOOngoingPackageAssembly on: self)
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
