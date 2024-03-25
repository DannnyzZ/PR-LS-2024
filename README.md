Get-NetFirewallPortFilter | Where-Object { $_.LocalPort -eq 53 } | Select-Object Name, DisplayName, Protocol, LocalPort, RemotePort, LocalAddress, RemoteAddress, Action, Profile, Enabled | Format-Table -AutoSize

