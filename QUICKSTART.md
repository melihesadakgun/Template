# Kurulum ve Başlangıç Rehberi (Quick Start)

## 📦 Sistem Gereksinimleri

- **Node.js:** 18+ LTS
- **npm:** 9+
- **OS:** Windows, macOS, Linux
- **Git:** 2.30+

---

## 🚀 Hızlı Kurulum

### 1. Projeyi Klonla

```bash
git clone https://github.com/org/project-template.git
cd project-template
```

### 2. Bağımlılıkları Yükle

```bash
npm install

# VS Code eklentileri yükle (önerilen)
# - sonarsource.sonarlint-vscode
# - snyk-security.snyk-vscode
# - ryanluker.vscode-coverage-gutters
# - yzhang.markdown-all-in-one
# - eamodio.gitlens
# - editorconfig.editorconfig
```

### 3. Yapılandırma

```bash
# .env dosyası oluştur (örnek: .env.example)
cp .env.example .env

# Terminal'de aşağıdaki komutları çalıştır:
npm run setup
```

### 4. Çalışmaya Başla

```bash
# Geliştirme sunucusu
npm run dev

# Browser'da açılacak: http://localhost:3000
```

---

## ✅ Kalite Kontrol Komutları

```bash
# Birim testleri çalıştır
npm test

# Coverage raporu (hedef ≥80%)
npm run coverage

# Kod formatlama
npm run prettier

# ESLint analizi
npm run lint

# Tüm kalite kontrolleri (CI Pipeline simüle)
npm run quality:check
```

---

## 📖 Dokümantasyon

| Belge             | Aç                                       | Amaç             |
| :---------------- | :--------------------------------------- | :--------------- |
| Proje Anayasası   | [GEMINI.md](GEMINI.md)                   | Küresel kurallar |
| İş Akışı          | [globalworkflows.md](globalworkflows.md) | Süreçler         |
| Katkı Rehberi     | [CONTRIBUTING.md](CONTRIBUTING.md)       | Geliştirme       |
| Test Standartları | [docs/test/](docs/test/)                 | Test kuralları   |
| ISO Uyum          | [docs/yonetim/](docs/yonetim/)           | Standartlar      |
| Şablonlar         | [docs/sablonlar/](docs/sablonlar/)       | Dokümantasyon    |

---

## 🔗 Faydalı Linkler

- **GitHub Issues:** [GitHub Issues URL]
- **Project Board:** [Azure/Jira Board URL]
- **SonarQube Dashboard:** [SonarQube URL]
- **CI/CD Logs:** [GitHub Actions / Jenkins URL]

---

## ✍️ Benimsenecek Şablonlar

Yeni özellik geliştirirken kullan:

```bash
# Gereksinim Dokümanı
cp docs/sablonlar/GEREKSINIM_DOKUMANI_SABLONU.md docs/FEATURE_NAME_REQUIREMENT.md

# Tasarım Dokümanı (eğer gerekse)
cp docs/sablonlar/TASARIM_DOKUMANI_SABLONU.md docs/FEATURE_NAME_DESIGN.md

# Test Planı
cp docs/sablonlar/TEST_PLANI_SABLONU.md docs/FEATURE_NAME_TEST_PLAN.md
```

---

## 🤝 Yardıma mı İhtiyacın Var?

- **Sorular:** [Slack Channel / Email]
- **Hata Bildir:** GitHub Issues
- **Doc Katkısı:** docs/ klasöründe edit ve PR aç

Mutlu Kodlamalar! 🚀
