# Read parameters
param(
    [Parameter(Mandatory=$true)]
    [string]$ServiceName,

    [Parameter(Mandatory=$true)]
    [string]$Operation = 'status'
)

# Trim leading spaces 
$ServiceName = $ServiceName.Trim()
$Operation = $Operation.Trim()

$exit_code = 0

# Validate the service specified
try {
    $service = Get-Service -Name $ServiceName -ErrorAction Stop
} catch {
    Write-Host "Service '$ServiceName' not found. Please check the service name and try again."
    $exit_code = 1
}

if ($exit_code -le 0) {
    switch ($Operation) {
        'start' {
            if ($service.Status -eq 'Running') {
                Write-Host "Service '$ServiceName' is already running."
            } else {
                Start-Service -Name $ServiceName
                Write-Host "Service '$ServiceName' started successfully."
            }
        }
        'stop' {
            if ($service.Status -eq 'Stopped') {
                Write-Host "Service '$ServiceName' is already stopped."
            } else {
                Stop-Service -Name $ServiceName
                Write-Host "Service '$ServiceName' stopped successfully."
            }
        }
        'restart' {
            Restart-Service -Name $ServiceName
            Write-Host "Service '$ServiceName' restarted successfully."
        }
        'status' {
            Write-Host "The status of service '$ServiceName' is $($service.Status)."
            Write-Host "RUNDECK:DATA:SERVICE_STATUS=$($service.Status)"
        }
        default {
            Write-Host "Invalid operation '$Operation'. Should be one of: Status/Start/Stop/Restart"
            $exit_code = 2
        }
    }
}

Write-Host "RUNDECK:DATA:EXIT_CODE=$exit_code"
exit $exit_code