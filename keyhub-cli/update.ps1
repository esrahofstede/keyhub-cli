import-module au
. $PSScriptRoot\..\_scripts\all.ps1

$releases = 'https://files.topicus-keyhub.com/manual/manual-en-GB.html'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*[$]packageName\s*=\s*)('.*')"= "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge }
function global:au_AfterUpdate  { 
    Set-DescriptionFromReadme -SkipFirst 0;
    $zipFiles = Get-ChildItem $PSScriptRoot/tools/*.zip
    $zipFiles | ForEach-Object { Remove-Item -Path $_.FullName } 
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $re  = "keyhub-cli.*.zip"
    $url = $download_page.links | ? href -match $re | Select-Object -First 1 -expand href
    $url = 'https://files.topicus-keyhub.com/manual/' + $url

    $version = $url -split '-|.zip' | Select-Object -Last 1 -Skip 1
    if($version -notcontains "\."){
        $version = $version + ".0"
    }

    $releasesPageUrl = "https://blog.topicus-keyhub.com/tag/release/";
    $releasesPage = Invoke-WebRequest -Uri $releasesPageUrl
    $releaseNotesPartialUrl = $releasesPage.links | ? href -match $version | Select-Object -First 1 -expand href
    $releaseNotesUrl = "https://blog.topicus-keyhub.com" + $releaseNotesPartialUrl

    $shaUrl = $url + ".sha256"
    $checksumFileName = "keyhub-cli.zip.sha256"
    Invoke-WebRequest -Uri $shaUrl -OutFile $checksumFileName
    $checksumContent = Get-Content -Path "./$checksumFileName"
    $checksum = $checksumContent.Substring(0,64)

    return @{
        URL32        = $url
        Version      = $version
        ReleaseNotes = "$releaseNotesUrl"
        Checksum32 = $checksum
    }
}

update -ChecksumFor none