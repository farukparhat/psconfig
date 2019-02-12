# ------ Chocolatey Profile ------

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}

# ------ Shortcuts ------

function Sublime ($file)
{
    & 'C:\Program Files\Sublime Text 3\subl.exe' $file
}

# ------ Git ------

function gcheckout ($pattern)
{
    $b = ""
    if ($pattern)
    {
        $b = git branch -a
        $b = $b | sls $pattern
    }
    else
    {
        $b = git branch
    }

    if (!$b)
    {
        return
    }

    $b = $b | sort | fzf
    if (!$b)
    {
        return
    }

    $b = $b.Replace("*", "").Trim()

    git checkout $b
}

function gdiff
{
    git diff
}

function gstatus
{
    git status
}

function gpull
{
    git pull
}

function gpush
{
    git push
}

function gclone ($repo)
{
    if (!$repo)
    {
        Write-Output "Please enter a repository path"
    }
    else
    {
        git clone git@github.com:$repo
    }
}

function gcommit-and-push ($message)
{
    if (!$message)
    {
        Write-Output "Please enter a commit message"
    }
    else
    {
        git commit -am $message; git push
    }
}

# ------ Fast Edits ------

function evim
{
    e ~\.vim\.vimrc
}

function epp
{
    e ~\psconfig\profile.ps1
}

function e ($file)
{
    if (!$file)
    {
        $file = fzf
        e $file
    }
    else
    {
        gvim --remote $file
    }
}

# ------ Directory Commands ------

function ws
{
    cd c:\Workspace
}

function repos
{
    cd c:\Workspace\Repositories
}

function temp
{
    cd c:\temp
}

function home
{
    cd ~
}

# ------ Initialization ------

function init
{
    Set-PSReadlineOption -BellStyle None
}

init
