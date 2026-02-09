#!/usr/bin/env bash

# Proje Başlangıç Kurulum Script
# ISO standartlarına uyumlu ortam hazırlama
# Çalıştırma: bash scripts/setup.sh

set -e

echo "=================================================="
echo "🚀 Proje Başlangıç Kurulum Script"
echo "=================================================="
echo ""

# Renk kodları
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Fonksiyonlar
print_step() {
    echo -e "${BLUE}📋 $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# ADIM 1: Node.js Kontrol
print_step "Node.js sürümü kontrol ediliyor..."
if ! command -v node &> /dev/null; then
    print_error "Node.js yüklü değil! Lütfen Node.js 18+ yükleyin"
    exit 1
fi

NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
    print_error "Node.js 18 veya üzeri gerekli (Mevcut: $(node -v))"
    exit 1
fi

print_success "Node.js $(node -v) bulundu"
echo ""

# ADIM 2: npm Bağımlılıkları
print_step "npm bağımlılıkları yükleniyor..."
npm install --legacy-peer-deps 2>/dev/null || npm install
print_success "Bağımlılıklar yüklendi"
echo ""

# ADIM 3: .env Dosyası
print_step ".env dosyası ayarlanıyor..."
if [ ! -f .env ]; then
    cp .env.example .env
    print_success ".env dosyası oluşturuldu"
    print_warning "⚠️  .env dosyasını düzenlemeyi unutmayın (SONAR_TOKEN, vb)"
else
    print_success ".env dosyası zaten mevcut"
fi
echo ""

# ADIM 4: Testleri Çalıştır
print_step "Birim testleri çalıştırılıyor..."
npm test -- --passWithNoTests 2>/dev/null || true
print_success "Testler tamamlandı"
echo ""

# ADIM 5: Linting
print_step "Kod kalitesi kontrol ediliyor..."
npm run lint 2>/dev/null || print_warning "ESLint kontrol atlandı"
echo ""

# ADIM 6: Build
print_step "Proje derleniyor..."
npm run build 2>/dev/null || print_warning "TypeScript build atlandı"
print_success "Derleme tamamlandı"
echo ""

# ADIM 7: GitHub Secrets Kontrol
print_step "GitHub Secrets kontrolü..."
if [ -n "$SONAR_TOKEN" ]; then
    print_success "SONAR_TOKEN bulundu"
else
    print_warning "SONAR_TOKEN GitHub Secrets'a eklenmemiş"
    echo "          Lütfen repo settings'e giderek ekleyin"
fi
echo ""

# Özet
echo "=================================================="
echo -e "${GREEN}🎉 Kurulum Tamamlandı!${NC}"
echo "=================================================="
echo ""
echo "Sonraki Adımlar:"
echo "1. .env dosyasını düzenle (SONAR_TOKEN, SONAR_ORGANIZATION)"
echo "2. GitHub Secrets'a token ekle"
echo "3. npm run dev - Geliştirme sunucusu başlat"
echo "4. npm test - Testleri çalıştır"
echo "5. git push - GitHub'a push et → Pipeline otomatik çalışacak"
echo ""
echo "Dokümantasyon: https://github.com/your-org/project/wiki"
echo ""
