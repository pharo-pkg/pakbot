Extension { #name : #AssemblyManifest }

{ #category : #'*CargoPackageManager' }
AssemblyManifest class >> asOngoingPackageVersion [
	^ PBAssembly on: self
]

{ #category : #'*CargoPackageManager' }
AssemblyManifest class >> gtInspectorDescriptionIn: composite [
	<gtInspectorPresentationOrder: 30>  
	
	(PBAssembly on: self)
		gtInspectorDescriptionIn: composite
]

{ #category : #'*CargoPackageManager' }
AssemblyManifest class >> gtInspectorPartsIn: composite [
	<gtInspectorPresentationOrder: 35>  
	
	(PBAssembly on: self)
		gtInspectorPartsIn: composite
]

{ #category : #'*CargoPackageManager' }
AssemblyManifest class >> gtInspectorVersionIn: composite [
	<gtInspectorPresentationOrder: 40>
	
	(PBAssembly on: self)
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
