FROM alpine:latest as build

RUN apk add --no-cache --update \
    git \
    qt5-qttools-dev \
    alpine-sdk \
    libusb-dev

RUN git clone https://github.com/gpsbabel/gpsbabel.git gpsbabel && \
    cd gpsbabel && \
    qmake-qt5 && make gpsbabel

FROM alpine:latest

RUN apk add --no-cache --update \
    libusb \
    qt5-qtbase

COPY --from=build /gpsbabel/gpsbabel /usr/local/bin/gpsbabel

ENTRYPOINT ["/usr/local/bin/gpsbabel"]
