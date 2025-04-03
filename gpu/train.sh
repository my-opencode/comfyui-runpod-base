#!/bin/bash
die () {
    echo >&2 "$@";
    exit 1;
}

[ "$#" -eq 2 ] || die "Train requires exactly two arguments, $# provided.";
echo $1 | grep -E -q '\.yaml$' || die "First argument must be the name of the config YAML file, $1 provided.";
#[ -d "$2" ] || die "Second argument must be the path to the dataset directory. $dir does not exist.";

mkdir /.cred;
echo "$SECRET_GCP_CRED" > /.cred/cred.json

# Download training files
gcloud auth activate-service-account --key-file /.cred/cred.json;
mkdir -p /workspace/datasets;
gsutil -m cp -r "gs://$GCP_PATH_TO_DATASETS/$2" "/workspace/datasets/$2";
gsutil -m cp "gs://$GCP_PATH_TO_CONFIGS/$1" "/workspace/ai-toolkit/config/$1";
gcloud auth revoke --all;

# Train
source /workspace/ait-toolkit/venv/activate && python /workspace/ai-toolkit/run.py "/workspace/ai-toolkit/config/$1";

# Upload trained files
gcloud auth activate-service-account --key-file /.cred/cred.json;
gsutil -m cp "/workspace/trained_loras/$2" "gs://$GCP_PATH_TO_TRAINED_LORAS/$2";
gcloud auth revoke --all;