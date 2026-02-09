# SonarCloud Kurulum Rehberi

Bu rehber, projenin SonarCloud ile statik analiz yapmasını sağlamak için gerekli adımları açıklar.

---

## 📋 Ön Koşullar

- **GitHub Hesabı:** SonarCloud GitHub ile entegre şekilde
- **Organization** (Opsiyonel): SonarCloud'da kurulu organization
- **GitHub Token:** `SONAR_TOKEN` eklenmesi gereken
- **Node.js:** 18+ LTS

---

## 🚀 Adım Adım Kurulum

### **ADIM 1: SonarCloud Hesabı Oluştur**

1. https://sonarcloud.io adresine git
2. **"Sign Up with GitHub"** butonuna tıkla
3. GitHub hesabınla oturum aç
4. **Authorize SonarCloud** onayı ver

---

### **ADIM 2: Organization Oluştur veya Seç**

**Yeni Organization oluştururken:**
1. SonarCloud Dashboard → **Organizations**
2. **Create Organization** → "Other" seç
3. Organization Key belgini: `YOUR-ORG-KEY` (örn: `my-company`)
4. Organization Name: İşletme adı

**Mevcut Organization kullanırken:**
1. https://sonarcloud.io/organizations → Öğreniş organization'ı seç
2. URL'den Organization Key'i al: `https://sonarcloud.io/organizations/YOUR-ORG-KEY/`

---

### **ADIM 3: Token Oluştur**

1. SonarCloud Dashboard → **Security** (sağ üst hesap menüsü)
2. **Generate Tokens** → Yeni token oluştur
   - **Token Name:** `github-actions` (örn)
   - **Type:** Global Analysis Token
   - **Expires in:** 30 days (veya custom)

3. Token'ı **kopyala** (Sonra görülemez!)

---

### **ADIM 4: GitHub Secrets'a Token Ekle**

Repository'nin GitHub Settings'ine git:

```
Repository → Settings → Secrets and variables → Actions
```

**New repository secret ekle:**

