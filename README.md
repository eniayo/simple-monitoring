### Netdata Monitoring Dashboard Project

#### Project Overview
This project focuses on setting up a basic monitoring dashboard using **Netdata**, a real-time performance and health monitoring tool for systems and applications. By the end of this project, you will have a functional Netdata dashboard to monitor system metrics such as CPU usage, memory consumption, and disk I/O.

---

### Prerequisites
1. **Docker** installed on your macOS system (since macOS 12 is not compatible with native Netdata installation).
2. Basic knowledge of **shell scripting** and **Docker**.

---

### Setup Steps

#### 1. Install Docker (if not already installed)
Ensure Docker is installed on your system. You can download it from Docker's official website or use Homebrew to install it.

```bash
brew install --cask docker
```
After installation, open Docker and ensure it's running before proceeding.

---

#### 2. Pull Netdata Docker Image
Use Docker to pull the official Netdata image.

```bash
docker pull netdata/netdata
```

---

#### 3. Run Netdata in Docker Container
Start Netdata in a Docker container with the necessary configurations. This command runs Netdata in the background:

```bash
docker run -d --name=netdata \
  -p 19999:19999 \
  --cap-add SYS_PTRACE \
  -v /proc:/host/proc:ro \
  -v /sys:/host/sys:ro \
  netdata/netdata
```

---

#### 4. Access the Netdata Dashboard
Once the container is running, open your browser and visit:

```
http://localhost:19999
```
You should now see the Netdata dashboard displaying various system metrics.

---

#### 5. Retrieve Session ID (if required)
In some cases, Netdata might require a session ID for authentication. To retrieve it, run the following commands:

```bash
docker exec -it netdata bash
cat /var/lib/netdata/netdata_random_session_id
```
Copy the session ID and paste it into the Netdata dashboard to authenticate.

---

#### 6. Customize the Dashboard
Once the dashboard is up and running, you can customize it by:
- Adding custom charts.
- Configuring alerts for metrics like CPU usage.
- Setting up data retention policies.

---

#### 7. Automate the Setup (Optional)
You can create shell scripts to automate the setup, testing, and cleanup process.

**`setup.sh`**
```bash
#!/bin/bash
docker pull netdata/netdata
docker run -d --name=netdata \
  -p 19999:19999 \
  --cap-add SYS_PTRACE \
  -v /proc:/host/proc:ro \
  -v /sys:/host/sys:ro \
  netdata/netdata
```

**`test_dashboard.sh`**
```bash
#!/bin/bash
# Simulate load for testing
stress --cpu 4 --timeout 60
```

**`cleanup.sh`**
```bash
#!/bin/bash
docker stop netdata
docker rm netdata
```

---

#### 8. Verify Setup
After running the setup, verify the container status:

```bash
docker ps --filter "name=netdata"
```

---

#### 9. Troubleshooting
If you encounter issues (e.g., unable to access the dashboard), ensure:
- Docker is running.
- The Netdata container is healthy.
- You are using the correct session ID.

Check the logs for more information:

```bash
docker logs netdata
```

---

### Key Commands Executed
Here are the key commands used during this process:

1. **Install Docker**:
   ```bash
   brew install --cask docker
   ```

2. **Pull Netdata Image**:
   ```bash
   docker pull netdata/netdata
   ```

3. **Run Netdata in Docker Container**:
   ```bash
   docker run -d --name=netdata \
     -p 19999:19999 \
     --cap-add SYS_PTRACE \
     -v /proc:/host/proc:ro \
     -v /sys:/host/sys:ro \
     netdata/netdata
   ```

4. **Access Netdata Dashboard**:
   ```
   http://localhost:19999
   ```

5. **Retrieve Session ID**:
   ```bash
   docker exec -it netdata bash
   cat /var/lib/netdata/netdata_random_session_id
   ```

6. **Check Docker Container Status**:
   ```bash
   docker ps --filter "name=netdata"
   ```

7. **Stop and Clean Up Docker Container**:
   ```bash
   docker stop netdata
   docker rm netdata
   ```

---

### Conclusion
Congratulations! You've successfully set up a monitoring dashboard using Netdata. This setup allows you to monitor various system metrics and gain insights into your system's health. You can further explore customization options and integrate this into your DevOps workflows.
