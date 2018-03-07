private
checkPackageNameRegistrationOf: aPackageName
	^ [ self packageNamed: aPackageName.
		CGOPackageAlreadyRegistered signal: aPackageName , ' is already present in the registry!' ]
		on: CGOPackageNotFoundError
		do: [ "ignore: package not registered. It is safe to register a new one" ]