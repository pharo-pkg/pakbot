*CargoPackageManager-UI
gtInspectorVersionIn: composite
	<gtInspectorPresentationOrder: 40>
	(composite custom: CGOVersionBrowser new)
		act: [ :presentation :aManifest | 
					self updateVersion.
					presentation
						entity: PackageManifest;
						entity: aManifest	"Hack to force Glamour to refresh the pane even if the entity has the same id" ]
			icon: Smalltalk ui icons editIcon
			entitled: 'Edit version';
		act: [ :presentation :aManifest | self publishNewPackageVersion ]
			icon: GLMUIThemeExtraIcons glamorousSaveToUrl
			entitled: 'Publish a new package version';
		yourself