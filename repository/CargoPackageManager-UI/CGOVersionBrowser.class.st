"
GTBrowser used to display a semantic version.
"
Class {
	#name : #CGOVersionBrowser,
	#superclass : #GTObjectVariablesBrowser,
	#category : 'CargoPackageManager-UI'
}

{ #category : #building }
CGOVersionBrowser >> compose [
	self title: 'Version'.
	self tabulator with: 
	[ :browser |
		browser row: #variables; row: #evaluator.
		browser
			transmit to: #variables; 
			transformation: [ :aPackageManifest | aPackageManifest version asSemanticVersion ]; 
			andShow: [:a | self variablesIn: a ].
		browser
			transmit to: #evaluator; 
			andShow: [:a | self evaluatorIn: a ].
		browser
			transmit from: #variables;
			toOutsidePort: #selection;
			transformed: [:assoc | assoc ifNotNil: [assoc value]].
		browser
			transmit from: #evaluator;
			toOutsidePort: #selection ]
]
