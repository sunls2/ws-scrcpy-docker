# ws-scrcpy-docker

[ws-scrcpy](https://github.com/NetrisTV/ws-scrcpy) 项目的 docker 镜像

- 分层打包优化镜像大小 (~420MB)
- 使用 GitHub Actions 自动打包 amd64, arm64 平台镜像
- 每月1号自动更新镜像，保持上游最新代码

## 使用（docker compose）

```yaml
# docker-compose.yaml
services:
  ws-scrcpy:
    container_name: ws-scrcpy
    image: sunls2/ws-scrcpy:latest
    logging:
      options:
        max-size: 1m
    network_mode: host
    restart: unless-stopped
```

```shell
docker compose up -d
```

浏览器打开`127.0.0.1:8000`查看结果
