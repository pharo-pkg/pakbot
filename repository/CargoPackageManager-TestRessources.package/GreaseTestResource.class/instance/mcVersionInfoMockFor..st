building
mcVersionInfoMockFor: reference
	^ MCVersionInfo
		name: reference name
		id: UUID new
		message: 'This is a mock version'
		date: Date today
		time: Time now
		author: reference author
		ancestors: #()