| Name                   | Value                         |
| :--------------------- | :---------------------------- |
| **SONAR_TOKEN**        | [Adım 3'ten kopyalanan token] |
| **SONAR_ORGANIZATION** | `YOUR-ORG-KEY`                |

---

### **ADIM 5: `sonar-project.properties` Dosyasını Güncelle**

Proje kök dizininde `sonar-project.properties` açın ve Organization Key'i ekleyin:

```properties
# SonarCloud için Organization (varsa)
sonar.organization=YOUR-ORG-KEY

# Proje Key (GitHub repo adı genelde otomatik atanır)
sonar.projectKey=YOUR-ORG-KEY_project-template
```

---

### **ADIM 6: Jest Coverage Konfigürasyonu**

`package.json`de test konfigürasyonu:

```json
{
  "scripts": {
    "test": "jest --coverage --detectOpenHandles",
    "test:watch": "jest --watch"
  },
  "jest": {
    "coverageReporters": ["lcov", "text", "html", "json-summary"],
    "collectCoverageFrom": [
      "src/**/*.{js,jsx,ts,tsx}",
      "!src/**/*.d.ts",
      "!src/**/index.ts"
    ],
    "testEnvironment": "node"
  }
}
```

---

### **ADIM 7: GitHub Actions Pipeline Kontrol**

`.github/workflows/pipeline.yml` kontrol listesi:

```yaml
# ✅ SONAR_TOKEN ortam değişkeni tanımlanmış
env:
  SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}

# ✅ fetch-depth: 0 (SonarCloud'ın full history'ye erişmesi)
- uses: actions/checkout@v4
  with:
    fetch-depth: 0

# ✅ Coverage rapport lcov formatında
npm test -- --coverage
```

---

### **ADIM 8: İlk Push Yap**

```bash
# Lokal test (Coverage oluşturaçak)
npm test

# Git'e push et
git add .
git commit -m "[SETUP] SonarCloud integration"
git push origin main
```

**GitHub Actions'ta Pipeline Çalışması:**

```
✅ Checkout
✅ SonarCloud Token Control
├─ ✅ Unit Tests & Coverage
├─ ✅ SonarCloud Analysis
├─ ✅ Quality Gate
└─ ✅ Build & Deploy
```

---

## 🔍 Sonuçları Kontrol Et

### **1. GitHub Actions Logs**

Repository → **Actions** → En son workflow → `Statik Kod ve Güvenlik Analizi`

Çıktı örneği:
```
✅ SONAR_TOKEN'ı başarıyla buldum
📊 Coverage: 82%
✅ SonarCloud analysis succeeded
✅ Quality Gate passed
```

### **2. SonarCloud Dashboard**

1. https://sonarcloud.io/projects adresine git
2. Projenizi bulun
3. **Metrics** sekmesi → Coverage, Bugs, Code Smells

---

## ⚠️ Sık Sorunlar ve Çözümleri

### **Sorun 1: "SONAR_TOKEN not set"**

**Çözüm:**
```bash
# GitHub Settings'e git
Settings → Secrets and variables → Actions
# SONAR_TOKEN mevcud mu kontrol et
```

---

### **Sorun 2: "Coverage not found"**

**Çözüm:**
```bash
# Lokal coverage oluştur
npm test -- --coverage

# lcov.info dosyası var mı kontrol et
ls -la coverage/lcov.info
```

---

### **Sorun 3: "Quality Gate Failed"**

Coverage < %80 veya kritik bug var demek.

**Çözüm:**
1. SonarCloud Dashboard → Coverage metrikleri kontrol
2. Test sayısı arttır
3. Bugları düzelt

---

### **Sorun 4: "Organization key required"**

**Çözüm:**
```properties
# sonar-project.properties'e ekle
sonar.organization=YOUR-ORG-KEY
sonar.projectKey=YOUR-ORG-KEY_project-template
```

---

## 📊 Quality Gate Hedefleri

SonarCloud'daki varsayılan Quality Gate:

| Metrik              |         Hedef          | Kat  |
| :------------------ | :--------------------: | :--- |
| **Coverage**        |          ≥80%          | A    |
| **Duplications**    |          <3%           | A    |
| **Bugs**            |           0            | A    |
| **Vulnerabilities** |           0            | A    |
| **Code Smells**     | A (SonarQube derecesi) | A    |

---

## 🔐 Güvenlik En İyi Uygulamaları

✅ **Yapmalılar:**
- Token'ları GitHub Secrets'a sakla
- Token'a expiration tarihi koy
- Düzenli olarak token'ı rotat et
- Organization key herkese açık olabilir

❌ **Yapmamalılar:**
- Token'ı Hardcoded koda yapıştırma
- Token'ı Commit'te saklamak
- Token'ı Slack/Email'le paylaşmak

---

## 📚 Ek Kaynaklar

- [SonarCloud Resmi Doku](https://docs.sonarcloud.io/)
- [SonarCloud GitHub Actions](https://github.com/marketplace/actions/sonarcloud-scan)
- [Jest Coverage Reports](https://jestjs.io/docs/configuration#coveragereporters-arraystring)

---

## ✅ Kontrol Listesi

Kurulum tamamlanmış mı?

- [ ] SonarCloud hesabı oluşturuldu
- [ ] Organization oluşturuldu/seçildi
- [ ] Token oluşturuldu
- [ ] `SONAR_TOKEN` GitHub Secrets'a eklendi
- [ ] `SONAR_ORGANIZATION` GitHub Secrets'a eklendi
- [ ] `sonar-project.properties` güncellendd
- [ ] `package.json` Jest konfigürasyonu var
- [ ] `.github/workflows/pipeline.yml` SonarCloud ready
- [ ] İlk push yapıldı
- [ ] GitHub Actions başarıyla çalıştı
- [ ] SonarCloud Dashboard'da proje görünüyor

---

**Kurulum Tamamlandı! 🎉**

Sorunlar için: proje@example.com
