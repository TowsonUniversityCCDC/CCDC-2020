Function Set-FilePermissions {
    Param(
    $user,
    $folder
}
$ACL = New-Object System.Security.AccessControl.DirectorySecurity #variable = new object 
$ACL.SetAccessRuleProtection($true,$true) #disables inheritance. true true means off and off
$rule1 = new-object System.Security.AccessControl.FileSystemAccessRule("$env:username", "FullControl", "ContainerInherit, ObjectInherit", "None", "Allow")
 #include current user as having full access as well as the system to have full access
$rule2 = new-object System.Security.AccessControl.FileSystemAccessRule("NT AUTHORITY\SYSTEM", "FullControl", "ContainerInherit, ObjectInherit", "None", "Allow")
$ACL.SetAccessRule($rule1)
$ACL.AddAccessRule($rule2)
$acl

#Run this command not in ISE. This command sets permissions for specific rules using our script
$ACL | Set-Acl -Path C:\Users\Administrator\Desktop\cat.txt
