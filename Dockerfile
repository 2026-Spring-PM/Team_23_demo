FROM --platform=linux/amd64 ubuntu:24.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    libsfml-graphics2.6 \
    libsfml-window2.6 \
    libsfml-system2.6 \
    libfreetype6 \
    libx11-6 \
    libxrandr2 \
    libxcursor1 \
    libudev1 \
    libgl1 \
    libopenal1 \
    libvorbisfile3 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY farmvillage ./farmvillage
COPY assets ./assets

RUN chmod +x ./farmvillage

ENTRYPOINT ["./farmvillage"]