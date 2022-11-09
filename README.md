# GitHub Action: wait-for-message

A GitHub Action that runs the [wait-for-message](https://pypi.org/project/wait-for-message/) Python utility. A simple client server utility that blocks until a message is sent/received on a TCP/IP socket connection. This action is useful for synchronizing interdependent networked jobs.

### **`wait`**

Bind the local ip address on a port and wait (i.e. block) for a message to be received, if no message is received within the designated timeout an error is raised.

### **`send`**

Send a message to the ip address and port via a tcp socket connection, if no acknowledgement is received due to a socket error the message will be resent until maximum attempts waiting delay seconds between each attempt, if max attempts exceeded an error is raised.

## Runs On

> **Note**: This action is only meant to be run on self-hosted GitHub Action runners.

|     Capability | Compatible | Note                |
| -------------: | :--------: | --------------------- |
|   Docker Linux |     ✅     | Requires Docker       |
|   Native Linux |     ✅     | Requires Python > 3.7 |
| Docker Windows |     ❌     | Non Supported         |
| Native Windows |     ✅     | Requires Python > 3.7 |

## Inputs

<!-- start inputs -->

| **Input**                      | **Description**                                                                          | **Default** | **Required** |
| ------------------------------ | ---------------------------------------------------------------------------------------- | ----------- | ------------ |
| **<code>command</code>**       | The command to execute; `wait` or `send`                                                 |             | **true**     |
| **<code>ip</code>**            | For `send`; the IP address of the server. For `wait` the IP address that will be binded is 0.0.0.0                                          |             | **true**     |
| **<code>port</code>**          | For `send`; the TCP port number of the server. For `wait`; the TCP port number to listen on |             | **true**     |
| **<code>message</code>**       | For `send`; the message to send. For `wait`; the message to wait for                     |             | **true**     |
| **<code>delay</code>**         | For `send`; the number of seconds to delay between retries                               | 10          | **false**    |
| **<code>attempts</code>**      | For `send`; the maximum retry attempts                                                   | 60          | **false**    |
| **<code>timeout</code>**       | For `wait`; the number of seconds to wait for message                                    | 900         | **false**    |
| **<code>use_container</code>** | Use Docker container for execution                                                       | false       | **false**    |
| **<code>shell</code>**         | The shell to use                                                                         | bash        | **false**    |

<!-- end inputs -->

## Usage

### Send

<details><summary>Send - Native Linux</summary>

```bash
name: Test Native Send
on: workflow_dispatch
jobs:
  test:
    runs-on: self-hosted-linux
    steps:
    - name: Send for a Message
      uses: soda480/wait-for-message-action
      with:
        command: "send"
        ip: "192.168.1.184"
        port: 8080
        message: "ready to proceed"
        timeout: 60
```

</details>

<details><summary>Send - Docker Linux</summary>

```bash
name: Test Container Send
on: workflow_dispatch
jobs:
  test:
    runs-on: self-hosted-linux
    steps:
    - name: Send for a Message
      uses: soda480/wait-for-message-action
      with:
        command: "send"
        ip: "192.168.1.184"
        port: 8080
        message: "ready to proceed"
        timeout: 60
        use_container: true
```

</details>

<details><summary>Send - Native Windows</summary>

```bash
name: Test Windows Send
on: workflow_dispatch
jobs:
  test:
    runs-on: self-hosted-windows
    steps:
    - name: Send for a Message
      uses: soda480/wait-for-message-action
      with:
        command: "send"
        ip: "192.168.1.199"
        port: 8080
        message: "ready to proceed"
        timeout: 60
        shell: cmd
```

</details>

### Wait

<details><summary>Wait - Native Linux</summary>

```bash
name: Test Native Wait
on: workflow_dispatch
jobs:
  test:
    runs-on: self-hosted-linux
    steps:
    - name: Wait for a Message
      uses: soda480/wait-for-message-action
      with:
        command: "wait"
        port: 8080
        message: "ready to proceed"
        timeout: 60
```

</details>

<details><summary>Wait - Docker Linux</summary>

```bash
name: Test Container Wait
on: workflow_dispatch
jobs:
  test:
    runs-on: self-hosted-linux
    steps:
    - name: Wait for a Message
      uses: soda480/wait-for-message-action
      with:
        command: "wait"
        port: 8080
        message: "ready to proceed"
        timeout: 60
        use_container: true
```

</details>

<details><summary>Wait - Native Windows</summary>

```bash
name: Test Windows Wait
on: workflow_dispatch
jobs:
  test:
    runs-on: self-hosted-windows
    steps:
    - name: Wait for a Message
      uses: soda480/wait-for-message-action
      with:
        command: "wait"
        port: 8080
        message: "ready to proceed"
        timeout: 60
        shell: cmd
```

</details>

## Examples

### Synchronize Jobs

A Job depends on another Job.

![Example](./docs/images/JobSync.png?raw=true)

Two self-hosted runners A and B.

Task-B1 depends on Task-A1 completing, thus add a **Wait** Job before Task-B1 that will wait/listen for a "Ready to Proceed" message, also add a **Send** Job after Task-A1 that will send the "Ready to Proceed" message to B. 

Likewise, Task-A2 depends on Task-B1 completing, thus add a **Wait** Job before Task-A2 that will wait/listen for a "Ready to Proceed" message, also add a **Send** Job after Task-B1 that will send the "Ready to Proceed" message to A.

The **Send** Jobs require the IP address of the runner that the message will be sent to, thus the first Jobs are to acquire the IP addresses of the respective self-hosted runners.

[Example Code](./.github/workflows/test-job-sync.yml?raw=true)

### Synchronize steps within Jobs

A step within one Job depends on a step within another Job.

This example is essentially the same as above, except dependencies are between steps within Jobs. The same logic applies, the wait and send tasks are defined within the steps of the Jobs.

[Example Code](./.github/workflows/test-job-sync-steps.yml?raw=true)