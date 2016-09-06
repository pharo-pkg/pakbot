baselines
baseline01: spec
	<version: 'baseline-0.1'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/demarey/PPM/main'.
		spec 
			project: 'BabyMock2' with: [
				spec
					className: #ConfigurationOfBabyMock2;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/zeroflag/BabyMock2/main/' ];
			project: 'Roassal' with: [
				spec
					className: #ConfigurationOfRoassal;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/ObjectProfile/Roassal/main/' ].
		spec package: 'PackagesManager'. ].
