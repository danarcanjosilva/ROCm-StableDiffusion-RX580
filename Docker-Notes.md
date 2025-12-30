[0;1;32m●[0m docker.service - Docker Application Container Engine
     Loaded: loaded (/lib/systemd/system/docker.service; enabled; vendor preset: enabled)
     Active: [0;1;32mactive (running)[0m since Mon 2025-12-29 05:28:25 -03; 5h 20min ago
TriggeredBy: [0;1;32m●[0m docker.socket
       Docs: https://docs.docker.com
   Main PID: 1579 (dockerd)
      Tasks: 26
     Memory: 204.2M
     CGroup: /system.slice/docker.service
             └─1579 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock

dez 29 05:28:25 ARCSILVA11 dockerd[1579]: time="2025-12-29T05:28:25.325820669-03:00" level=info msg="API listen on /run/docker.sock"
dez 29 05:28:25 ARCSILVA11 systemd[1]: Started Docker Application Container Engine.
dez 29 09:59:39 ARCSILVA11 dockerd[1579]: time="2025-12-29T09:59:39.627886579-03:00" level=warning msg="path in container /dev/kfd already exists in privileged mode" container=0c59a59781aa79ad68ca656d8215deb4a567e4d3431d268c7ec5baf5a7181acb spanID=6dcc7064bc0eb552 traceID=3361c77dc36ed5212c88641eb46d7d09
dez 29 09:59:39 ARCSILVA11 dockerd[1579]: time="2025-12-29T09:59:39.627934631-03:00" level=warning msg="path in container /dev/dri already exists in privileged mode" container=0c59a59781aa79ad68ca656d8215deb4a567e4d3431d268c7ec5baf5a7181acb spanID=6dcc7064bc0eb552 traceID=3361c77dc36ed5212c88641eb46d7d09
dez 29 10:22:31 ARCSILVA11 dockerd[1579]: time="2025-12-29T10:22:31.818165581-03:00" level=info msg="Container failed to exit within 10s of signal 15 - using the force" container=0c59a59781aa79ad68ca656d8215deb4a567e4d3431d268c7ec5baf5a7181acb spanID=e31326abb2156271 traceID=91b7ec4d092bafb984462df200d2883b
dez 29 10:22:32 ARCSILVA11 dockerd[1579]: time="2025-12-29T10:22:32.239434089-03:00" level=info msg="ignoring event" container=0c59a59781aa79ad68ca656d8215deb4a567e4d3431d268c7ec5baf5a7181acb module=libcontainerd namespace=moby topic=/tasks/delete type="*events.TaskDelete"
dez 29 10:27:08 ARCSILVA11 dockerd[1579]: time="2025-12-29T10:27:08.428458516-03:00" level=warning msg="path in container /dev/kfd already exists in privileged mode" container=117c32f5956c8c21efa5e666fac75166bbb0ae36bb2ce42604f9d9cb84c2e2f9 spanID=e00bac796d4c4fab traceID=3314839681d0c4fff101bbf5addc35cd
dez 29 10:27:08 ARCSILVA11 dockerd[1579]: time="2025-12-29T10:27:08.428497628-03:00" level=warning msg="path in container /dev/dri already exists in privileged mode" container=117c32f5956c8c21efa5e666fac75166bbb0ae36bb2ce42604f9d9cb84c2e2f9 spanID=e00bac796d4c4fab traceID=3314839681d0c4fff101bbf5addc35cd
dez 29 10:45:50 ARCSILVA11 dockerd[1579]: time="2025-12-29T10:45:50.231601018-03:00" level=info msg="Container failed to exit within 10s of signal 15 - using the force" container=117c32f5956c8c21efa5e666fac75166bbb0ae36bb2ce42604f9d9cb84c2e2f9 spanID=375280a11332992c traceID=e07c8815764dfc5af824e8cf633a226a
dez 29 10:45:50 ARCSILVA11 dockerd[1579]: time="2025-12-29T10:45:50.521446351-03:00" level=info msg="ignoring event" container=117c32f5956c8c21efa5e666fac75166bbb0ae36bb2ce42604f9d9cb84c2e2f9 module=libcontainerd namespace=moby topic=/tasks/delete type="*events.TaskDelete"
