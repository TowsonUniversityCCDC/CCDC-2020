# CyLR run steps 
### 1. Determine if x64 or x32 
- Run command "wmic os get osarchitecture" *(Vista and above)*
- Open the Start menu > All Programs. Open the Accessories folder, then the System Tools folder. In the System Tools folder, select the System Information option. *(Earlier Win Versions)*

### 2 Make Folder to store data
- On root of C drive or something

### 3. Download CyLR.exe
- http://badoperation.net/x/windows/cylr/
- Place it in Folder in location that is decided upon

### 3. Extract the exe from the zip file

### 4. Run CyLR
- cylr.exe -o "[File Location]
- -o flag designates where to save the image

### 5. Download serve.exe
- http://badoperation.net/x/windows/
- Save in predetermined file location for access

### 6. Determine what your ip address is
- open command and type "ipconfig"

### 7. Run Serve.exe
- Navigate to the file location in command prompt and run by using "Serve.exe"

### 8. Download the Image
- Navigate to browser and type in [ip_address]:8080
- Click to download to your local machine

### 9. Upload it to BadOperation Server
- User SFTP to get it to server so that it made be accessible to all
