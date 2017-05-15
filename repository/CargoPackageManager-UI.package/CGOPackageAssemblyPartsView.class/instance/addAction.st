adding
addAction
	| package |
	package := (self packageSelectionDialogFor: self candidatePackages) chooseFromOwner: self widget widget.
	package ifNotNil: [ ongoingPackageVersion addPart: package packageName ].