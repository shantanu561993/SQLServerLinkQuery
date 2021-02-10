Function Get-SQLServerLinkQuery{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$false,
        HelpMessage="SQL link path to crawl. This is used by Get-SQLServerLinkCrawl.")]
        $Path=@(),
        
        [Parameter(Mandatory=$false,
        HelpMessage="SQL query to build the crawl path around")]
        $Sql, 
        
        [Parameter(Mandatory=$false,
        HelpMessage="Counter to determine how many single quotes needed")]
        $Ticks=0

    )
    if ($Path.length -le 1){
        return($Sql -replace "'", ("'"*[Math]::pow(2,$Ticks)))
    } else {
        Write-Output("select * from openquery(`""+$Path[1]+"`","+"'"*[Math]::pow(2,$Ticks)+
        (Get-SQLServerLinkQuery -path $Path[1..($Path.Length-1)] -sql $Sql -ticks ($Ticks+1))+"'"*[Math]::pow(2,$Ticks)+")")
    }
}
