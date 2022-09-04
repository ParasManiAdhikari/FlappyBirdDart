FROM dart:2.17-sdk AS build

ENV PATH="${PATH}:.pub-cache/bin"
ADD pubspec.yaml pubspec.yaml
ADD web/ web/
RUN dart pub global activate webdev && \
    dart pub get
RUN webdev build --output web:build

FROM nginx:alpine
COPY --from=build /root/build /usr/share/nginx/html
