actions
editAction
	"only one fixed constraint managed for now"
	| dependency versionString |
	dependency := self selectedPackage.
	dependency newEditPanel
		openDialogOnAccept: [ :modifiedDependency |
			self refreshUI ]
		onCancel: [  ]