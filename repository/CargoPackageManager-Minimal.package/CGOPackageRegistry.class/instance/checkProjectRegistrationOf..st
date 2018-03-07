private
checkProjectRegistrationOf: aProjectName
	^ [ self projectNamed: aProjectName.
		CGOPackageAlreadyRegistered signal: aProjectName , ' is already a registered project in the registry!' ]
		on: CGOPackageNotFoundError
		do: [ "ignore: project not registered. It is safe to register a new one" ]