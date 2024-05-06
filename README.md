<div align=center style="text-align: center;">
<h1>SPT-Aki - Dockerized</h1>
<h2>Quickly set up your personal Escape from Tarkov server in just 5 minutes..</h2>
<h2>The Linux Container, that builds the server too</h2>
<h4>Why? Because everyone should be able to build, and not rely on unknown builds from unknown sources.</h3>

Platform independent.

This fork simply removes the SIT(stayintarkov) requirements to make a generic SPT-Aki server. Huge thanks to devbence/bullet for the original project.
</div>

---

## How to use this Repo?

1. Install [DOCKER](https://docs.docker.com/engine/install/)
2. `git clone https://github.com/umbraprior/SPT.Docker`
3. `cd SPT.Docker`
4. Build the server for your requested version, (you can change the `--build-arg` to the full commit hash from the Aki server Gitea page)

   Equivalent to release SPT-Aki-3.8.1-e8e317 (0.14.1.2.29197):
   ```bash
   docker build \
      --no-cache \
      --build-arg SPT=79a5d32cb276e18a5b4405e1f7823cda4fe8e317 \
      --label SPTAki \
      -t sptaki .
   ```
   Same, but in one line:
   ```bash
   docker build --no-cache --build-arg SPT=79a5d32cb276e18a5b4405e1f7823cda4fe8e317 --label SPTAki -t sptaki .
   ```

 
   Equivalent to release SPT-Aki-3.8.0-3951e2 (0.14.1.2.29197):
   ```bash
   docker build \
      --no-cache \
      --build-arg SPT=3951e29a340e917d158ec061ee671c4ae0f9c8ec \
      --label SPTAki \
      -t sptaki .
   ```
   Same, but in one line:
   ```bash
   docker build --no-cache --build-arg SPT=3951e29a340e917d158ec061ee671c4ae0f9c8ec --label SPTAki -t sptaki .
   ```
   
   > Windows dont handle the \\, use the oneliner!


7. Run the image once:
   ```bash
   docker run --pull=never -v $PWD/server:/opt/server -p 6969:6969 -p 6970:6970 -p 6971:6971 -p 6972:6972 -it --name sptaki sptaki
   ```
   - ⚠️ If you don't set the -v (volume), you won't be able to do a required step!

   - On **Linux** you can include `--user $(id -u):$(id -g)`, this way, file ownership will be set to the user who started the container.
   ```bash
   docker run --pull=never --user $(id -u):$(id -g) -v $PWD/server:/opt/server -p 6969:6969 -p 6970:6970 -it --name sptaki sptaki
   ```

8. Go to your `./server` directory, delete `delete_me`, and optionally install additional mods, make config changes, etc.
    > Using `-p6969:6969`, you expose the port to `0.0.0.0` (meaning: open for LAN, localhost, VPN address, etc).
    > 
    > You can specify `-p 192.168.12.34:6969:6969` for each port if you don't want the ports to listen on all interfaces. 
   
9. Start your server (and enable auto restart):
 ```bash
docker start sptaki
docker update --restart unless-stopped sptaki
```
8. ... wait a few seconds, then you can connect to `http://YOUR_IP:6969`

## Bugs and Issues
Let me know if there are any. Feel free to submit a PR.
