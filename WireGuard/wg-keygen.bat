@echo off
setlocal enabledelayedexpansion

echo ================================
echo   WireGuard KEY GENERATOR
echo ================================
echo.

echo [1] Generating SERVER keypair...
for /f %%i in ('wg genkey') do set SERVER_PRIV=%%i
for /f %%i in ('echo !SERVER_PRIV! ^| wg pubkey') do set SERVER_PUB=%%i

echo [2] Generating CLIENT keypair...
for /f %%i in ('wg genkey') do set CLIENT_PRIV=%%i
for /f %%i in ('echo !CLIENT_PRIV! ^| wg pubkey') do set CLIENT_PUB=%%i

echo [3] Generating Preshared Key...
for /f %%i in ('wg genpsk') do set PSK=%%i

echo.
echo ================================
echo         SERVER KEYS
echo ================================
echo PRIVATE:
echo !SERVER_PRIV!
echo.
echo PUBLIC:
echo !SERVER_PUB!
echo.

echo ================================
echo         CLIENT KEYS
echo ================================
echo PRIVATE:
echo !CLIENT_PRIV!
echo.
echo PUBLIC:
echo !CLIENT_PUB!
echo.

echo ================================
echo       PRE-SHARED KEY
echo ================================
echo !PSK!
echo.

echo ================================
echo DONE
echo ================================
pause