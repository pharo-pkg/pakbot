"
Gofer new smalltalkhubUser: 'ObjectProfile'
    project: 'Roassal';
    package: 'ConfigurationOfRoassal';
    load.
(Smalltalk at: #ConfigurationOfRoassal) load.

Seaside31Visualization new open
"
Class {
	#name : #CGOSeaside31Visualization,
	#superclass : #Object,
	#category : #'CargoPackageManager-Spec'
}

{ #category : #'as yet unclassified' }
CGOSeaside31Visualization >> open [
| package seaside31Dependency resolution builder  |
	package := Seaside31Spec new buildPackage.
	seaside31Dependency := PBPackageDependency 
									on: package package
									for: nil
									withConstraints: { PBFixedVersionConstraint with: '3.1' }.
	resolution := PBSolver new solveDependency: seaside31Dependency.
	
	builder := ROMondrianViewBuilder new.
	builder zoomInButton;zoomOutButton.
	builder title: 'Seaside 3.1 Representation'.
	builder interaction
		highlightWhenOver: [ :aPackageVersion | aPackageVersion dependencies collect: [ :item | (resolution resolvedDependencyFor: item targetedPackage) resolvedProjectVersion ]  ].
	"builder interaction
		noPopup;
		on: ROMouseLeftClick
		do: [ :event | ROFocusView on: event element ];
		item: 'inspect element' action: #inspect; Actions on the right click
		item: 'browse element class' action: [ :el | el browse ]."
	builder shape rectangle
		size: 40;
		withCenteredText.
	builder nodes: resolution resolvedDependencies.
	builder shape 
		arrowedLine;
		arrowedBezierLine.
	builder edgesToAll: [ :aPackageVersion | aPackageVersion dependencies collect: [ :item | (resolution resolvedDependencyFor: item targetedPackage) resolvedProjectVersion ] ].
	builder treeLayout verticalGap: 50. "Size between the lines of the tree. By default we can't see the edges"
	builder open.
	
	
	
	"builder view edges
		do: [ :edge | 
			| lbl |
			lbl := (ROLabel text: ""(self selectorFrom: edge from model to: edge to model) asString) element"" 'toto') element.
			builder view add: lbl.
			ROConstraint stick: lbl onEdge: edge ]"
]
