# k8slab-for-a-penny

Terraform project to spin up a low-cost Kubernetes lab on Rackspace using spot instances at just **$0.001/hour** or **~$0.72/month** per node.

## ⚠️ Cost Warnings: Load Balancer and PV Charges ⚠️

Rackspace charges **up to $10/month per LoadBalancer service** — the cost is **proportional to usage time**, up to $10/month limit per LoadBalancer.

- **LoadBalancer Services**:  
  Charged **proportionally**, up to **$10/month limit per LoadBalancer**.  
➤ 💡 Tip: Use a single LoadBalancer for your **Ingress controller** (e.g., NGINX), and route traffic to your applications using **Kubernetes Ingress resources**.

- **Persistent Volumes (PV)** and **other services**:  
  These have separate pricing based on usage (size, duration, IOPS, etc.).

- **Control Plane**  
  ✅ **You are NOT charged** for the Kubernetes control plane, **unless** you explicitly enable High Availability (HA).  
  ➤ 💡 Tip : With HA disabled (hacontrol_plane = false, default in this project), control plane cost is **zero**.

📌 Always consult the official pricing table before provisioning non-spot resources:  
🔗 [https://spot.rackspace.com/static-files/html/pricing.html](https://spot.rackspace.com/static-files/html/pricing.html)

📊 You can monitor your usage and billing in real time from the [Rackspace Spot dashboard](https://spot.rackspace.com).

## 💡 What is it?

A minimalist infrastructure-as-code setup to provision a Cloud Kubernetes lab environment for:
- Learning DevOps tools and clusters
- Testing configurations and deployments
- Prototyping ideas in a real multi-node environment

All at **ultra-low cost**, leveraging Rackspace spot instance bidding.

## 🧰 Requirements

Before using this project, you’ll need:

- ✅ An active [Rackspace Spot](https://spot.rackspace.com/) account  
- ✅ An API token to authenticate Terraform  
- ✅ (Optional) A Slack webhook URL for notifications

---

## 🔐 1. Create a Rackspace Spot Account

1. Go to [https://spot.rackspace.com](https://spot.rackspace.com)
2. Click **"Sign Up"** in the top-right corner
3. Fill out the registration form
4. Verify your email and activate the account

---

## 🔑 2. Generate an API Token

1. After logging in, go to: **Account Settings → API Tokens**
2. Click **"Generate new token"**
3. Name it (e.g., `terraform-token`) and generate
4. Copy the token and keep it safe  
   *(You'll use it as `RACKSPACE_API_TOKEN` in your Terraform environment)*

## 🚀 Features

- Spin up real K8s nodes for ~$0.72/month per node
- Terraform-driven: reproducible and automated
- Modular, readable codebase
- Uses the lowest spot bid possible: `$0.001/hour`
- Ideal for labs, CI pipelines, and bootstrapping clusters

## 🌍 Available Data Center Locations

When deploying your lab, you can select from the following Rackspace regions:

| Code             | Region       | Location                    |
|------------------|--------------|-----------------------------|
| `us-central-dfw-1` | US Central   | Dallas Fort Worth, TX, USA  |
| `us-east-iad-1`    | US East      | Ashburn, VA, USA            |
| `us-central-ord-1` | US Central   | Chicago, IL, USA            |
| `us-west-sjc-1`    | US West      | San Jose, CA, USA           |
| `hkg-hkg-1`        | Asia         | Hong Kong                   |
| `aus-syd-1`        | Australia    | Sydney, Australia           |
| `uk-lon-1`         | Europe       | London, United Kingdom      |

Use the appropriate region code in your Terraform variables (e.g., `var.region = "us-east-iad-1"`).

## 🧠 Why use this?

Most cloud providers don't let you bid below market prices. This project exploits Rackspace's open spot bidding to build functional K8s labs at a fraction of a cent per hour.

You get:
- Real-world infra for near-zero cost
- Better than minikube/docker-desktop for testing clusters
- Scalable template to expand or fork

## ⚖️ License

MIT — do whatever you want, no warranties.

---
> 💬 Feedback, forks, and contributions are welcome.
---

Made with 💻 + ☁️ by [Luis Bianconi](https://github.com/luisbianconi)  
Pushing cloud labs to the limit — $0.001 at a time.