@echo off
echo.
echo ========================================
echo   SKOOLMATE - PRE-PUSH SECURITY CHECK
echo ========================================
echo.

:: Check if sensitive files are tracked
echo [1/5] Checking for sensitive files in Git...
git ls-files | findstr /I "firebase_options.dart google-services.json local.properties .env" > nul
if %ERRORLEVEL% EQU 0 (
    echo [ERROR] Sensitive files are tracked by Git!
    echo Run: git rm --cached lib/firebase_options.dart
    echo Run: git rm --cached android/app/google-services.json
    echo Run: git rm --cached android/local.properties
    pause
    exit /b 1
) else (
    echo [PASS] No sensitive files tracked
)
echo.

:: Check .gitignore exists
echo [2/5] Checking .gitignore...
if not exist ".gitignore" (
    echo [ERROR] .gitignore file not found!
    pause
    exit /b 1
) else (
    echo [PASS] .gitignore exists
)
echo.

:: Check for API keys in staged files
echo [3/5] Scanning staged files for API keys...
git diff --cached | findstr /I "AIza api_key apiKey" > nul
if %ERRORLEVEL% EQU 0 (
    echo [WARNING] Possible API keys found in staged files!
    echo Please review your changes carefully.
    pause
) else (
    echo [PASS] No API keys detected
)
echo.

:: Check if example files exist
echo [4/5] Checking example configuration files...
if not exist "lib\firebase_options.dart.example" (
    echo [WARNING] firebase_options.dart.example not found
) else (
    echo [PASS] firebase_options.dart.example exists
)
if not exist "android\app\google-services.json.example" (
    echo [WARNING] google-services.json.example not found
) else (
    echo [PASS] google-services.json.example exists
)
echo.

:: Check documentation
echo [5/5] Checking documentation...
if not exist "README.md" (
    echo [WARNING] README.md not found
) else (
    echo [PASS] README.md exists
)
if not exist "FIREBASE_SETUP_INSTRUCTIONS.md" (
    echo [WARNING] FIREBASE_SETUP_INSTRUCTIONS.md not found
) else (
    echo [PASS] FIREBASE_SETUP_INSTRUCTIONS.md exists
)
echo.

echo ========================================
echo   SECURITY CHECK COMPLETE
echo ========================================
echo.
echo Next steps:
echo 1. Review the output above
echo 2. Fix any [ERROR] or [WARNING] issues
echo 3. Run: git status (verify what will be committed)
echo 4. Run: git commit -m "Your message"
echo 5. Run: git push origin main
echo.
pause
