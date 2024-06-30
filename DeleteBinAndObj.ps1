# Delete "bin" and "obj" folders recursively 
# Specify the root directory where you want to start the deletion 
$rootDirectory = "C:\Development\BFX" 
# Delete "bin" and "obj" folders recursively 
Get-ChildItem -Path $rootDirectory -Recurse -Include bin,obj | ForEach-Object {     
	if ($_ -is [System.IO.DirectoryInfo]) {         
		$_ | Remove-Item -Recurse -Force     
	} 
}