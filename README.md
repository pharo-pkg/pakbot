![Image of Cargo](/cargo-picture-small.png)

# Cargo package manager

Cargo is a leightweitgh package manager for Smalltalk.

## What are the motivations behind Cargo?
* Dependencies expressed at the package level. We want that each package describes its own dependencies in a synthetic way.
* Dependencies as first-class objects, so that tools can use them to offer added value
* Better handling of platform-specific packages. In big project with a lot of dependencies that could be run on various platforms (e.g. Seaside), the description of platform-specific dependendies leads to wide specification, hard to maintain. Cargo tries to solve this problem by providing a low-coupling dependency to manage this kind of dependencies.
* Support update strategies through the use of semantic versionning
* Provide a central place to publis package versions and provide a web site on top of it to query on available packages (something similar to https://packagist.org/).

## Cargo big picture
![Cargo big picture](/doc/cargo-overview.png)

## Cargo basics
Cargo is a package manager. It automates the process of installing, upgrading and removing Smalltalk programs and libraries for a Smalltalk image in a consistent manner. A package manager deals with packages, distributions of software. Packages contain metadata, such as the software's name, description of its purpose, version number, vendor,  and a list of dependencies necessary for the software to run properly.
### Packages
Packages are the unit of distribution of a software. It is the minimal artefact you can load. Cargo defines 3 kind of packages:
* **package unit**: it represents a piece of code in a specific version. It has dependencies.
* **package assembly**: it represents a set of package units or package assemblies. It is useful to group a coherent set of packages all together. Assemblies do not have dependencies.
* **virtual package**: they are there to manage smoothly platform-specific packages. A virtual package has only a name. Some concrete packages (units) will provide them, some others will require them. They offer low-coupling in dependencies description but have to be used carefully (no specified contract, just rely on the package name). This concept comes from the [Debian distribution] (http://www.linuxtopia.org/online_books/linux_system_administration/debian_linux_guides/debian_linux_faq/ch-pkg_basics.en_007.html).
![Cargo packages](/doc/cargo-packages.png)

## How to use Cargo?
Cargo comes with an API inspired by the one available in the latest versions of [Metacello](https://github.com/dalehenrich/metacello-work).

### Install Cargo
### Load packages
### 

[](### List packages installed in the image)
[](### Update packages already installed)
