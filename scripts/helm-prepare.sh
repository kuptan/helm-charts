#!/bin/bash

echo ">>> Generate helm packages..."
helm package charts/*

mv *.tgz packaged

echo ">>> Generating new index.yaml"
helm repo index --url https://github.com/kube-champ/helm-charts/tree/master/ .