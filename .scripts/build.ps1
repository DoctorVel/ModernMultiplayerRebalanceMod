Param(
    [string] $srcDirectory, # the path that contains your mod's .XCOM_sln
    [string] $sdkPath, # the path to your SDK installation ending in "XCOM 2 War of the Chosen SDK"
    [string] $gamePath, # the path to your XCOM 2 installation ending in "XCOM2-WaroftheChosen"
    [string] $config # build configuration
)

$ScriptDirectory = Split-Path $MyInvocation.MyCommand.Path
$common = Join-Path -Path $ScriptDirectory "X2ModBuildCommon\build_common.ps1"
Write-Host "Sourcing $common"
. ($common)

$builder = [BuildProject]::new("ModernMultiplayerRebalanceMode", $srcDirectory, $sdkPath, $gamePath)

# Use GIT to add Highlander submodule.
# git submodule add https://github.com/X2CommunityCore/X2WOTCCommunityHighlander.git

# Uncomment the next line to enable building against Highlander.
$builder.IncludeSrc("$srcDirectory\X2WOTCCommunityHighlander\X2WOTCCommunityHighlander\Src")
# $builder.IncludeSrc("$srcDirectory\CustomSrc")

switch ($config)
{
    "debug" {
        $builder.EnableDebug()
    }
    "default" {
        # Nothing special
    }
    "" { ThrowFailure "Missing build configuration" }
    default { ThrowFailure "Unknown build configuration $config" }
}

# Uncomment this line to enable cooking.
$ $builder.SetContentOptionsJsonFilename("ContentOptions.json")
$builder.InvokeBuild()