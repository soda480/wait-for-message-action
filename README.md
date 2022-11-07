# wait-for-message-action

A GitHub Action that runs the [wait-for-message](https://pypi.org/project/wait-for-message/) Python utility. A simple client server utility that blocks until a message is sent/received on a TCP/IP socket connection; useful for synchronizing interdependent networked jobs.

## Send

```bash
jobs:
  send:
    runs-on: self-hosted
    steps:
    - name: "Send Message and Acknowledge"
      uses: soda480/wait-for-message-action@main
      with:
        command: "send"
        ip: 195.164.1.123
        port: 8080
        message: "ready to proceed"
        delay: 30
        attempts: 4
```

## Wait

```bash
jobs:
  wait:
    runs-on: self-hosted
    steps:
    - name: "Wait for a Message"
      uses: soda480/wait-for-message-action@main
      with:
        command: "wait"
        port: 8080
        message: "ready to proceed"
        timeout: 120
```
