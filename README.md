# secretctl
A CLI to make secret handling easier



## Providers
- [x] GCP - `Google Cloud Secret Manager`
- [ ] AWS - `AWS Secrets Manager`



## Secret Data Types
- [x] dotenv
- [ ] json
- [ ] yaml



## Features
- [x] list
- [x] search
- [x] create
- [x] get
- [x] update
- [x] patch
- [x] disable
- [x] enable
- [x] delete
- [x] diff
- [x] find
- [x] compare
- [x] delete-fields



## How to install
- [shell](docs/shell/HOW_TO_INSTALL.md)



## secretctl in action
``` shell
### create
aleroxac@home ~ $ secretctl create app-dev <(echo "FOO=bar")
2024/10/07 12:11:03 [INFO] [create_secret] - Creating secret: app-dev
2024/10/07 12:11:10 [INFO] [create_secret] - Secret created

### search
aleroxac@home ~ $ secretctl search dev
app-dev

### list
aleroxac@home ~ $ secretctl list
NAME     CREATED              REPLICATION_POLICY  LOCATIONS
app-dev  2024-10-07T15:11:06  automatic           -

### update
aleroxac@home ~ $ secretctl update app-dev <(echo "FOO=123")
2024/10/07 12:11:52 [INFO] [update_secret] - Updating the secret: app-dev
2024/10/07 12:11:56 [INFO] [update_secret] - Secret updated

## get
aleroxac@home ~ $ secretctl get app-dev
FOO=123

### delete
aleroxac@home ~ $ secretctl delete app-dev
2024/10/07 12:12:16 [INFO] [delete_secret] - Deleting secret: app-dev
2024/10/07 12:12:19 [INFO] [delete_secret] - Secret deleted
```
