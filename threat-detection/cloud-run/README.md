# Threat Detection - Cloud Run

## Bulk Enable Modules

<details>

<summary>Click to expand</summary>

### Prerequisites
<b>Google Cloud SDK</b>: Ensure gcloud is installed and authenticated (gcloud auth login).

<b>Permissions</b>: The user running the script requires the Security Center Admin role (roles/securitycenter.admin) on the target Organization or Projects.

```bulk-enable-modules.sh```: The Bash script that executes the logic.

```request.json```: The configuration file defining which modules to enable. Modify as needed.

Note: If your environment has strict Data Residency requirements, you may need to remove `CLOUD_RUN_MALICIOUS_PYTHON_EXECUTED` and `CLOUD_RUN_MALICIOUS_SCRIPT_EXECUTED` from the JSON in the above file, as these use NLP techniques that may not be supported in all restricted regions.

### Usage

Run the script from your terminal:

```bash 
./bulk-enable-modules.sh
```

Option 1: Organization Level

Select this option to apply the configuration to your Organization root. Settings applied here are generally inherited by all folders and projects unless explicitly overridden.

- Input: Your numeric Organization ID (e.g., 123456789).

Option 2: Project Level

Select this option to apply the configuration to specific projects.

- Input: Space-separated Project IDs.

Example: prod-api-01 staging-api-01 dev-sandbox

### Troubleshooting


|Issue|Cause|Resolution|
|-|-|-|
|ERROR: 'request.json' not found|The JSON file is missing.|Ensure request.json is in the exact same folder as the script.
|Permission denied|Insufficient IAM roles.|Verify you have roles/securitycenter.admin on the target scope.|
|INVALID_ARGUMENT|Incorrect Module Name.|Check request.json against the official Google Cloud documentation for typos.
|FAILED_PRECONDITION|SCC Not Active.|Ensure Security Command Center is initialized for the target Organization/Project.|

### Notes
- Control Plane Detectors: This script manages Runtime detectors. Control plane detectors (like CLOUD_RUN_JOBS_CRYPTOMINING_COMMANDS) are managed via Event Threat Detection (ETD) settings and are not included in this batch update.

</details>