@echo off
rem Controlla se la cartella FileHistory.old esiste già
if exist "%LocalAppData%\Microsoft\Windows\FileHistory.old" (
    echo Errore: La cartella FileHistory.old esiste gia'.
    echo Rinomina impossibile.
    pause
    exit /b
)

rem Rinomina la cartella FileHistory in FileHistory.old
if exist "%LocalAppData%\Microsoft\Windows\FileHistory" (
    ren "%LocalAppData%\Microsoft\Windows\FileHistory" FileHistory.old
    echo Cartella FileHistory rinominata con successo in FileHistory.old.
) else (
    echo Errore: La cartella FileHistory non esiste.
)

pause
