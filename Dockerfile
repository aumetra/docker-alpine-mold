###############
# Build stage #
###############
FROM alpine:latest AS build

# Install mold dependencies
RUN apk add --no-cache --update git clang cmake openssl-dev zlib-dev xxhash-dev build-base linux-headers
WORKDIR /build

# Do a shallow fetch of the mold repository
RUN git clone --depth=1 https://github.com/rui314/mold.git .
RUN make -j$(nproc) CXX=clang++

##########################
# Build the actual image #
##########################
FROM alpine:latest

# Install clang because the Rust configuration will invoke it at link time
RUN apk add --no-cache --update clang build-base tar
COPY --from=build /build/mold /usr/local/bin/mold
COPY rust-config.toml ~/.cargo/config.toml

# Create some symlinks
RUN ln -sf /usr/bin/clang /usr/bin/cc
RUN ln -sf /usr/bin/clang++ /usr/bin/c++
RUN ln -sf /usr/local/bin/mold /usr/bin/ld

ENTRYPOINT [ "/usr/local/bin/mold" ]
