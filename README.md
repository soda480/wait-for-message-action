# wait-for-message-action

A GitHub Action that runs the [wait-for-message](https://pypi.org/project/wait-for-message/) Python utility. A simple client server utility that blocks until a message is sent/received on a TCP/IP socket connection. This action is useful for synchronizing interdependent networked jobs.

## Runs On

> **Note**: This action is only meant to be run on self-hosted GitHub Action runners.

|     Capability | Compatible | Reason                |
| -------------: | :--------: | --------------------- |
|   Docker Linux |     yes    | Requires Docker       |
|   Native Linux |     yes    | Requires Python > 3.7 |
| Docker Windows |     no     | Non Supported         |
| Native Windows |     yes    | Requires Python > 3.7 |

## Inputs

<!-- start inputs -->

| **Input**                      | **Description**                                                                          | **Default** | **Required** |
| ------------------------------ | ---------------------------------------------------------------------------------------- | ----------- | ------------ |
| **<code>command</code>**       | The command to execute; `wait` or `send`                                                 |             | **true**     |
| **<code>ip</code>**            | For `send`; the IP address of the server                                                 |             | **true**     |
| **<code>port</code>**          | For `send`; the TCP port number the server. For `wait`; the TCP port number to listen on |             | **true**     |
| **<code>message</code>**       | For `send`; the message to send. For `wait`; the message to wait for                     |             | **true**     |
| **<code>delay</code>**         | For `send`; the number of seconds to delay between retries                               | 10          | **false**    |
| **<code>attempts</code>**      | For `send`; the maximum retry attempts                                                   | 60          | **false**    |
| **<code>timeout</code>**       | For `wait`; the number of seconds to wait for message                                    | 900         | **false**    |
| **<code>use_container</code>** | Use Docker container for execution                                                       | false       | **false**    |
| **<code>shell</code>**         | The shell to use                                                                         | bash        | **false**    |

<!-- end inputs -->

## Usage

### Send

On a linux runner, send message to the ip address and port via a tcp socket connection. The action will retry maximum attempts waiting delay between each attempt until the message is acknowledged, fail after max attempts.

```bash
jobs:
  send:
    runs-on: self-hosted-linux
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

### Wait

On a windows runner, bind to the local ip address on the designated port and wait for the designated message, fail if the message is not received in the designated timeout.

```bash
jobs:
  wait:
    runs-on: self-hosted-windows
    steps:
    - name: "Wait for a Message"
      uses: soda480/wait-for-message-action@main
      with:
        command: "wait"
        port: 8080
        message: "ready to proceed"
        timeout: 120
        shell: "cmd"
```
