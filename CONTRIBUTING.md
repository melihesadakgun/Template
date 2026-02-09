# Katkıda Bulunma Rehberi (CONTRIBUTING.md)

Projeye katkıda bulunmak için teşekkürler! Bu rehber, kod kalitesi ve süreç uyumunu garantilemek amacıyla hazırlanmıştır.

---

## 📋 Başlamadan Önce

1. **Standartları Oku**
   - [GEMINI.md](GEMINI.md) - Küresel kurallar
   - [globalworkflows.md](globalworkflows.md) - İş akışı
   - [docs/yonetim/RACI_MATRISI.md](docs/yonetim/RACI_MATRISI.md) - Roller

2. **Geliştirme Ortamını Kur**
   ```bash
   # VS Code eklentileri yükle
   # - SonarLint
   # - Error Lens
   # - Coverage Gutters
   # - GitLens
   # - Markdown All in One

   # Dependencies
   npm install
   ```

---

## 🔄 İş Akışı

### 1. Branch Oluştur
```bash
# Yeni branch oluştur (main veya develop'tan)
git checkout -b feature/ozellik-adi
# veya
git checkout -b bugfix/hata-adi
# veya
git checkout -b refactor/teknik-borc-adi
```

Branch isimleri açıklayıcı olmalı:
- `feature/user-authentication` ✅
- `bugfix/login-timeout` ✅
- `refactor/api-response-handler` ✅
- `f1` ❌

### 2. Kod Yaz ve Test Et

**Test Yazım Kuralları (ISO 29119):**

```typescript
// ✅ İyi Test Örneği
describe('Kullanıcı Kimlik Doğrulaması', () => {
  test('Geçerli bilgilerle oturum açabilme', async () => {
    // Hazırlık (Arrange)
    const mockUser = { email: 'test@example.com', password: 'Pass123!' };

    // Çalıştırma (Act)
    const result = await authenticate(mockUser);

    // Doğrulama (Assert)
    expect(result.success).toBe(true);
    expect(result.token).toBeDefined();
  });

  test('Geçersiz şifreyle başarısız olmalı', async () => {
    const mockUser = { email: 'test@example.com', password: 'wrong' };
    const result = await authenticate(mockUser);
    expect(result.success).toBe(false);
  });
});
```

**Coverage Hedefi:**
- Minimum %80 line coverage ✅
- Critical path %100 ✅
- SonarLint hatasız ✅

### 3. Lokal Testler Çalıştır

```bash
# Birim testler
npm test

# Coverage raporu
npm run coverage

# Linting kontrol
npm run lint

# Format kontrol
npm run prettier:check

# SonarLint analizi (VS Code'da)
# Ctrl+Shift+P > SonarLint: Analyze Code
```

### 4. Kod İncele (Self-Review)

Gönder repres push etmeden:
- [ ] Kod okunabilir ve tutarlı
- [ ] Testler yazılmış ve yeşil
- [ ] Coverage ≥80%
- [ ] Türkçe yorum var
- [ ] Gereksiz console.log yok
- [ ] API anahtarları commit'te yok
- [ ] Merge conflict yok

### 5. Pull Request Açabilmek

**PR Başlığı Format:**
```
[TYPE] Açıklayıcı başlık

TYPE:
- FEATURE: Yeni özellik
- BUGFIX: Hata düzeltmesi
- REFACTOR: Kod iyileştirmesi
- DOCS: Dokümantasyon
- TEST: Test ekleme/iyileştirme
- PERF: Performans

Örnek: [FEATURE] Kullanıcı kimlik doğrulama sistemi
```

**PR Açıklaması İçermesi Gereken:**

```markdown
## 📝 Açıklama
[Ne değişti? Neden değişti?]

## 🎯 İzlenebilirlik
- Jira: [PROJ-123](link)
- Gereksinim: REQ-001
- Test: TC-001, TC-002

## ✅ Kontrol Listesi
- [x] Testler yazıldı
- [x] Coverage ≥80%
- [x] SonarLint kontrol edildi
- [x] Türkçe yorum eklendi
- [x] Dokümantasyon güncellendi

## 📸 Ekran Görüntüsü/Demo (varsa)
[Yeni UI özelliği ise screenshot]
```

---

## 👀 Kod İnceleme (Code Review)

### İncelemeci Tarafından

**Kontrol Listesi:**
- [ ] Gereksinim dokunmuş
- [ ] Test coverage ≥80%
- [ ] Security uyumu (SQL Injection, XSS, vs)
- [ ] Performans düşmedi
- [ ] Türkçe yorum/dokümantasyon
- [ ] SonarQube A derecesi

[Detaylı kontrol listesi: docs/sablonlar/KOD_INCELEME_CHECKLIST_SABLONU.md](docs/sablonlar/KOD_INCELEME_CHECKLIST_SABLONU.md)

### Yorum Türleri

