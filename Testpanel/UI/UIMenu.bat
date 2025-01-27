@ECHO OFF

:VBSDynamicBuild
SET TempVBSFile=%temp%\~tmpSendKeysTemp.vbs
IF EXIST "%TempVBSFile%" DEL /F /Q "%TempVBSFile%"
ECHO Set WshShell = WScript.CreateObject("WScript.Shell") >>"%TempVBSFile%"
ECHO Wscript.Sleep 900                                    >>"%TempVBSFile%"
ECHO WshShell.SendKeys "{F11}"                            >>"%TempVBSFile%
ECHO Wscript.Sleep 900                                    >>"%TempVBSFile%"

CSCRIPT //nologo "%TempVBSFile%"

:: Put whatever logic below for your script to run in the full screen CMD window
cls
color 17
echo TTTTTTTTTTTTTTTTTTTTTTT                                          tttt          PPPPPPPPPPPPPPPPP                                                       lllllll  
echo T:::::::::::::::::::::T                                       ttt:::t          P::::::::::::::::P                                                      l:::::l
echo T:::::::::::::::::::::T                                       t:::::t          P::::::PPPPPP:::::P                                                     l:::::l
echo T:::::TT:::::::TT:::::T                                       t:::::t          PP:::::P     P:::::P                                                    l:::::l
echo TTTTTT  T:::::T  TTTTTTeeeeeeeeeeee        ssssssssss   ttttttt:::::ttttttt      P::::P     P:::::Paaaaaaaaaaaaa  nnnn  nnnnnnnn        eeeeeeeeeeee    l::::l 
echo         T:::::T      ee::::::::::::ee    ss::::::::::s  t:::::::::::::::::t      P::::P     P:::::Pa::::::::::::a n:::nn::::::::nn    ee::::::::::::ee  l::::l
echo         T:::::T     e::::::eeeee:::::eess:::::::::::::s t:::::::::::::::::t      P::::PPPPPP:::::P aaaaaaaaa:::::an::::::::::::::nn  e::::::eeeee:::::eel::::l  
echo         T:::::T    e::::::e     e:::::es::::::ssss:::::stttttt:::::::tttttt      P:::::::::::::PP           a::::ann:::::::::::::::ne::::::e     e:::::el::::l  
echo         T:::::T    e:::::::eeeee::::::e s:::::s  ssssss       t:::::t            P::::PPPPPPPPP      aaaaaaa:::::a  n:::::nnnn:::::ne:::::::eeeee::::::el::::l  
echo         T:::::T    e:::::::::::::::::e    s::::::s            t:::::t            P::::P            aa::::::::::::a  n::::n    n::::ne:::::::::::::::::e l::::l
echo         T:::::T    e::::::eeeeeeeeeee        s::::::s         t:::::t            P::::P           a::::aaaa::::::a  n::::n    n::::ne::::::eeeeeeeeeee  l::::l    
echo         T:::::T    e:::::::e           ssssss   s:::::s       t:::::t    tttttt  P::::P          a::::a    a:::::a  n::::n    n::::ne:::::::e           l::::l  
echo       TT:::::::TT  e::::::::e          s:::::ssss::::::s      t::::::tttt:::::tPP::::::PP        a::::a    a:::::a  n::::n    n::::ne::::::::e         l::::::l
echo       T:::::::::T   e::::::::eeeeeeee  s::::::::::::::s       tt::::::::::::::tP::::::::P        a:::::aaaa::::::a  n::::n    n::::n e::::::::eeeeeeee l::::::l
echo       T:::::::::T    ee:::::::::::::e   s:::::::::::ss          tt:::::::::::ttP::::::::P         a::::::::::aa:::a n::::n    n::::n  ee:::::::::::::e l::::::l
echo       TTTTTTTTTTT      eeeeeeeeeeeeee    sssssssssss              ttttttttttt  PPPPPPPPPP          aaaaaaaaaa  aaaa nnnnnn    nnnnnn    eeeeeeeeeeeeee llllllll
echo TestPanel Version: V3.1 [Made By Thebinhdx]
echo Press Ctrl+C To Close...
timeout /t 32976 /nobreak >nul
exit