A PPMRemoteRepositoryProxy is a simply proxy to a remote PPM repository exposing the same API with Rest. This proxy hides the remote / networking part.

- endpoint is the base URL from where the ReST service is available.
- znClient holds an already configured Zinc client to perform requests.