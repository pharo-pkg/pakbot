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

## How to use Cargo?
Cargo comes with an API inspired by the one available in the latest versions of [Metacello](https://github.com/dalehenrich/metacello-work Metacello).
### Install Cargo
### Load packages
### 

[](### List packages installed in the image)
[](### Update packages already installed)
