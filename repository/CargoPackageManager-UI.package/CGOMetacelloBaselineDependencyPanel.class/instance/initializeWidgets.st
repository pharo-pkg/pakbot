initialization
initializeWidgets

	self initializeSpacePanel.

	baselineNameLabel := self newLabel label: 'Baseline of'.
	baselineNameInputText := self newTextInput 
		ghostText: 'e.g., MyProject';
		autoAccept: true.

	repositoryUrlLabel := self newLabel label: 'Repository Url'.
	repositoryUrlInputText := self newTextInput 
		ghostText: 'e.g., github://project-owner/project';
		autoAccept: true.
		
	sourceDirectoryLabel := self newLabel label: 'Source directory'.
	sourceDirectoryInputText := self newTextInput 
		ghostText: 'e.g., src';
		autoAccept: true.
		
	versionLabel := self newLabel label: 'Version'.
	versionInputText := self newTextInput 
		ghostText: 'e.g., v1.0.1';
		autoAccept: true.
		
	groupLabel := self newLabel label: 'Group'.
	groupInputText := self newTextInput 
		ghostText: 'e.g., development';
		autoAccept: true.
		
	self focusOrder 
		add: self baselineNameInputText;
		add: self repositoryUrlInputText;
		add: self sourceDirectoryInputText;
		add: self versionInputText;
		add: self groupInputText