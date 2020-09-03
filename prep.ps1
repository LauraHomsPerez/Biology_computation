"Input file must be named input_file.txt"
"This only works for one-line sequences"

$input_file = ".\input_file.txt"
$input_file_contents = Get-Content $input_file

$output_file = ".\result.txt"

Remove-Item $output_file -ErrorAction Ignore

$counter=0
$flag=0     # Do I write the second line - the sequence lin
$uniqueArray = @()

ForEach ($line_in_file in $input_file_contents) {
    # PRINT THE SECOND LINE IF FLAG IS SET
    if ($flag -eq 1) {
        Write-Host $line_in_file
        Add-Content -Path $output_file -Value $line_in_file
        $flag=0
    }

    # Sequence declaration starts here with >
    if ($line_in_file.Substring(0,1) -eq '>') {
        
        # Add to array if it does not yet exist
        If ($uniqueArray -notcontains $line_in_file.Substring(1,$line_in_file.IndexOf(".")-1)) {            
            $uniqueArray += $line_in_file.Substring(1,$line_in_file.IndexOf(".")-1)

            Add-Content -Path $output_file -Value $line_in_file
            Write-Host $line_in_file
            $flag=1
        }
    }
    $counter++
}

Read-Host -Prompt "Press Enter to exit"