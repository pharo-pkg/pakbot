instance-creation
package: packageName version: versionNumber

	^ self new
		package: packageName;
		version: versionNumber;
		signal