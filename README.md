![Image of Pakbot](/cargo-picture-small.png)

# Pakbot package manager [![Build Status](https://github.com/demarey/SubProcess/actions/workflows/main.yml/badge.svg)](https://github.com/demarey/SubProcess/actions/workflows/main.yml)
Pakbot is a lightweitgh package manager for Smalltalk.

## What are the motivations behind Pakbot?
* Dependencies expressed at the package level. We want that each package describes its own dependencies in a synthetic way.
* Dependencies as first-class objects, so that tools can use them to offer added value
* Better handling of platform-specific packages. In big project with a lot of dependencies that could be run on various platforms (e.g. Seaside), the description of platform-specific dependendies leads to wide specification, hard to maintain. Cargo tries to solve this problem by providing a low-coupling dependency to manage this kind of dependencies.
* Support update strategies through the use of semantic versionning
* Provide a central place to publis package versions and provide a web site on top of it to query on available packages (something similar to https://packagist.org/).

## Cargo big picture
![Cargo big picture](/doc/cargo-overview.png)

## Pakbot basics
Pakbot is a package manager. It automates the process of installing, upgrading and removing Smalltalk programs and libraries for a Smalltalk image in a consistent manner. A package manager deals with packages, distributions of software. Pakbot deals with Projects containing metadata and packages, such as the software's name, description of its purpose, version number, vendor,  and a list of dependencies necessary for the software to run properly.
### Projects
Projects are the unit of distribution of a software. It is the minimal artefact you can load. Pakbot defines 3 kind of packages:
* **package unit**: it represents a piece of code in a specific version. It has dependencies.
* **package assembly**: it represents a set of package units or package assemblies. It is useful to group a coherent set of packages all together. Assemblies do not have dependencies.
* **virtual package**: they are there to manage smoothly platform-specific packages. A virtual package is a special kind of package. It has only a name, a version and a description (you can define here the contract implied by the virtual package). Some concrete packages (units) will provide them, some others will require them. They offer low-coupling in dependencies description but have to be used carefully (no formal contract, just rely on the package name and version). This concept comes from the [Debian distribution] (http://www.linuxtopia.org/online_books/linux_system_administration/debian_linux_guides/debian_linux_faq/ch-pkg_basics.en_007.html).
![Pakbot packages](/doc/cargo-packages.png)

<!-- ### Dependency description
With Pakbot, dependencies are expressed at the package level (as well as other package metadata). It means each package knows its dependencies. 
There is a working copy of the dependencies within the package. It is part of the package metadata. This working copy of dependencies intend to be easy to manage: you mostly describe a dependency by refering to a package name (no specific version, assumes it refers to the package of the same name already in the image).
When you want to share a version of your package, you will publish it to the Pakbot package repository so that it becomes available to anyone. During the publishing process, numberered (Pakbot) versions will be added to the dependencies to get reproducible loadings.
-->
### Loading projects
You can ask Pakbot to load one or many projects. Pakbot will select adequate project versions according to your platform attributes and already installed projects. The package selection is called the solving of the user query. It results in getting back Pakbot **load instructions** that is an object representing the list of projects to load in order.
Pakbot load instructions are serializable so that they can be used for off-line loading for example.

### Updating projects
Pakbot relies on [semantic versioning](http://semver.org/) to determine compatibility between versions of a package. It implies that **only a major version change could break the backward-compatibility** of a project. In other words, a patch version update (e.g. 1.2.0 => 1.2.1) or a minor version update (e.g. 1.2.1 => 1.3) should be compitable with packages working with the previous version. So, it is important that developers update the version number of a package with care by asking himself some questions: 
 * did I make incompatible API changes? If yes, a major version increment is needed.
 * did I introduce new functionalities without breaking backward-compatibility?. If yes, a minor version increment is needed.
 * did I fix a bug in a backward-compatible way? If yes, a patch version increment is needed.
In development mode, to avoid to publish a new package version to share your code with users or developers, you can use a special suffix (e.g. 2.1-dev) to tag a version as a development version. Pakbot will allow you to override this version in the Pakbot package repository. It means that you will be able to publish many times the same version with possibly different code.

## How to use Pakbot?
Pakbot comes with an API inspired by the one available in the latest versions of [Metacello](https://github.com/dalehenrich/metacello-work).

### Install Pakbot
```smalltalk
Metacello new 
	repository: 'github://pharo-pkg/pakbot/repository';
	baseline: 'Pakbot';
	load
```

<!-- ### Load projects
To load a project with its dependencies, you just need to ask Pakbot to install the top-level package (i.e. the project assembly) describing all parts of the project.
```smalltalk
Pakbot new 
	project: 'MyProject' version:'1.3';
	install
```
It will load into the image the package *MyProject* in version *1.3* and all its dependencies. To achieve that, Pakbot computes the list of packages to load and determines the load order. This package list is called **Pakbot load instructions**. You can get this list by Calling #loadInstructions as follows:
```smalltalk
loadInstructions := Pakbot new 
	package: 'MyProject' version:'1.3';
	loadInstructions
```
These instructions can be saved into a file for further reuse:
```smalltalk
loadInstructions saveTo: 'MyProject-1.3-loadinstructions.ston' asFileReference.

Pakbot new
	installFromFile: 'MyProject-1.3-loadinstructions.ston' asFileReference.
```
Instead of installing packages, you can only fetch them for further installation (possibly when you are off-line with no internet connection):
```smalltalk
Pakbot new 
	package: 'MyProject';
	fetch
```
It will fetch packages into the unique instance of the MCCacheRepository. If you want to ftech packages into a specific folder, the use the *#fetchInto:* message.
```smalltalk
Pakbot new 
	package: 'MyProject';
	fetchInto: '/home/me/my-cache'
``` -->

### Publish a package
When you are done with the development phase (including testing) of your functionality, you are ready to share this new version to your users. Ensure that 
- you saved your code to your prefered Source Code Management system,
- the package metadata are up to date: package name, version number, source code repository, package dependencies, package description, etc.
Once done, you can publish your package to the Pakbot repository.

<!-- #### Using the scripting API
To publish a package using the scripting API, you first need to get the object able to interact with package metadata: an OngoingPackageVersion (it has 2 subclasses: OngoingPackageUnit and OngoingPackageAssembly). With this object, you can easily update the package metadata. Once done, you need to send the message *#asPackageVersion* to the ongoing package version to get a package version. This object is a read-only object. You can now ask to the Pakbot repository to save this new package version:
```smalltalk
ongoing := (CGOPackageRegistry default packageNamed: #'Pharo-Kernel') asOngoingPackageVersion.
Pakbot defaultPackageRepository savePackageVersion: ongoing asPackageVersion
```
You can also set up your own Pakbot package repository if you do not want to use the default one.
```smalltalk
pkgRepository := CGODirectoryPackageRepository newWithFileName: 'pakbot-repo'.
```
If you want to use it as the default Pakbot repository, just tell it to Pakbot:
```smalltalk
Pakbot defaultPackageRepository: pkgRepository.
```
#### Using the User Interface
Will come soon

[//]: # (### List packages installed in the image)
[//]: # (### Update packages already installed)


## FAQ
### Where should I update my package dependencies?
Dependencies are part of package metadata. Package metadata is managed through living ojects in the Pharo image. You can retrieve them through the Pakbot registry. You can edit pacakge metadata by sending messages to the corresponding ongoing package version or by using the dedicated UI.
The DependencyAnalyzer tool could also help to find the dependencies of a package. It is also available from Nautilus contextual menu on a package: "browse dependencies ..."
### Do I need to release and publish all packages of my project independently?
The anwser is no! It would be a tedious work to release all packages independently. Pakbot comes with some tools to automatize the release and the publication of a set of packages.
### Do I need to specify a version number for all dependencies?
No, version number for dependencies are optional for the current working copy of the package metadata. More, it is recommanded to do not specify the version number but only describe the package you depend on. The version of a dependency is only required when you release a new version of your package. At this time, if no version is specified, Pakbot will use the package version of the dependency currently in the image.
-->