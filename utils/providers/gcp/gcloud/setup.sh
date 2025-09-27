#!/usr/bin/env bash


## ---------- ARGUMENTS
GCP_PROJECT_ID="$1"



## ---------- VARIABLES
SA_ID="secretctl-cli"
SA_NAME="secretctl-cli"
SA_ROLE_NAME="CustomRoleSecretctlCli"
SA_IAM_ACCOUNT="${SA_NAME}@${GCP_PROJECT_ID}.iam.gserviceaccount.com"
SA_KEY_JSON_FILE_PATH="${HOME}/Downloads/gcp-${GCP_PROJECT_ID}-${SA_NAME}-sa-key.json"
ROLE_PERMISIONS_FILE_PATH="${PWD}/role-permissions.yaml"


## ---------- CHECKS
MISSING_ARGS=0
if [ -z "$1" ]; then
    echo -e "$(date +"%Y/%m/%d %H%M%S") [MISSING_ARGS] [ERROR] - Invalid value for the GCP_PROJECT_ID argument."
    MISSING_ARGS=$((MISSING_ARGS + 1))
fi

if [ "${MISSING_ARGS}" -ne 0 ]; then
    echo -e "$(date +"%Y/%m/%d %H%M%S") [MISSING_ARGS] [ERROR] - One or more required arguments are missing."
    echo -e "Required arguments:\n- GCP_PROJECT_ID"
fi



## ---------- MAIN
echo -e "$(date +"%Y/%m/%d %H%M%S") [INFO] - Creating a Service Account: ${SA_NAME}"
gcloud iam service-accounts create "${SA_ID}" \
    --display-name="${SA_NAME}" \
    --description="Service Account for the ${SA_NAME}" \
    --project="${GCP_PROJECT_ID}"

echo -e "$(date +"%Y/%m/%d %H%M%S") [INFO] - Creating a Service Account Key JSON: ${SA_KEY_JSON_FILE_PATH}"
gcloud iam service-accounts keys create \
    "${SA_KEY_JSON_FILE_PATH}" \
    --iam-account="${SA_IAM_ACCOUNT}"

echo -e "$(date +"%Y/%m/%d %H%M%S") [INFO] - Creating a Role: ${SA_ROLE_NAME}"
gcloud iam roles create "${SA_ROLE_NAME}" \
  --project="${GCP_PROJECT_ID}" \
  --file="${ROLE_PERMISIONS_FILE_PATH}"

echo -e "$(date +"%Y/%m/%d %H%M%S") [INFO] - Binding the Role into the Service Account: ${SA_IAM_ACCOUNT} > ${SA_ROLE_NAME} "
gcloud projects add-iam-policy-binding "${GCP_PROJECT_ID}" \
  --member="${SA_IAM_ACCOUNT}" \
  --role="roles/${SA_ROLE_NAME}"

echo -e "$(date +"%Y/%m/%d %H%M%S") [INFO] - All done, now you are ready to use your Service Account and consume the Cloud Provider Services."
echo -e "$(date +"%Y/%m/%d %H%M%S") [INFO] - To do it, you can run the command bellow to autenticate using your Service Account JSON file:"
echo -e "\ngcloud auth activate-service-account --key-file=${SA_KEY_JSON_FILE_PATH}\n"
