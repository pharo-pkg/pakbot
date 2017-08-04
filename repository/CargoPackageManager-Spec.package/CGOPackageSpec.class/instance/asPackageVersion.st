converting
asPackageVersion
	^ CGOPackageUnit newFrom:
	( Dictionary new
			add: #package -> self packageName asSymbol;
			add: #version -> self version;
			add: #dependencies -> self dependencies;
			add: #provisions -> (self provisions collect: [ :p | (CGOPackageVersionReference newOn: p) asString]);
			add: #description -> self description;
			add: #sourcePackageVersion -> self sourcePackageVersionObject;
			add: #platformRequirements -> self platformRequirements;
			add: #timestamp -> DateAndTime now;
			yourself )