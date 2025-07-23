### My Website

Welcome to the repository for my (Noah Lewis) website!

# Website Deployment Scripts

This directory contains a set of helper scripts and configuration files for managing and deploying a static website using `git` and `Apache`. The scripts are intended for use on a systemd-based Linux system.

---

1. **Verify Directory Structure:**

## 📁 Directory Structure

```text
scripts/
├── deploy.service       # systemd service unit for deployment
├── deploy.timer         # systemd timer unit (runs deploy.service hourly)
├── deploy.sh            # pulls the latest git code and runs update_html.sh
├── update_html.sh       # copies files from ../src to /var/www/html
├── install.sh           # installs Apache and Git
├── enable_boot.sh       # enables Apache to start on boot
├── start.sh             # starts Apache
├── stop.sh              # stops Apache
├── restart.sh           # restarts Apache
├── reload.sh            # reloads Apache
├── status.sh            # shows Apache status
```

2. **Verify and update paths in scripts if needed:**

- In `deploy.service`:

```ini
ExecStart=<repo>/scripts/deploy.sh
```

3. **Make all `.sh` executable:** 

```bash
cd <repo>/scripts
chmod +x *.sh
```

4. **Install Apache and Git**

```bash
cd <repo>/scripts
./install.sh
```

5. **Enable Apache to start on boot:**

```bash
cd <repo>/scripts
./enable_boot.sh
```

6. **Test manual deploy:**

```bash
cd <repo>/scripts
./deploy.sh
```

7. **Copy systemd units and start timer:**

```bash
sudo cp deploy.service /etc/systemd/system/
sudo cp deploy.timer /etc/systemd/system/

sudo systemctl daemon-reload
sudo systemctl enable --now deploy.timer
```

8. **Verify timer is running:**

```bash
systemctl list-timers --all | grep deploy
```

9. **Manually run deployment:**

```bash
sudo systemctl start deploy.service
```
