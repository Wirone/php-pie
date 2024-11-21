FROM curlimages/curl AS phar-downloader

ARG PIE_VERSION

RUN curl -L --output /tmp/pie https://github.com/php/pie/releases/download/${PIE_VERSION}/pie.phar \
    && chmod +x /tmp/pie \
    && curl -L --output /tmp/pie.asc https://github.com/php/pie/releases/download/${PIE_VERSION}/pie.phar.asc

FROM scratch AS standalone-binary

COPY --from=phar-downloader /tmp/pie /pie
COPY --from=phar-downloader /tmp/pie.asc /pie.asc
