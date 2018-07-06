execution
execute

	| dialog |
	dialog := CGOImportPackagesDialog on: project.
	dialog openDialogWithSpec
		okAction: [
			dialog accept.
			self refreshCalypsoChild ].