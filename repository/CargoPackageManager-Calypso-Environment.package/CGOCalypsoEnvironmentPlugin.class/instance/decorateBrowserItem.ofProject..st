item decoration
decorateBrowserItem: anItem ofProject: aProject

	aProject project hasProblems
		ifTrue: [ anItem markWith: CGOProjectHasProblems ]