"
I display and allow edition of parts  of the provided ongoing Package Assembly.
"
Class {
	#name : #CGOPackageAssemblyPartsView,
	#superclass : #CGOPackageListEditor,
	#category : 'CargoPackageManager-UI'
}

{ #category : #example }
CGOPackageAssemblyPartsView class >> example [
	^ self openOn: (PBAssembly example)
]

{ #category : #adding }
CGOPackageAssemblyPartsView >> addAction [
	| package |
	package := (self packageSelectionDialogFor: self candidatePackages) chooseFromOwner: self widget widget.
	package ifNotNil: [ ongoingPackageVersion addPart: package packageName ].
]

{ #category : #configuration }
CGOPackageAssemblyPartsView >> addButtonHelpString [
	^ 'Add a new package to the assembly'
]

{ #category : #private }
CGOPackageAssemblyPartsView >> buildRoots [
	^ ongoingPackageVersion parts
]

{ #category : #querying }
CGOPackageAssemblyPartsView >> candidatePackages [
	| partsNames |
	partsNames := (ongoingPackageVersion parts collect: #targetedPackage) copyWith: ongoingPackageVersion packageName.
	^ (ongoingPackageVersion registry installedPackages
		reject: [ :packageVersion |	partsNames includes: packageVersion packageName  ]) asArray
]

{ #category : #actions }
CGOPackageAssemblyPartsView >> editAction [
	UIManager default alert: 'Cannot specify a specific version for an assembly part. If really needed, please, open a feature request in Cargo issue tracker'
]

{ #category : #configuration }
CGOPackageAssemblyPartsView >> editButtonHelpString [
	^ 'Edit an assembly part'
]

{ #category : #configuration }
CGOPackageAssemblyPartsView >> packageListEditorLabel [
	^ 'Assembly parts:'
]

{ #category : #private }
CGOPackageAssemblyPartsView >> packageSelectionDialogFor: aListOfPackages [
	^ ListDialogWindow new
		getList: [ :regexp | aListOfPackages "sorted" select: [ :package | regexp search: package packageName ] ];
		displayBlock: [ :package | package packageName ];
		title: 'Package to add to the project';
		yourself
]

{ #category : #actions }
CGOPackageAssemblyPartsView >> removeAction: aCGOPackageDependency [ 
	ongoingPackageVersion removePart: aCGOPackageDependency
]

{ #category : #configuration }
CGOPackageAssemblyPartsView >> removeButtonHelpString [
	^ 'Remove a package from the assembly'
]
