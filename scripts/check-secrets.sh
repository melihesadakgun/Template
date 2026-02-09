#!/usr/bin/env bash

# GitHub Secrets Yardımcı Script
# SonarCloud token ve organization key'i kontrol eder
# Çalıştırma: bash scripts/check-secrets.sh

echo "=================================================="
echo "🔐 GitHub Secrets Kontrol Script"
echo "=================================================="
echo ""

# Kontrol Listesi
checks_passed=0
checks_failed=0

# Fonksiyon: Secret kontrol
check_secret() {
    local secret_name=$1
    local description=$2

    echo -n "Kontrol: $description... "

    if [ -n "${!secret_name}" ]; then
        echo "✅ Bulundu"
        ((checks_passed++))
    else
        echo "❌ Eksik"
        echo "   → GitHub Repo Settings → Secrets → $secret_name ekleyin"
        ((checks_failed++))
    fi
}

# Secrets kontrol et
echo "GitHub Secrets Kontrolü:"
echo ""

check_secret "SONAR_TOKEN" "SONAR_TOKEN (SonarCloud erişim)"
check_secret "SONAR_ORGANIZATION" "SONAR_ORGANIZATION (Organization key)"
check_secret "SNYK_TOKEN" "SNYK_TOKEN (Güvenlik taraması)"

echo ""
echo ".env Dosyası Kontrolü:"
echo ""

if [ -f .env ]; then
    echo "✅ .env dosyası var"

    if grep -q "SONAR_TOKEN" .env; then
        echo "✅ SONAR_TOKEN .env'de tanımlı"
    else
        echo "⚠️  SONAR_TOKEN .env'de eksik"
    fi
else
    echo "❌ .env dosyası bulunamadı"
    echo "   → cp .env.example .env"
fi

echo ""
echo "=================================================="
echo "Özet: $checks_passed başarılı, $checks_failed eksik"
echo "=================================================="
echo ""

if [ $checks_failed -eq 0 ]; then
    echo "✅ Tüm kontroller başarılı! Push yapabilirsiniz."
    exit 0
else
    echo "❌ Bazı secretslar eksik. Lütfen GitHub Settings'te ekleyin."
    exit 1
fi
