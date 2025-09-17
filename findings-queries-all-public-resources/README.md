# Finding Publicly Exposed Resources

## Console Filters (GUI)

Use these filters in the SCC Console to list public exposure findings, either per-resource type or all.

## gcloud Commands (CLI)

Use these commands in the GCP Console to list public exposure findings, either per-resource type or all.

## Usage Notes

1. Replace `ORGANIZATION_ID` with your actual organization ID
2. For project-level scans, use `--scope="projects/PROJECT_ID"`
3. Some findings may take time to appear in SCC after resources are created
4. Enable all SCC detectors for comprehensive coverage:
   - Security Health Analytics
   - Web Security Scanner
   - Event Threat Detection
   - Container Threat Detection