copying
veryDeepCopyWith: deepCopier
	deepCopier references at: registry put: registry. "avoid recursion while copying"
	super veryDeepCopyWith: deepCopier