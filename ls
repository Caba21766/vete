[0;1;32m●[0m gunicorn.service - gunicorn daemon
     Loaded: loaded (]8;;file://ubuntu-s-1vcpu-1gb-35gb-intel-nyc1-01/etc/systemd/system/gunicorn.service/etc/systemd/system/gunicorn.service]8;;; [0;1;32menabled[0m; preset: [0;1;32menabled[0m)
     Active: [0;1;32mactive (running)[0m since Sat 2025-04-12 21:34:54 UTC; 3min 2s ago
   Main PID: 8577 (gunicorn)
      Tasks: 4 (limit: 2318)
     Memory: 94.3M (peak: 94.5M)
        CPU: 1.247s
     CGroup: /system.slice/gunicorn.service
             ├─[0;38;5;245m8577 /root/Vete/env/bin/python3 /root/Vete/env/bin/gunicorn --access-logfile - --workers 3 --bind unix:/root/Vete/gunicorn.sock prueba1.wsgi:application[0m
             ├─[0;38;5;245m8579 /root/Vete/env/bin/python3 /root/Vete/env/bin/gunicorn --access-logfile - --workers 3 --bind unix:/root/Vete/gunicorn.sock prueba1.wsgi:application[0m
             ├─[0;38;5;245m8580 /root/Vete/env/bin/python3 /root/Vete/env/bin/gunicorn --access-logfile - --workers 3 --bind unix:/root/Vete/gunicorn.sock prueba1.wsgi:application[0m
             └─[0;38;5;245m8581 /root/Vete/env/bin/python3 /root/Vete/env/bin/gunicorn --access-logfile - --workers 3 --bind unix:/root/Vete/gunicorn.sock prueba1.wsgi:application[0m

Apr 12 21:34:54 ubuntu-s-1vcpu-1gb-35gb-intel-nyc1-01 systemd[1]: Started gunicorn.service - gunicorn daemon.
Apr 12 21:34:54 ubuntu-s-1vcpu-1gb-35gb-intel-nyc1-01 gunicorn[8577]: [2025-04-12 21:34:54 +0000] [8577] [INFO] Starting gunicorn 23.0.0
Apr 12 21:34:54 ubuntu-s-1vcpu-1gb-35gb-intel-nyc1-01 gunicorn[8577]: [2025-04-12 21:34:54 +0000] [8577] [INFO] Listening at: unix:/root/Vete/gunicorn.sock (8577)
Apr 12 21:34:54 ubuntu-s-1vcpu-1gb-35gb-intel-nyc1-01 gunicorn[8577]: [2025-04-12 21:34:54 +0000] [8577] [INFO] Using worker: sync
Apr 12 21:34:54 ubuntu-s-1vcpu-1gb-35gb-intel-nyc1-01 gunicorn[8579]: [2025-04-12 21:34:54 +0000] [8579] [INFO] Booting worker with pid: 8579
Apr 12 21:34:54 ubuntu-s-1vcpu-1gb-35gb-intel-nyc1-01 gunicorn[8580]: [2025-04-12 21:34:54 +0000] [8580] [INFO] Booting worker with pid: 8580
Apr 12 21:34:54 ubuntu-s-1vcpu-1gb-35gb-intel-nyc1-01 gunicorn[8581]: [2025-04-12 21:34:54 +0000] [8581] [INFO] Booting worker with pid: 8581
