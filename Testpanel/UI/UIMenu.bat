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
echo TTTTTTTTTTTTTTTTTTTTTTT                                          tttt          PPPPPPPPPPPPPPPPP                                                       lllllll      VVVVVVVV           VVVVVVVV 222222222222222    
echo T:::::::::::::::::::::T                                       ttt:::t          P::::::::::::::::P                                                      l:::::l      V::::::V           V::::::V2:::::::::::::::22  
echo T:::::::::::::::::::::T                                       t:::::t          P::::::PPPPPP:::::P                                                     l:::::l      V::::::V           V::::::V2::::::222222:::::2 
echo T:::::TT:::::::TT:::::T                                       t:::::t          PP:::::P     P:::::P                                                    l:::::l      V::::::V           V::::::V2222222     2:::::2 
echo TTTTTT  T:::::T  TTTTTTeeeeeeeeeeee        ssssssssss   ttttttt:::::ttttttt      P::::P     P:::::Paaaaaaaaaaaaa  nnnn  nnnnnnnn        eeeeeeeeeeee    l::::l       V:::::V           V:::::V             2:::::2 
echo         T:::::T      ee::::::::::::ee    ss::::::::::s  t:::::::::::::::::t      P::::P     P:::::Pa::::::::::::a n:::nn::::::::nn    ee::::::::::::ee  l::::l        V:::::V         V:::::V              2:::::2 
echo         T:::::T     e::::::eeeee:::::eess:::::::::::::s t:::::::::::::::::t      P::::PPPPPP:::::P aaaaaaaaa:::::an::::::::::::::nn  e::::::eeeee:::::eel::::l         V:::::V       V:::::V            2222::::2  
echo         T:::::T    e::::::e     e:::::es::::::ssss:::::stttttt:::::::tttttt      P:::::::::::::PP           a::::ann:::::::::::::::ne::::::e     e:::::el::::l          V:::::V     V:::::V        22222::::::22   
echo         T:::::T    e:::::::eeeee::::::e s:::::s  ssssss       t:::::t            P::::PPPPPPPPP      aaaaaaa:::::a  n:::::nnnn:::::ne:::::::eeeee::::::el::::l           V:::::V   V:::::V       22::::::::222     
echo         T:::::T    e:::::::::::::::::e    s::::::s            t:::::t            P::::P            aa::::::::::::a  n::::n    n::::ne:::::::::::::::::e l::::l            V:::::V V:::::V       2:::::22222        
echo         T:::::T    e::::::eeeeeeeeeee        s::::::s         t:::::t            P::::P           a::::aaaa::::::a  n::::n    n::::ne::::::eeeeeeeeeee  l::::l             V:::::V:::::V       2:::::2             
echo         T:::::T    e:::::::e           ssssss   s:::::s       t:::::t    tttttt  P::::P          a::::a    a:::::a  n::::n    n::::ne:::::::e           l::::l              V:::::::::V        2:::::2             
echo       TT:::::::TT  e::::::::e          s:::::ssss::::::s      t::::::tttt:::::tPP::::::PP        a::::a    a:::::a  n::::n    n::::ne::::::::e         l::::::l              V:::::::V         2:::::2       222222
echo       T:::::::::T   e::::::::eeeeeeee  s::::::::::::::s       tt::::::::::::::tP::::::::P        a:::::aaaa::::::a  n::::n    n::::n e::::::::eeeeeeee l::::::l               V:::::V          2::::::2222222:::::2
echo       T:::::::::T    ee:::::::::::::e   s:::::::::::ss          tt:::::::::::ttP::::::::P         a::::::::::aa:::a n::::n    n::::n  ee:::::::::::::e l::::::l                V:::V           2::::::::::::::::::2
echo       TTTTTTTTTTT      eeeeeeeeeeeeee    sssssssssss              ttttttttttt  PPPPPPPPPP          aaaaaaaaaa  aaaa nnnnnn    nnnnnn    eeeeeeeeeeeeee llllllll                 VVV            22222222222222222222
echo TestPanel Version: V2.5.3_Beta3 [Made By Thebinhdx]
echo Press Ctrl+C To Close...
timeout /t 32976 /nobreak >nul
exit