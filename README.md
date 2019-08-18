# FTP Minecraft World Backup Docker Image

[![Docker](https://img.shields.io/docker/pulls/bborge/ftp-minecraft-world-backup.svg)](https://hub.docker.com/r/bborge/ftp-minecraft-world-backup/) [![Docker](https://img.shields.io/docker/stars/bborge/ftp-minecraft-world-backup.svg)](https://hub.docker.com/r/bborge/ftp-minecraft-world-backup/) [![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/bborge/ftp-minecraft-world-backup/master/LICENSE) [![GitHub issues](https://img.shields.io/github/issues/bborge/ftp-minecraft-world-backup.svg)](https://github.com/bborge/ftp-minecraft-world-backup/issues)

[Docker image](https://cloud.docker.com/repository/docker/bborge/ftp-minecraft-world-backup) to create a backups of a Java Edition Minecraft world living on an FTP server somewhere.

## Running

```
docker pull bborge/ftp-minecraft-world-backup:latest
docker run \
  -e FTP_HOST=999.9.99.99 \
  -e FTP_USERNAME=MyUser \
  -e FTP_PASSWORD=MYSUPERSECRET! \
  -e WORLD_DIR=WORLD \
  bborge/ftp-minecraft-world-backup:latest
```

## Running using Docker Compose

1.  Create the file `.env`
2.  Stamp out required environment variables in `.env`
3.  Validate docker-compose file with `docker-compose config`.  You should see your environment variables in the output.
4.  run `docker-compose up`

## Environment Variables

### Required
- `FTP_HOST` - FTP host.
- `FTP_USERNAME` - Username for FTP login.
- `FTP_PASSWORD` - Password for FTP login.
- `WORLD_DIR` - Directory where the minecraft world lives.
