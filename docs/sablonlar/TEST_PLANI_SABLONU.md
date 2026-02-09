# Test Planı Şablonu (TP - Test Plan)

**Sürüm:** 1.0
**Tarih:** [.__/__/2026]
**Yazılı:** [QA Koordinatörü]
**Onaylı:** [QA Lead / SA]

---

## 1. Test Planı Özeti

### 1.1 Amaç
[Test stratejisinin genel hedefi nedir?]

### 1.2 Kapsam
[Hangi bileşenler test edilecek? Dışında neler?]

### 1.3 Standartlar
- ISO 29119 (Test Stratejileri)
- ISO/IEC 5055 (İç Kod Kalitesi)
- ISO/IEC 12207 (Yaşam Döngüsü)

---

## 2. Test Stratejisi

### 2.1 Risk Tabanlı Test Yaklaşımı

| Risk ID   | Risk Açıklaması                          | Olasılık |  Etki  | Risk Skoru | Test Yoğunluğu |
| :-------- | :--------------------------------------- | :------: | :----: | :--------: | :------------- |
| **R-001** | Kritik hata - Sistem kilitlenme          |  Yüksek  | Kritik |     9      | Yoğun          |
| **R-002** | Güvenlik açığı - Veri sızıntısı          |   Orta   | Kritik |     8      | Yoğun          |
| **R-003** | Entegrasyon hatası - API kompatibilitesi |   Orta   | Yüksek |     6      | Normal         |
| **R-004** | Performans problemleri                   |  Düşük   |  Orta  |     4      | Hafif          |

### 2.2 Test Piramidi

```
        ⊲ E2E Tests (5%)
       ╱  ╲
      ╱    ╲  Integration Tests (30%)
     ╱      ╲
    ╱        ╲ Unit Tests (65%)
   ╱__________╲
```

**Target:** 65% Unit, 30% Integration, 5% E2E

---

## 3. Test Türleri ve Kapsamı

### 3.1 Birim Testler (Unit Tests) - ISO 29119

| Test Türü              | Kapsam         | Coverage Target | Tool         |
| :--------------------- | :------------- | :-------------: | :----------- |
| **Fonksiyon Testleri** | Tüm modüller   |      ≥80%       | Jest / Mocha |
| **Edge Case Testleri** | Sınır değerler |      ≥80%       | Jest         |
| **Error Handling**     | Hata durumları |      ≥80%       | Jest         |

**Örnek Test Case Şablonu:**
```javascript
describe('Module: Kimlik Doğrulama', () => {

  test('Geçerli bilgilerle kullanıcı oturum açabilme', () => {
    // Hazırlık (Arrange)
    const user = { email: 'test@example.com', password: 'Pass123' };

    // Çalıştırma (Act)
    const result = authenticate(user);

    // Doğrulama (Assert)
    expect(result.isSuccess).toBe(true);
    expect(result.token).toBeDefined();
  });

  test('Geçersiz şifreyle oturum açma başarısız olmalı', () => {
    const user = { email: 'test@example.com', password: 'WrongPass' };
    const result = authenticate(user);
    expect(result.isSuccess).toBe(false);
    expect(result.error).toBe('INVALID_CREDENTIALS');
  });
});
```

### 3.2 Entegrasyon Testleri (Integration Tests)

| Senaryosun                        | Bileşenler           | Beklenen Sonuç      | Durum |
| :-------------------------------- | :------------------- | :------------------ | :---- |
| **Kimlik Doğrulama + Veritabanı** | Auth Service + DB    | Token oluşturulmalı | ✅     |
| **API + Harici Servis**           | REST API + 3rd Party | Yanıt alınmalı      | ⏳     |
| **Cache + Database**              | Redis + PostgreSQL   | Data tutarlılığı    | ⏳     |

### 3.3 Uçtan Uca Testler (E2E Tests)

```
Senaryo: Kullanıcı Kaydı ve Giriş İşlemi

Adım 1: Kullanıcı hesap oluştur
  → POST /api/auth/register
  → Beklenen: 201 Created

Adım 2: E-mail onay linkini aç
  → GET /api/auth/verify?token=xxx
  → Beklenen: 200 OK, "E-mail onaylandı"

Adım 3: Oturum aç
  → POST /api/auth/login
  → Beklenen: 200 OK, JWT token döndür

Adım 4: Korumalı kaynağa eriş
  → GET /api/user/profile
  → Header: Authorization: Bearer [token]
  → Beklenen: 200 OK, kullanıcı verileri
```

### 3.4 Güvenlik Testleri (Security Testing) - ISO 27001

| Test                                  | Yöntem              | Amaç                 |
| :------------------------------------ | :------------------ | :------------------- |
| **SQL Injection**                     | Kötü amaçlı input   | Veri tabanı koruması |
| **XSS (Cross-Site Scripting)**        | Script injection    | DOM koruması         |
| **CSRF (Cross-Site Request Forgery)** | CSRF token kontrolü | İstek doğrulama      |
| **Kimlik Doğrulama Bypass**           | Token manipülasyonu | Yetkilendirme        |
| **Veri Şifreleme**                    | TLS/SSL kontrolü    | Transit güvenliği    |

### 3.5 Performans Testleri (Load Testing)

```
Hedefler:
- Yanıt Süresi: < 200ms (p95)
- Throughput: 1000+ req/sn
- Eş Zamanlı Kullanıcı: 10.000+
- CPU Kullanımı: < 80%
- Bellek: < 512 MB

Tool: JMeter / Gatling / K6
```

---

