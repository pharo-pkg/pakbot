as yet unclassified
open
| package seaside31Dependency resolution builder  |
	package := Seaside31Spec new buildPackage.
	seaside31Dependency := CGOPackageDependency 
									on: package package
									for: nil
									withConstraints: { CGOFixedVersionConstraint with: '3.1' }.
	resolution := CGOSolver new solveDependency: seaside31Dependency.
	
	builder := ROMondrianViewBuilder new.
	builder zoomInButton;zoomOutButton.
	builder title: 'Seaside 3.1 Representation'.
	builder interaction
		highlightWhenOver: [ :aPackageVersion | aPackageVersion dependencies collect: [ :item | (resolution resolvedDependencyFor: item targetedPackage) packageVersion ]  ].
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
	builder edgesToAll: [ :aPackageVersion | aPackageVersion dependencies collect: [ :item | (resolution resolvedDependencyFor: item targetedPackage) packageVersion ] ].
	builder treeLayout verticalGap: 50. "Size between the lines of the tree. By default we can't see the edges"
	builder open.
	
	
	
	"builder view edges
		do: [ :edge | 
			| lbl |
			lbl := (ROLabel text: ""(self selectorFrom: edge from model to: edge to model) asString) element"" 'toto') element.
			builder view add: lbl.
			ROConstraint stick: lbl onEdge: edge ]"