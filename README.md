# docker-alpine-mold

This builds an docker container that contains the latest mold built from main. I use this in my CI runs to speed up link times.  
It also copies a cargo configuration to link every cargo project with mold using clang to invoke it.  

Theoretically Alpine has the latest tagged mold release in its testing repository.  
Unfortunately I had trouble getting it to install so consider this image as kind of a dirty fix.  
