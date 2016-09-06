as yet unclassified
generateFor: aPackageName withDependencies: dependencies
		self new
			package: aPackageName;
			createClass;
			addDependencies: dependencies;
			addNameMethod;
			addVersionMethod;
			yourself.