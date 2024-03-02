# PR-LS-2024

Add agent:
Invoke-WebRequest -Uri https://packages.wazuh.com/4.x/windows/wazuh-agent-4.7.2-1.msi -OutFile ${env.tmp}\wazuh-agent; msiexec.exe /i ${env.tmp}\wazuh-agent /q WAZUH_MANAGER='10.0.2.15' WAZUH_AGENT_GROUP='default' WAZUH_AGENT_NAME='Windows_E_10_TEST' WAZUH_REGISTRATION_SERVER='10.0.2.15' 
