$ErrorActionPreference = 'Stop';

$packageName= 'keyhub-cli'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  url           = 'https://files.topicus-keyhub.com/manual/keyhub-cli-40.zip'
  checksum = '0154BD2C70810950897B80AAC81E3161C5A0299C1433326DCA64DA8CDE4E8991'
  checksumType = 'sha256'
}

# https://chocolatey.org/docs/helpers-install-chocolatey-zip-package
Install-ChocolateyZipPackage @packageArgs

## Unzips a file to the specified location - auto overwrites existing content
## - https://chocolatey.org/docs/helpers-get-chocolatey-unzip
# Get-ChocolateyUnzip @packageArgs -destination $toolsDir -fileFullPath $fileLocation 
# Install-ChocolateyPath -pathToInstall $toolsDir  -pathType 'Machine'
Install-BinFile -Name keyhub -Path $toolsDir/keyhub.cmd
