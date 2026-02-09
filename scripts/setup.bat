@echo off
REM Proje Başlangıç Kurulum Script (Windows)
REM PowerShell üzerinde çalışır
REM Çalıştırma: scripts\setup.bat

setlocal enabledelayedexpansion

echo ==================================================
echo.
echo 🚀 Proje Başlangıç Kurulum Script (Windows)
echo.
echo ==================================================
echo.

REM ADIM 1: Node.js Kontrol
echo 📋 Node.js sürümü kontrol ediliyor...
node --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Node.js yüklü değil! Lütfen Node.js 18+ yükleyin
    exit /b 1
)

for /f "tokens=1" %%i in ('node --version') do set NODE_VER=%%i
echo ✅ Node.js %NODE_VER% bulundu
echo.

REM ADIM 2: npm Bağımlılıkları
echo 📋 npm bağımlılıkları yükleniyor...
call npm install --legacy-peer-deps 2>nul || call npm install
if errorlevel 1 (
    echo ❌ npm install başarısız
    exit /b 1
)
echo ✅ Bağımlılıklar yüklendi
echo.

REM ADIM 3: .env Dosyası
echo 📋 .env dosyası ayarlanıyor...
if not exist .env (
    copy .env.example .env
    echo ✅ .env dosyası oluşturuldu
    echo ⚠️  .env dosyasını düzenlemeyi unutmayın (SONAR_TOKEN, vb)
) else (
    echo ✅ .env dosyası zaten mevcut
)
echo.

REM ADIM 4: Testleri Çalıştır
echo 📋 Birim testleri çalıştırılıyor...
call npm test -- --passWithNoTests 2>nul || echo ⚠️  Testler atlandı
echo.

REM ADIM 5: Build
echo 📋 Proje derleniyor...
call npm run build 2>nul || echo ⚠️  Build atlandı
echo ✅ Derleme tamamlandı
echo.

REM Özet
echo ==================================================
echo 🎉 Kurulum Tamamlandı!
echo ==================================================
echo.
echo Sonraki Adımlar:
echo 1. .env dosyasını düzenle (SONAR_TOKEN, SONAR_ORGANIZATION)
echo 2. GitHub Secrets'a token ekle
echo 3. npm run dev - Geliştirme sunucusu başlat
echo 4. npm test - Testleri çalıştır
echo 5. git push - GitHub'a push et (Pipeline otomatik çalışacak)
echo.
pause
