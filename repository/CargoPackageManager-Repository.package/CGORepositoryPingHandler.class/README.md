I handle REST requests for /ping.
I simply answer "pong".
I can be used to test if the web server is started and is able to handle requests. Tools like monit will be able to restart this image if a simple request to /ping fails.