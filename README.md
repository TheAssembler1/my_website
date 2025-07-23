### My Website

Welcome to the repository for my (Noah Lewis) website!

# Managing EC2 Deployment

The `.pem` file to connect using ssh is located in 
my OSU onedrive under the folder `pem` with the 
name `login_ssh.pem`.

To connect using the following commands:

```bash
chmod 400 "login_ssh.pem"
ssh -i "login_ssh.pem" ubuntu@ec2-18-217-11-27.us-east-2.compute.amazonaws.com
```

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

- In `deploy.sh`:

```ini
SCRIPTS_DIR=<repo>/scripts
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
sudo chown -R root:root /home/ubuntu/src/my_website
sudo git config --system --add safe.directory /home/ubuntu/src/my_website
sudo systemctl daemon-reload
sudo systemctl restart deploy.service
```

10. **Setup tls https:**

```bash
sudo certbot --apache -d theassembler1.com
```

11. **Test Renewal***

```bash
sudo certbot renew --dry-run
```

12. **Open Firewall**

```bash
sudo ufw allow 'Apache Full'
```
