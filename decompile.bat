@echo off

call setup.bat %1
call findjdk.bat PATH

set REINDEX_NUMBER=12000

java -help > NUL 2> NUL
if errorlevel 1 (
    echo Unable to locate java.exe. Please verify that it is in the PATH.
    pause
    exit /b
)

if NOT EXIST "%MCPTEMPDIR%" mkdir "%MCPTEMPDIR%"
if NOT EXIST "%MCPSOURCESDIR%" mkdir "%MCPSOURCESDIR%"
if NOT EXIST "%MCPLOGDIR%" mkdir "%MCPLOGDIR%"

echo === Minecraft Coder Pack %MCPVERSION% === >"%MCPLOG%"

echo MCP %MCPVERSION% running in %MCPDIR%

if exist "%MCJAR%" (
    echo *** minecraft.jar was found, processing >>"%MCPLOG%"
    
    echo Deobfuscating minecraft.jar
    echo *** Deobfuscating minecraft.jar >>"%MCPLOG%"
    %MCPRG% "%MCJAR%" "%MCRGJAR%" "%MCRGSCRIPT%" "%MCRGLOG%" %REINDEX_NUMBER% >>"%MCPLOG%"
    
    echo Unpacking minecraft.jar
    echo *** Unpacking minecraft.jar >>"%MCPLOG%"
    "%MCPUNZIP%" -o "%MCRGJAR%" * -d "%MCTEMP%" >>"%MCPLOG%"
    del /f /q "%MCTEMP%\META-INF\MOJANG_C.*"

    echo Fixing minecraft classes
    echo *** Fixing minecraft classes >>"%MCPLOG%"
    "%MCPJR%" -b "%MCTEMP%" >>"%MCPLOG%" 2>NUL:

    echo Decompiling minecraft classes
    echo *** Decompiling minecraft classes >>"%MCPLOG%"
    "%MCPJAD%" -b -d "%MCJADOUT%" -dead -o -r -s .java -stat -v "%MCTEMP%\*.class" 2>>"%MCPLOG%"
    "%MCPJAD%" -b -d "%MCJADOUT%" -dead -o -r -s .java -stat -v "%MCTEMP%\net\minecraft\client\*.class" 2>>"%MCPLOG%"

    echo Repackage minecraft sources
    echo *** Repackage minecraft sources >>"%MCPLOG%"
    "%MCPREPACK%" "%MCJADOUT%" %MCPACKAGE% >>"%MCPLOG%"
    
    echo Patching minecraft sources
    echo *** Patching minecraft sources >>"%MCPLOG%"
    "%MCPPATCH%" -p 1 -u -i "%MCPATCH%" -d "%MCJADOUT%" >>"%MCPLOG%"

) else (
    echo Minecraft.jar was not found.
    echo Minecraft.jar was not found >>"%MCPLOG%"
)

if exist "%MCSJAR%" (
    echo *** minecraft_server.jar was found, processing >>"%MCPLOG%"
    
    echo Deobfuscating minecraft_server.jar
    echo *** Deobfuscating minecraft_server.jar >>"%MCPLOG%"
    %MCPRG% "%MCSJAR%" "%MCSRGJAR%" "%MCSRGSCRIPT%" "%MCSRGLOG%" %REINDEX_NUMBER% >>"%MCPLOG%"
    
    echo Unpacking minecraft_server.jar
    echo *** Unpacking minecraft_server.jar >>"%MCPLOG%"
    "%MCPUNZIP%" -o "%MCSRGJAR%" * -d "%MCSTEMP%" >>"%MCPLOG%"

    echo Fixing minecraft server classes
    echo *** Fixing minecraft server classes >>"%MCPLOG%"
    "%MCPJR%" -b "%MCSTEMP%" >>"%MCPLOG%" 2>NUL:

    echo Decompiling minecraft server classes
    echo *** Decompiling minecraft server classes >>"%MCPLOG%"
    "%MCPJAD%" -b -d "%MCSJADOUT%" -dead -o -r -s .java -stat -v "%MCSTEMP%\*.class" 2>>"%MCPLOG%"
    "%MCPJAD%" -b -d "%MCSJADOUT%" -dead -o -r -s .java -stat -v "%MCSTEMP%\net\minecraft\server\*.class" 2>>"%MCPLOG%"

    echo Repackage minecraft server sources
    echo *** Repackage minecraft server sources >>"%MCPLOG%"
    "%MCPREPACK%" "%MCSJADOUT%" %MCSPACKAGE% >>"%MCPLOG%"
    
    echo Patching minecraft server sources
    echo *** Patching minecraft server sources >>"%MCPLOG%"
    "%MCPPATCH%" -p 1 -u -i "%MCSPATCH%" -d "%MCSJADOUT%" >>"%MCPLOG%"

) else (
    echo Minecraft_server.jar was not found.
    echo Minecraft_server.jar was not found >>"%MCPLOG%"
)

    if exist "%MCPSPLASHES%" copy "%MCPSPLASHES%" "%MCSPLASHES%"
    
    echo Renaming methods and fields
    echo *** Renaming methods and fields >>"%MCPLOG%"
    "%MCPRENAMER%" -R -c "%MCPCONFDIR%\renamer.conf" >>"%MCPLOG%"

echo === MCP %MCPVERSION% decompile script finished ===
pause
