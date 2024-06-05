#NOT SIGNED

# Define the directory to search for .dll files
$directory = "C:\Windows\assembly\NativeImages_v4.0.30319_32"

# Get all .dll files in the specified directory and subdirectories
$dllFiles = Get-ChildItem -Path $directory -Recurse -Filter *.dll

# Initialize an array to store the results
$results = @()

# Loop through each .dll file
foreach ($file in $dllFiles) {
    try {
        # Check if the file is signed
        $signature = Get-AuthenticodeSignature -FilePath $file.FullName

        if ($signature.Status -ne 'Valid') {
            # Create a custom object to store the file details
            $result = [PSCustomObject]@{
                FilePath = $file.FullName
            }

            # Add the result to the results array
            $results += $result
        }
    } catch {
        # Handle any errors that occur during the process
        Write-Error "Error processing file $($file.FullName): $_"
    }
}

# Display the results in a table format
$results | Format-Table -AutoSize

Stop-Process