```
💬 REQUEST_CHANGES: Zorunlu değişiklik
- [ ] Güvenlik açığı var, düzeltilmeli
- [ ] Test eksik, ≥80% coverage lazım

💭 COMMENT: İsteğe bağlı öneriler
- [ ] Bu şekilde yapabilir misiniz?
- [ ] Alternatif yaklaşım düşünebilir

👍 APPROVE: Hazır merge
- Code review tamamlandı
- Tüm kritik noktalar geçildi
```

---

## 🚀 Merge ve Dağıtım

### Merge Şartları (Gate 3 - Kod Kalitesi)

Tüm öğeler ✅ olmalı:
- [ ] CI Pipeline geçti (linting, testing, analysis)
- [ ] Code coverage ≥80%
- [ ] SonarQube A derecesi
- [ ] 0 kritik güvenlik bulgusu
- [ ] En az 1 onaylı code review
- [ ] Merge conflict yok

### Commit Mesajı Standardı

```bash
git commit -m "[TYPE] Açıklayıcı başlık (50 char max)

Detaylı açıklama:
- Ne değişti
- Neden değişti
- Etkilenen bileşenler

JIRA: PROJ-123
Refs: #PR-456
"
```

**Örnekler:**

```
[FEATURE] JWT bazlı kimlik doğrulama sistemi

- Login/logout fonksiyonları eklendi
- Token refresh mekanizması yapıldı
- Hassas şifreler bcrypt ile hash'lendi
- 100+ birim test yazıldı (88% coverage)

JIRA: AUTH-001
Refs: #123

---

[BUGFIX] Login sayfasında SQL injection açığı

Açık: Email alanında SQL injection mümkündü
Çözüm: Parametrized query kullanıldı
Etkilenen: Backend auth service

JIRA: SEC-045
```

---

## 📊 Kalite Kaliteleri

### Gate 1: Gereksinim Onayı ✅
- Gereksinimler belgelenmiş
- Kabul kriterleri tanımlı
- İzlenebilirlik başlamış

### Gate 2: Tasarım Onayı ✅
- Tasarım dokümanı onay
- Mimarı sorunlar yok
- Güvenlik gözden geçirilmiş

### Gate 3: Kod Kalitesi (KRİTİK) ✅
- **Coverage ≥80%** ← SEN SORUMLU
- **SonarQube A derecesi** ← SEN SORUMLU
- **0 kritik güvenlik** ← SEN SORUMLU
- Code review geçti
- CI Pipeline yeşil

### Gate 4: Test Onayı ✅
- QA tarafından test edilmiş
- Kabul kriterleri karşılandı
- Performance hedefleri tutturuldu

---

## 🛡️ Güvenlik Kontrol Listesi

Commit etmeden kontrol et:

- [ ] **Şifreler / API Keys:** Hiç kodda hardcoded değil
- [ ] **Girdilerin Validasyonu:** Tüm inputs validated
- [ ] **SQL Injection:** Parametrized queries kullanıldı
- [ ] **XSS Koruması:** HTML encoded sonuçlar
- [ ] **Hassas Loglar:** Credit card, SSN mask'lı
- [ ] **Error Mesajları:** Teknik detay exposure yok
- [ ] **CORS:** Uygun origin'ler tanımlanmış

---

## 📚 Kaynaklar

- [README.md](README.md) - Proje genel bilgisi
- [docs/yonetim/ISO_UYUM_VE_UYGULAMA.md](docs/yonetim/ISO_UYUM_VE_UYGULAMA.md) - Standartlar
- [docs/test/BIRIM_TEST_STANDARTLARI.md](docs/test/BIRIM_TEST_STANDARTLARI.md) - Test rehberi
- [docs/sablonlar/](docs/sablonlar/) - Dokümantasyon şablonları

---

## ❓ Sık Sorular

**S: Commit attığımda ne oluyor?**
A: Otomatik olarak linting, testler ve SonarQube analizi çalışıyor. Başarısızsa, çöz ve tekrar push et.

**S: Test yazmak zorunda mıyım?**
A: Evet! Coverage ≥80% zorunlu. Birim test şablonu için: [docs/sablonlar/TEST_PLANI_SABLONU.md](docs/sablonlar/TEST_PLANI_SABLONU.md)

**S: PR'ye kaç kişi onay vermeli?**
A: Minimum 1 bağımsız geliştirici. Tech Lead opsiyonel ama önerilir.

**S: Merge için ne kadar beklenir?**
A: Standart: 24 saat. Kritik: Hemen. Hafta sonunda yavaş olabilir.

---

## 💡 En İyi Uygulamalar

1. **Sık Commit:** Hergün en az bir commit, mantıksal birimler
2. **Açık PR Açıklaması:** "LGTM" veya "OK" yazma, neden onaylandığını açıkla
3. **Conversation:** Yorum tartışmasında kibar ve yapıcı olan
4. **Documentation First:** Kod sürü şekil doküman şekil yanlış
5. **Security Mindset:** Her zaman güvenliği düşün

---

**Son Güncelleme:** 09/02/2026
**Yönetici:** [Proje Sahibi]
**Sorular:** proje@example.com
