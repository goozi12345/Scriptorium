# Scriptorium
My private script stash


# Bashwatch 🐚🔧

**Bashwatch** is a lightweight Bash script designed to **automatically manage file and folder permissions** and **ownership** on your Linux system. Perfect for servers, shared drives, or any environment where you want consistent file access rules without manual intervention.

---

## Features

* ✅ Automatically sets permissions for new files and folders recursively
* ✅ Ensures correct ownership for specified users and groups
* ✅ Monitors directories in real-time using `inotify-tools`
* ✅ Fully configurable through a secure `.env` file

---

## Installation

1. Clone or download the repository:

```bash
git clone https://github.com/goozi12345/Scriptorium.git
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
DEFAULT_USER=username
DEFAULT_GROUP=groupname
```

* `WATCH_DIR` → directory to monitor
* `DEFAULT_USER` / `DEFAULT_GROUP` → ownership settings


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
