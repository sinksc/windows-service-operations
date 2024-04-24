# windows-service-operations
Rundeck plugin to perform operations on Windows services, such as start/stop/restart/status check

## Usage

### windows / service / operations

Start, Stop, Restart, or check the Status of a Windows service

### Step inputs

The following fields are specified for this step:

| Input Name | Purpose | Example | Required? |
|:----------:|:-------:|:-------:|:---------:|
| service_name | Name of the Windows service to interact with | _Apache Tomcat 9.0 Tomcat9_, _tomcat9_ | Y |
| operation | The operation to perform against the service. | _status/start/stop/restart_ | Y |

### Usage Tip
To create a single job that will allow you to execute any operation against a service, specified at run-time, create a job with two Options:

- Operation
  - Type: _Text_
  - Default value: _status_
  - Allowed values: _status,start,stop,restart_
  - Restrictions: _Enforced from Allowed Values_
- ServiceName
  - Type: _Text_

Then add a Workflow step of type `windows / service / operations` and specify the following values for the two inputs:
- Service Name: `${option.ServiceName}`
- Operation: `${option.Operation}`

### Exit Codes

This step returns the following exit codes:

| Exit Code |  Reason  |
|:----------:|:-------- |
|      0     | Success. The operation completed. |
|      1     | Fail. The specified service was not found. |
|      2     | Fail. The specified operation is not allowed. |

## Building

1. To build the plugin, simply move up a directory and zip it but, exclude the .git files:

    ```powershell
    zip -r windows-service-operations.zip windows-service-operations -x *.git*
    ```

2. Then copy the zip file to the plugins directory: `$RDECK_BASE/libext`
