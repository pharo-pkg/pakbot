"
I display and allow edition of dependencies of the provided PackageVersion.
"
Class {
	#name : #CGOPackageDependenciesView,
	#superclass : #CGOPackageListEditor,
	#category : #'CargoPackageManager-UI'
}

{ #category : #example }
CGOPackageDependenciesView class >> example [
	| package registry project |
	
	registry := PBPackageRegistry new.
	project := PBProjectVersion named: #Foo.
	registry register: project.
	package := PBPackage example.
	package project registry: registry.
	package addDependencyOn: #Foo.
	
	^ (self on: package) openWithSpec 
]

{ #category : #actions }
CGOPackageDependenciesView >> addAction [
	
	PBNewDependencyDialog new 
		openDialogOnAccept: [ :dependency |
			self packageVersion addDependency: dependency buildDependency.
			self refreshUI ]
		onCancel: [ "Nothing" ]
]

{ #category : #configuration }
CGOPackageDependenciesView >> addButtonHelpString [
	^ 'Add a new dependency'
]

{ #category : #actions }
CGOPackageDependenciesView >> editAction [
	"only one fixed constraint managed for now"
	| dependency |
	dependency := self selectedPackage.
	dependency newEditPanel
		openDialogOnAccept: [ :modifiedDependency |
			self refreshUI ]
		onCancel: [  ]
]

{ #category : #configuration }
CGOPackageDependenciesView >> editButtonHelpString [
	^ 'Edit the dependency'
]

{ #category : #configuration }
CGOPackageDependenciesView >> packageListEditorLabel [
	^ 'Dependencies:'
]

{ #category : #actions }
CGOPackageDependenciesView >> removeAction: aCGOPackageDependency [ 
	self packageVersion removeDependency: aCGOPackageDependency
]

{ #category : #configuration }
CGOPackageDependenciesView >> removeButtonHelpString [
	^ 'Remove the dependency'
]

{ #category : #'private - building' }
CGOPackageDependenciesView >> roots [
	
	^ self packageVersion dependencies
]
