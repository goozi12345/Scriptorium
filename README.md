# Scriptorium
My private script stash


# Bashwatch 🐚🔧

**Bashwatch** is a lightweight Bash script designed to **automatically manage file and folder permissions** and **ownership** on your Linux system. Perfect for servers, shared drives, or any environment where you want consistent file access rules without manual intervention.

---

## Features

* ✅ Automatically sets permissions for new files and folders
* ✅ Ensures correct ownership for specified users and groups
* ✅ Monitors directories in real-time using `inotify-tools`
* ✅ Logs all changes for easy tracking and debugging
* ✅ Fully configurable through a secure `.env` file

---

## Installation

1. Clone or download the repository:

```bash
git clone <your-repo-url>
cd bashwatch
```

2. Make the script executable:

```bash
chmod +x bashwatch.sh
```

3. Install dependencies:

```bash
sudo apt update
sudo apt install inotify-tools
```

4. Create your environment file:

```bash
cp bashwatch.env.example bashwatch.env
nano bashwatch.env
```

Configure your desired user, group, and default permissions.

---

## Usage

Run the script manually:

```bash
./bashwatch.sh
```

Or set it up with **cron** to run at startup for continuous monitoring:

```cron
@reboot /path/to/bashwatch.sh >> /var/log/bashwatch.log 2>&1
```

---

## Configuration

All configurable options are stored in the `.env` file:

```env
WATCH_DIR=/path/to/watch
DEFAULT_PERMISSIONS=750
DEFAULT_USER=username
DEFAULT_GROUP=groupname
LOG_FILE=/var/log/bashwatch.log
```

* `WATCH_DIR` → directory to monitor
* `DEFAULT_PERMISSIONS` → default chmod for new files/folders
* `DEFAULT_USER` / `DEFAULT_GROUP` → ownership settings
* `LOG_FILE` → path for logging all changes

---

## Logging

Bashwatch logs all operations, including:

* Permissions changes
* Ownership updates
* Errors or skipped files

Check the log file to verify the script is working:

```bash
tail -f /var/log/bashwatch.log
```

---

## Troubleshooting

* **"chmod: invalid mode"** → Ensure `DEFAULT_PERMISSIONS` is set correctly in `.env`
* **"chown: operation not permitted"** → Run the script as a user with proper privileges (or via `sudo`)
* **Drive not detected** → Make sure the path exists and the drive is mounted

---

## Contributing

Contributions are welcome! Feel free to:

* Report bugs 🐞
* Suggest new features 💡
* Improve documentation ✍️

---

## License

This project is licensed under the **MIT License**.
Feel free to use, modify, and share!

---

Made with ❤️ for **automatic, stress-free file management**.
