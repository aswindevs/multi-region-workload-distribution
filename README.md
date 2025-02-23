# 🌍 Multi-Region Workload Distribution

This repository provides Kubernetes configurations for managing multi-regional workload distribution across various microservices. The hierarchical structure simplifies workload management across multiple regions and environments.

---

## 📁 Repository Structure

The repository is organized as follows:

- **`application-helm-chart/`** - Shared Helm charts and Kubernetes templates.
- **`micro-services/`** - Kubernetes configurations for individual microservices.

---

## 📦 Microservices Structure

Each microservice follows a standardized structure:

```
micro-services/
├── service-name/
│   ├── base/
│   │   └── base.yaml  # Common configurations across all environments
│   ├── {environment}/ # Environment-specific (prod/dev/stg)
│   │   ├── global/
│   │   │   └── global.yaml  # Components common to all regions
│   │   ├── {region}/  # Region-specific (ap-south-1/eu-west-1/us-east-1)
│   │   │   ├── kustomization.yaml
│   │   │   ├── values.yaml
```

---

## 🛠️ Key Components

### **1️⃣ Base Configuration (`base.yaml`)**
```yaml
base:
  appName: service-name    # Workload name
  labels:
    all:
      workload-name: service-name
  annotations:
    deployments:
      reloader.stakater.com/auto: "true"
  envFromSecrets:
    - secretName: common-secrets
```

### **2️⃣ Region-Specific Values (`values.yaml`)**
```yaml
base:
  image:
    repository: docker.pkg.dev/productionapplication/service-name
    tag: v1
  labels:
    all:
      region: ap-south-1
```

### **3️⃣ Kustomization Configuration (`kustomization.yaml`)**
```yaml
namespace: prod  # or dev/stg

helmGlobals:
  chartHome: ./../../../../k8s/

helmCharts:
  - name: application-helm-chart
    releaseName: service-name
    valuesFile: ./values.yaml
    namespace: prod
    additionalValuesFiles:
      - "../../base/base.yaml"
      - "../global/global.yaml"
```

---

## 🌍 Multi-Region Management

This structure allows for seamless management of workloads across multiple regions, with a strategic split between global services and regional consumers.

### **🔹 Service Distribution Strategy**

#### 🌐 **Global Services**
- **API Servers** are deployed across all regions for high availability:
  - ap-south-1
  - eu-west-1
  - us-east-1

#### 🎯 **Regional Consumers**
- **Chat Processing** (us-east-1)
  - Specialized chat-based-generation workers
  - Text editor chat processors
  - Feed copy generation processors

- **AI Services** (ap-south-1)
  - Development and testing environment
  - AI model inference workers
  - Training pipelines

This distribution ensures:
- Global accessibility for API services
- Region-specific processing for data compliance
- Optimized resource utilization based on regional demand
- Cost-effective deployment of specialized workloads

---

## 🎯 Benefits of This Structure

### ✅ **Consistent Configuration**
✔ Standardized folder structure across all services.  
✔ Predictable configuration inheritance.  
✔ Easy to maintain and extend.

### ✅ **Environment Isolation**
✔ Clear separation between prod/dev environments.  
✔ Environment-specific configurations in the `global/` folder.  
✔ Prevents unintended configuration mixing.

### ✅ **Regional Flexibility**
✔ Simple process to add new regions.  
✔ Region-specific overrides allow fine-grained control.  
✔ Independent scaling per region.

### ✅ **Simplified Service Management**
```yaml
# Example: Adding a new region
micro-services/
└── api-server/
    └── prod/
        └── new-region/
            ├── kustomization.yaml  # Copy from an existing region
            └── values.yaml         # Update region-specific values
```

---

## 🔄 Configuration Flow

1️⃣ **Base configurations** provide default settings.  
2️⃣ **Environment globals** apply environment-specific settings.  
3️⃣ **Region-specific values** override configurations for local requirements.  
4️⃣ **Kustomization** combines all layers into a final configuration.  

---

## 🚀 Usage Examples

### **➕ Adding a New Region**
1. Create a new region folder under the relevant environment.
2. Copy `kustomization.yaml` from an existing region.
3. Create a `values.yaml` file with region-specific settings.
4. Update global DNS/routing if required.

### **🔄 Updating Service Configuration**
1. **For all regions** → Modify `base/base.yaml`.
2. **For a specific environment** → Update `global/global.yaml`.
3. **For a single region** → Modify `region/values.yaml`.

---

## 📝 Best Practices

### 🔐 **Configuration Management**
✔ Keep base configurations minimal.  
✔ Use global configs for environment-wide settings.  
✔ Limit region-specific overrides to essentials.

### 📛 **Naming Conventions**
✔ Maintain consistent service names.  
✔ Follow a standardized region naming scheme.  
✔ Ensure clear labeling of environments.

### 📜 **Version Control**
✔ Document major changes in a changelog.  
✔ Use meaningful commit messages.  
✔ Review configuration updates before merging.

### 🔒 **Security Best Practices**
✔ Store secrets separately from configurations.  
✔ Apply proper RBAC policies.  
✔ Maintain strict security contexts for workloads.

---

🎯 **This structured approach simplifies multi-region workload management, ensures scalability, and maintains best practices across services.** 🚀
