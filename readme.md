## Step-by-Step Guide to Set Up a Simple "Hello, World!" in Docker

1. Create a Project Directory

2. Create aa application, e.g. Python Script

3. Create a Dockerfile

```
# Use the official Python image from the Docker Hub
# specifies base image to use for the Docker container. In this case, it is a slim version of Python 3.11.
FROM python:3.11-slim-bullseye

# Set environment variables for language and locale
ENV LANG=zh_CN.UTF-8
ENV LC_CTYPE=zh_CN.UTF-8
ENV LC_ALL=C

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the current directory contents into the container at /usr/src/app
COPY . .

# Run the Python script when the container launches
CMD ["python", "./app.py"]
```

4. Build the Docker Image

```
docker build -t <docker_image_name> .
```

5. Run the Docker Container
```
docker run --rm <docker_image_name>
```

6. Verify the Output

* Let there be a BIST to run basic tests and print `hello`. 


<hr>
## 🔧 Common Categories of Docker Use

```
1. Dev/Test Environments
Purpose: 
- Simplify setup for developers and CI pipelines.
- Standardize development setups across teams.
- Ensures consistency, reduces onboarding time, and minimizes "it works on my machine" issues.

Examples:
- Running a dev version of a Flask/Django app.
- Python, Node.js, or Go development containers with pre-installed tools and dependencies.
- Isolated unit testing or integration test environments.

Features:
- Lightweight containers
- Docker Compose to simulate environments
- Mounting source code as volumes

2. Infrastructural Microservices & Production Deployment
Purpose: 
- Package and deploy services (Application Containers) as containers in production.
- Package and deploy applications as standalone services.
- Containerize services like databases, caches, or message brokers.
- Service Wrappers
- Base Images Repo
- Create custom base images tailored to specific needs.
- Containerize infrastructure management tools.

Examples:
- Backend APIs, databases, frontend apps in a microservices architecture.
- Flask/Django apps, Node.js backends, ML model inference services.
- PostgreSQL, MySQL, Redis, Nginx, RabbitMQ.
- Python with custom dependencies, Ubuntu with internal CA certificates.
- Terraform, Ansible, Helm.

Features:
- Orchestration via Kubernetes or Docker Swarm
- Multi-stage builds
- Health checks and logging
- Simplifies deployment, scaling, and management of applications.
- Facilitates local development, testing, and deployment without installing services directly on the host.
- Promotes reusability and standardization across projects.
- Simplifies infrastructure provisioning and management.

3. Monitoring and Tooling
Purpose: Deploy observability and administrative tools.

Examples: Prometheus, Grafana, Elasticsearch.

Features: Enhances system monitoring, logging, and analysis capabilities.

4. Data Science / ML Workflows
Purpose: Ensure reproducibility and portability of data pipelines.

Examples:
- Jupyter notebooks with specific Python versions
- ML model training environments

Features:
- GPU support (e.g., nvidia/cuda)
- Preinstalled libraries (e.g., TensorFlow, PyTorch)
- Volume mounting for datasets

5. CI/CD Pipelines
Purpose: 
- Run build/test/deploy tasks inside containers.
- Streamline continuous integration and deployment processes.

Examples:
- GitHub Actions runners, GitLab CI jobs using Docker images
- Dockerized build/test runners, linters, deployment scripts.

Features:
- Build tools like Maven, Gradle, or npm in a container
- Stateless, reproducible builds
- Ensures consistency across pipeline stages and environments.

6. System Emulation / Legacy Software
Purpose: Emulate specific OS or architecture environments.

Examples:
- Running old versions of MySQL or Apache
- Cross-compiling apps

Features:
- Custom base images
- Emulators like QEMU inside Docker

7. Utility/Tooling Containers
Purpose: 
- Package command-line tools or small jobs.
- Job/Script Runners to Execute scheduled or one-off tasks.

Examples:
- A container that only runs a script, like your Hello World example
- ETL jobs, data cleanup scripts, cron jobs.

Features:
- Minimal dependencies
- Often used in automation or cron-like systems
- Isolates tasks, ensures reproducibility, and simplifies scheduling.


```

```
docker_basics/
├── dev_envs/               # Developer tools or environments
│   ├── flask_dev/
│   └── python_dev/
│       └── Dockerfile
├── production/             # Services ready for deployment
│   └── web_api/
├── ml_workflows/           # Data science containers
│   └── jupyter_gpu/
├── cicd_jobs/              # Build & test jobs for CI/CD
│   ├── python_builder/
│   └── lint_runner/
│       └── Dockerfile
├── tools/                  # Utility scripts in containers
│   └── hello_world/
:
├── base_images/
│   └── python-ta-lib/
│       └── Dockerfile
├── apps/
│   ├── flask_hello/
│   │   ├── app.py
│   │   └── Dockerfile
│   └── react_ui/
│       └── Dockerfile
:
├── examples/
│   └── hello_world/
│       ├── app.py
│       └── Dockerfile
├── infra_tools/
│   └── terraform/
:
└── legacy/                 # Legacy systems and emulators
    └── centos6_mysql/

```

``` Have a readme.md for all Dockerfile
## Purpose
CI job for Python builds

## Base Image
python:3.11-slim

## Usage
docker run --rm python_builder
```
