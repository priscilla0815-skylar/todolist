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
