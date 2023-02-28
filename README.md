
# HelloID-Task-SA-Target-ActiveDirectory-AccountUpdateManager

## Prerequisites

- [ ] The HelloID SA on-premises agent installed

- [ ] The ActiveDirectory module is installed on the server where the HelloID SA on-premises agent is running.

## Description

This code snippet executes the following tasks:

1. Define a hash table `$formObject`. The keys of the hash table represent the properties of the `Set-ADUser` cmdlet, while the values represent the values entered in the form.

> To view an example of the form output, please refer to the JSON code pasted below.

```json
{
    "UserPrincipalName": "",
    "ManagerUserPrincipalName": ""
}
```

> :exclamation: It is important to note that the names of your form fields might differ. Ensure that the `$formObject` hashtable is appropriately adjusted to match your form fields.

2. Imports the ActiveDirectory module.

3. Retrieve the user account object using the `Get-ADUser` cmdlet.

4. Retrieve the manager account object using the `Get-ADUser` cmdlet.

5. Update the manager using the `$user` object retrieved from step 3 and the `$manager` object from step 4
