# Todo List

A responsive, dependency-free Todo List web app packaged for direct veFaaS deployment.

## Features

- Add, edit, complete, and delete tasks
- Filter by status or due date
- Search tasks
- Set priority and due dates
- Track completion progress
- Persist data in `localStorage`

## Project files

- `index.html`: complete frontend application
- `server.py`: zero-dependency production entry point
- `Dockerfile`: production container image definition
- `vefaas-deploy.example.json`: MCP deployment parameter template

## Run locally

```bash
PORT=3000 python3 server.py
```

Then visit <http://localhost:3000>. The health endpoint is available at
<http://localhost:3000/healthz>.

## Build deployment package

Run from the project directory:

```bash
mkdir -p dist
zip -X -j dist/todolist-deploy.zip index.html server.py README.md
openssl base64 -A \
  -in dist/todolist-deploy.zip \
  -out dist/todolist-deploy.zip.base64.txt
```

Use the Base64 file contents as the MCP deployment tool's `source` value.
The matching deployment settings are:

```text
runtime: native-python3.12/v1
start_command: python3 server.py
port: 3000
output_path: ./
```

## Container image

The GitHub Actions workflow builds and smoke-tests a Linux AMD64 image. It
publishes the image to:

```text
ghcr.io/priscilla0815-skylar/todolist:latest
```

Each successful workflow run also provides a downloadable
`todolist-image-linux-amd64.tar.gz` artifact. Load the archive locally with:

```bash
gzip -dc todolist-image-linux-amd64.tar.gz | docker load
```

For MCP deployment, use:

```text
source_type: image
source: ghcr.io/priscilla0815-skylar/todolist:latest
port: 3000
```