## 4. Test Veri Stratejisi

### 4.1 Test Verisi Hazırlama

- **Ürün Ortamı (Prod):** Gerçek veriler asla kopyalanmayacak
- **Test/Staging:** Anonimleştirilmiş, minimal veri seti
- **Geliştirme:** Mock veri veya fabrikalar kullanılacak

### 4.2 Test Veri Saklama

| Veri Türü              | Saklama Süresi | Maskeleme   |
| :--------------------- | :------------- | :---------- |
| Kişisel Bilgiler (PII) | 7 gün          | Evet (GDPR) |
| Transaction Logs       | 30 gün         | Hayır       |
| Sensitif Şifreler      | 1 gün          | Evet        |

---

## 5. Test Ortamı Kurulumu

### 5.1 Ortam Konfigürasyonu

```yaml
Development:
  DB: SQLite (local)
  Cache: Memory
  External APIs: Mocked

Staging:
  DB: PostgreSQL (test instance)
  Cache: Redis (test instance)
  External APIs: Real (with test account)

Production:
  DB: PostgreSQL (prod)
  Cache: Redis Cluster
  External APIs: Real
```

### 5.2 CI/CD Pipeline Test Etaplaması

```
Push to Branch
     ↓
[1] Lint Check (2 min)
     ↓
[2] Unit Tests (5 min)
     ↓
[3] SonarQube Analysis (3 min)
     ↓
[4] Integration Tests (10 min)
     ↓
[5] Security Scan (5 min)
     ↓
PR Ready (Onay için)
```

---

## 6. Kabul Kriterleri ve Coverage Hedefleri

| Metrik               |     Hedef     | Zorlayıcı     |
| :------------------- | :-----------: | :------------ |
| Unit Test Coverage   |     ≥80%      | Evet (Gate 3) |
| Critical Bug Density |       0       | Evet          |
| Security Findings    |  0 Critical   | Evet          |
| Code Quality         | A (SonarQube) | Evet (Gate 3) |
| API Response Time    | < 200ms (p95) | Evet (NFR)    |

---

## 7. Test Defekt Yönetimi

### 7.1 Defekt Sınıflandırması

| Önem       | Açıklama                | SLA     | Örnek                      |
| :--------- | :---------------------- | :------ | :------------------------- |
| **Kritik** | Sistem kilitlenir       | 4 saat  | Veri kaybı, güvenlik açığı |
| **Yüksek** | Ana fonksiyon çalışmaz  | 24 saat | Login çalışmama            |
| **Orta**   | Kısmi işlevsellik kaybı | 3 gün   | Bazı filtrelerde hata      |
| **Düşük**  | Küçük sorunlar          | 1 hafta | Yazım hatası               |

### 7.2 Hata İzleme

```
Defekt Raporu Şablonu:
- Defect ID: BUG-2026-001
- Başlık: [Kısa açıklama]
- Şiddet: Kritik / Yüksek / Orta / Düşük
- Durum: Açık / İnceleniyor / Düzeltildi / Doğrulandı / Kapalı
- Sahibi: [Geliştirici Adı]
- Oluşturulma: 09/02/2026
- Hedef Kapanış: [Tarih]
```

---

## 8. Test Raporlama

### 8.1 Haftalık Test Metrik Raporu

```
Hafta: 09-20/02/2026

✅ Unit Tests:        45/50 passed (90%)
✅ Integration Tests: 12/15 passed (80%)
⚠️ E2E Tests:         3/5 passed (60%)
✅ Code Coverage:     82% (Target: 80%)
✅ Security Scan:     0 Critical findings

Açık Defekt: 2 Yüksek, 5 Orta
```

### 8.2 Sürüm Kapanış Kriteri

Sürüm bu şartlar karşılandığında açılır:
- [ ] Tüm unit testler geçti (100%)
- [ ] Coverage ≥%80
- [ ] SonarQube A derecesi
- [ ] 0 kritik defekt
- [ ] Security scan temiz
- [ ] Performans hedefleri karşılandı

---

## 9. Risk Yönetimi

### 9.1 Test Riskları

| Risk                  | Olasılık |  Etki  | Hafifletme            |
| :-------------------- | :------: | :----: | :-------------------- |
| Yetersiz test kapsamı |  Yüksek  | Kritik | Coverage tool zorlama |
| Test ortamı bozulması |   Orta   | Yüksek | Otomatik reset        |
| Veri koruma ihlali    |  Düşük   | Kritik | Anonimleştirme        |

---

## 10. Test Ekibi ve Sorumluluklar

| Rol             | Kişi | Sorumluluk                |
| :-------------- | :--- | :------------------------ |
| **QA Lead**     | [Ad] | Test planı, raporlama     |
| **QA Mühendis** | [Ad] | Testleri yazma/çalıştırma |
| **Dev Lead**    | [Ad] | Unit test otomasyon       |
| **Security QA** | [Ad] | Güvenlik testleri         |

---

## 11. Değişiklik Geçmişi

| Sürüm | Tarih      | Değişiklik     | Yazılı  |
| :---- | :--------- | :------------- | :------ |
| 1.0   | 09/02/2026 | İlk test planı | [QA Ad] |
|       |            |                |         |

---

**Onay Tablosu (RACI Uyumu)**

| Rol                   | İmza              | Tarih     |
| :-------------------- | :---------------- | :-------- |
| QA Lead               | _________________ | _________ |
| Çözüm Mimarı (SA)     | _________________ | _________ |
| Proje Yöneticisi (PM) | _________________ | _________ |
