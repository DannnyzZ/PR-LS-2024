# Set execution policy to RemoteSigned
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine -Force

# Define the JEA session configuration
$jeaConfig = @{
    Name = 'RestrictedPowerShell'
    SchemaVersion = '2.0.0'
    SessionType = 'RestrictedRemoteServer'
    RunAsVirtualAccount = $true
    TranscriptDirectory = 'C:\Transcripts'
    VisibleCmdlets = 'Get-Command'  # Limit to only viewing available cmdlets
    RoleDefinitions = @{
        'Administrators' = @{
            'Options' = 'All'
        }
        'NonAdministrators' = @{
            'RoleCapabilities' = 'RestrictedPowerShell'
        }
    }
}

# Register the JEA session configuration
Register-PSSessionConfiguration @jeaConfig -Force

# Set logging configuration
Set-Logging -Enabled $true -Path "C:\Users\PowerShell_history.log" -Force

# Set remoting configuration
Set-RemotingConfiguration -EnableRemoting $true -Force

# Set script signing configuration
Set-ScriptSigning -Enabled $true -Force

# Set BITSAdmin availability
Set-BitsadminAvailability -Disabled $true -Force

# Define the role capability for non-administrators
$roleCapability = @"
@{
    RoleCapabilities = 'RestrictedPowerShell'
    VisibleCmdlets = @('Get-Command')
}
"@

# Create the role capability file
$roleCapability | Out-File -FilePath "C:\Program Files\WindowsPowerShell\Modules\RestrictedPowerShell.psrc" -Encoding ascii

# Restart the WinRM service to apply changes
Restart-Service WinRM -Force
