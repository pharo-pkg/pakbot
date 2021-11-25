Extension { #name : #IceTipRepositoriesBrowser }

{ #category : #'*CargoPackageManager-UI' }
IceTipRepositoriesBrowser class >> pakbotCommandsWith: presenter forRootGroup: aCommandGroup [

	<extensionCommands>
	| newGroup |
	newGroup := CmCommandGroup forSpec
		name: 'Pakbot';
		description: 'Pakbot operations';
		yourself.
	
	(aCommandGroup commandOrGroupNamed: 'Selection') register: newGroup.

	presenter selectedItem ifNotNil: [ 
		PBIcebergPakbotMenuGroup new
			addCommandsForRepository: presenter selectedItem intoGroup: newGroup ]

]
