# Security Command Center gcloud Commands

### All Public Findings
```bash
gcloud scc findings list organizations/ORGANIZATION_ID --location=global \
  --filter="category=\"PUBLIC_BUCKET_ACL\" OR category=\"PUBLICLY_READABLE_BUCKET\" OR category=\"PUBLICLY_WRITABLE_BUCKET\" OR category=\"BUCKET_POLICY_ONLY_DISABLED\" OR category=\"PUBLIC_SQL_INSTANCE\" OR category=\"SQL_INSTANCE_WITH_PUBLIC_IP\" OR category=\"SQL_INSTANCE_OPEN_TO_WORLD\" OR category=\"OPEN_FIREWALL\" OR category=\"FIREWALL_RULE_ALLOWS_ALL_PORTS\" OR category=\"INSECURE_FIREWALL_RULE\" OR category=\"BIGQUERY_TABLE_PUBLICLY_READABLE\" OR category=\"BIGQUERY_DATASET_PUBLICLY_READABLE\" OR category=\"CLOUD_FUNCTION_OPEN_HTTP_TRIGGER\" OR category=\"UNAUTHENTICATED_CLOUD_FUNCTION\" OR category=\"APP_ENGINE_FIREWALL_RULE_ALLOWS_ALL\" OR category=\"LOAD_BALANCER_ALLOWS_ALL_PORTS\" OR category=\"INSECURE_LOAD_BALANCER_BACKEND\" OR category=\"CLUSTER_PUBLICLY_ACCESSIBLE\" OR category=\"GKE_NODE_PUBLICLY_ACCESSIBLE\" OR category=\"KUBERNETES_SERVICE_WITH_EXTERNAL_IP\" OR category=\"PUBLIC_COMPUTE_VM_WITH_ADMIN_SERVICE_ACCOUNT\" OR category=\"VM_INSTANCE_WITH_PUBLIC_IP\" OR category=\"ALLOYDB_PUBLIC_IP\" OR category=\"SPANNER_INSTANCE_PUBLIC\" OR category=\"DATAPROC_CLUSTER_PUBLIC\" OR category=\"REDIS_INSTANCE_PUBLIC\" OR category=\"MEMCACHED_INSTANCE_PUBLIC\" OR category=\"CLOUD_RUN_SERVICE_PUBLIC\" OR category=\"DNS_ZONE_PUBLIC\" OR category=\"PUB_SUB_TOPIC_PUBLIC\" OR category=\"CLOUD_ENDPOINTS_PUBLIC\" OR category=\"API_GATEWAY_PUBLIC\" OR category=\"CLOUD_COMPOSER_ENVIRONMENT_PUBLIC\" OR category=\"DATAFLOW_JOB_PUBLIC\" OR category=\"VERTEX_AI_ENDPOINT_PUBLIC\"" \
  --format=json | jq -r '["ResourceName","Category","ProjectId"], (.[] | [.finding.resourceName, .finding.category, .resource.projectDisplayName]) | @tsv'
```

### List All Public Access Findings
```bash
gcloud scc findings list ORGANIZATION_ID \
  --filter="category:('PUBLIC_BUCKET_ACL' OR 'PUBLIC_SQL_INSTANCE' OR 'OPEN_FIREWALL' OR 'BIGQUERY_TABLE_PUBLICLY_READABLE' OR 'CLOUD_FUNCTION_OPEN_HTTP_TRIGGER')"
```

### Cloud Storage Public Access
```bash
gcloud scc findings list ORGANIZATION_ID \
  --filter="category:('PUBLIC_BUCKET_ACL' OR 'PUBLICLY_READABLE_BUCKET' OR 'PUBLICLY_WRITABLE_BUCKET' OR 'BUCKET_POLICY_ONLY_DISABLED')" \
  --format="table(name,category,resourceName,createTime)"
```

### Network Security Issues
```bash
gcloud scc findings list ORGANIZATION_ID \
  --filter="category:('OPEN_FIREWALL' OR 'FIREWALL_RULE_ALLOWS_ALL_PORTS' OR 'INSECURE_FIREWALL_RULE')" \
  --format="table(name,category,resourceName,sourceProperties.networkConnection)"
```

### Database Public Access
```bash
gcloud scc findings list ORGANIZATION_ID \
  --filter="category:('PUBLIC_SQL_INSTANCE' OR 'SQL_INSTANCE_WITH_PUBLIC_IP' OR 'SQL_INSTANCE_OPEN_TO_WORLD')" \
  --format="table(name,resourceName,sourceProperties.databaseCluster)"
```

## Cloud Asset Inventory Queries

### Resources with Public IPs
```bash
gcloud asset search-all-resources \
  --scope="organizations/ORGANIZATION_ID" \
  --query="networkInterfaces.accessConfigs.natIP:*" \
  --asset-types="compute.googleapis.com/Instance,sqladmin.googleapis.com/Instance"
```

### IAM Policies with Public Access
```bash
gcloud asset search-all-iam-policies \
  --scope="organizations/ORGANIZATION_ID" \
  --query="policy.bindings.members:('allUsers' OR 'allAuthenticatedUsers')"
```

### Storage Buckets with Public Access
```bash
gcloud asset search-all-iam-policies \
  --scope="organizations/ORGANIZATION_ID" \
  --query="policy.bindings.members:('allUsers' OR 'allAuthenticatedUsers')" \
  --asset-types="storage.googleapis.com/Bucket"
```