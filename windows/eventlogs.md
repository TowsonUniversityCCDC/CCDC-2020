# Event logs

* TODO: powershell 1-liners to search event logs

## Relevant event ids to look for

| Event ID (2000/XP/2003) | Event ID (Vista/7/8/2008/2012) | Log Name | Description |
| ----------------------- | ------------------------------ | -------- | ----------- |
| 517                     | 1102                           | Security | Audit log was cleared |
| N/A                     | 104                            | System   | Event log was cleared |
| 528                     | 4624                           | Security | Successful Logon |
| 529                     | 4625                           | Security | Failed Login |
| 530                     | 4625                           | Security | Logon failure for a logon attempt to log on outside of the allowed time |
| 531	                    | 4625                           | Security | Logon failure for a logon attempt using a disabled account |
| 532                     | 4625                           | Security | Logon failure for a logon attempt using an expired account |
| 552                     | 4648                           | Security | User successfully logged onto a computer using explicit credentials while already logged on as a different user |
| N/A                     | 4688                           | ??       | A new process has been created |
| 680	                    | 4776                           | Security | Successful /Failed Account Authentication |
| 682                     | 4778                           | Security | User has reconnected to a disconnected terminal session |
| N/A                     | 4719                           | System   | System audit policy was changed |
| 624	                    | 4720                           | Security | A user account was created |
| 636	                    | 4732                           | Security | A member was added to a security-enabled local group |
| 632	                    | 4728                           | Security | A member was added to a security-enabled global group |
| N/A                     | 7697                           | Security | A service was installed in the system |
| 2934                    | 7030                           | System   | Service Creation Errors |
| N/A                     | 7034                           | Security | A service was terminated unexpectedly |
| 2944                    | 7040                           | System   | The start type of the IPSEC Services service was changed from disabled to auto start. |
| 2949                    | 7045                           | System   | Service Creation |

## Logon types

| Logon type | Logon title | Description |
| ---------- | ----------- | ----------- |
| 2 |	Interactive	| A user logged on from console to this computer. |
| 3	| Network |	A user or computer logged on to this computer from the network. |
| 4	| Batch | Batch logon type is used by batch servers, where processes may be executing on behalf of a user without their direct intervention. |
| 5	| Service | A service was started by the Service Control Manager. |
| 7	| Unlock | This workstation was unlocked. |
| 8	| NetworkCleartext | A user logged on to this computer from the network. The user’s password was passed to the authentication package in its unhashed form. The built-in authentication packages all hash credentials before sending them across the network. The credentials do not traverse the network in plaintext (also called cleartext). |
| 9	| NewCredentials | A called cloned its current token and specified new credentials for outbound connections. The new logon session has the same local identity, but uses different credentials for other network connections. |
| 10 | RemoteInteractive | A user logged onto this computer remotely using Terminal Services or Remote Desktop. |
| 11 | CachedInteractive | A user logged on to this computer with network credentials that were stored locally on the computer. The domain controller was not contacted to verify the credentials. |
| 12 | ? | Cached remote interactive |
| 13 | ? | Cached unlock (similar to logon type 7) |

## Location
C:\windows\system32\winevt\logs\*evtx

## Event log explorer
https://www.eventlogxp.com is slightly better than the built in windows log viewer (imo). They offer free licenses for personal use.
