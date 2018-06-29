private-monticello
mcVersionFor: aCGOMetacelloProject
	self flag: 'todo'.
	Metacello new 
		repository: aCGOMetacelloProject repository;
		configuration: '';
		baseline: '';
		version: '';
		load: ''.