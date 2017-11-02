<# it hashes stings

example usage:
foreach ($i_alg in ("MD5","SHA1","SHA256","SHA384","SHA512")) {funHashString -String 'test' -Algorithm $i_alg}

Hash                                                                                                                             Algorithm String
----                                                                                                                             --------- ------
098F6BCD4621D373CADE4E832627B4F6                                                                                                 MD5       test  
A94A8FE5CCB19BA61C4C0873D391E987982FBBD3                                                                                         SHA1      test  
9F86D081884C7D659A2FEAA0C55AD015A3BF4F1B2B0B822CD15D6C15B0F00A08                                                                 SHA256    test  
768412320F7B0AA5812FCE428DC4706B3CAE50E02A64CAA16A782249BFE8EFC4B7EF1CCB126255D196047DFEDF17A0A9                                 SHA384    test  
EE26B0DD4AF7E749AA1A8EE3C10AE9923F618980772E473F8819A5D4940E0DB27AC185F8A0E1D5F84F88BC887FD67B143732C304CC5FA9AD8E6F57F50028A8FF SHA512    test 
#>


Function funHashString
    {
        Param(
        [Parameter(Mandatory=$false)][ValidateSet("MD5","SHA1","SHA256","SHA384","SHA512")][String]$Algorithm = "MD5",
        [Parameter(Mandatory=$true)][String]$String)

        Process
            {
                $UTF8 = New-Object -TypeName System.Text.UTF8Encoding

                Switch ($Algorithm)
                    {
                        "MD5" {$hasher = New-Object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider}
                        "SHA1" {$hasher = New-Object -TypeName System.Security.Cryptography.SHA1CryptoServiceProvider}
                        "SHA256" {$hasher = New-Object -TypeName System.Security.Cryptography.SHA256CryptoServiceProvider}
                        "SHA384"{$hasher = New-Object -TypeName System.Security.Cryptography.SHA384CryptoServiceProvider}
                        "SHA512" {$hasher = New-Object -TypeName System.Security.Cryptography.SHA512CryptoServiceProvider}
                    }


                $Hash = ([System.BitConverter]::ToString($hasher.ComputeHash($UTF8.GetBytes($String))) -replace '-')

                $ResultsTable = New-Object System.Data.DataTable
                $ResultsTable += New-Object psobject -Property @{
                "String"=$String;
                "Algorithm"=$Algorithm;
                "Hash"=$Hash}

                Return ($ResultsTable)
            }
    }
