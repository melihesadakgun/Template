# Tasarım Dokümanı Şablonu (DD - Design Document)

**Sürüm:** 1.0
**Tarih:** [.__/__/2026]
**Yazılı:** [Mimarın Adı]
**Onaylı:** [SA - Çözüm Mimarı]

---

## 1. Tasarım Özeti

### 1.1 Amaç
[Bu tasarımın hedefi nedir? Ne sorunu çözmek için var?]

### 1.2 Kapsam
[Hangi modüller, servisler tasarlanıyor? Dış sistemler nasıl entegre olacak?]

### 1.3 Tasarım İlkeleri
- **Modülerlik:** Bağımsız, yeniden kullanılabilir bileşenler
- **İzolasyon:** Dış bağımlılıkları minimize etme
- **Test Edilebilirlik:** Her modül birim testine uygun
- **Performans:** [Belirtilen hedefler]
- **Güvenlik:** ISO 27001 hassas veri koruma

---

## 2. Sistem Mimarisi

### 2.1 Mimari Diyagram
```
[ASCII diyagram veya referans]

┌─────────────────────────────────────────┐
│          Kullanıcı Arayüzü (UI)         │
├─────────────────────────────────────────┤
│      API Gateway / Load Balancer        │
├─────────────────────────────────────────┤
│    Core Business Logic / Services       │
├─────────────────────────────────────────┤
│   Database / Cache / External APIs      │
└─────────────────────────────────────────┘
```

### 2.2 Bileşen Açıklaması

| Bileşen  | Sorumluluk | Teknoloji | Durum |
| :------- | :--------- | :-------- | :---- |
| **ModA** | [Amacı]    | Node.js   | ✅     |
| **ModB** | [Amacı]    | Python    | ⏳     |
| **ModC** | [Amacı]    | Go        | 📋     |

---

## 3. Veri Modeli (Data Model)

### 3.1 ERD (Entity-Relationship Diagram)
```sql
-- Tablo Yapıları
CREATE TABLE users (
  id UUID PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  -- Hassas veriler şifreli tutulmalı (ISO 27001)
  password_hash VARCHAR(255) NOT NULL
);

CREATE TABLE resources (
  id UUID PRIMARY KEY,
  user_id UUID FOREIGN KEY REFERENCES users(id),
  title VARCHAR(500) NOT NULL,
  content TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### 3.2 Veri Güvenliği
- [ ] Hassas veriler AES-256 ile şifreli
- [ ] PII (Kişisel Tanımlayıcı Bilgiler) maskeli
- [ ] Erişim logu kaydedildi
- [ ] GDPR/KVKK uyumlu silme mekanizması

---

## 4. API Tasarımı (RESTful / GraphQL)

### 4.1 Endpoints

**POST /api/v1/resources**
```json
İstek:
{
  "title": "Kaynak Başlığı",
  "description": "Açıklama"
}

Yanıt (201 Created):
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "title": "Kaynak Başlığı",
  "created_at": "2026-02-09T10:30:00Z"
}

Hata (400 Bad Request):
{
  "error": "Başlık boş olamaz",
  "code": "VALIDATION_ERROR"
}
```

**GET /api/v1/resources/{id}**
- Yanıt: 200 OK - Kaynak detayları
- Hata: 404 Not Found

---

## 5. Güvenlik Tasarımı (ISO 27001)

### 5.1 Kimlik Doğrulama (Authentication)
- **Yöntem:** JWT (JSON Web Token) + OAuth2.0
- **Token Süresi:** 1 saat
- **Refresh Token:** 30 gün
- **Şifreleme:** RS256 (RSA + SHA256)

### 5.2 Yetkilendirme (Authorization)
- **Model:** RBAC (Role-Based Access Control)
- **Roller:** Admin, Editor, Viewer
- **Kontrol:** Her endpoint'te yetki doğrulaması

### 5.3 Veri Koruma
- [ ] Transit (Aktarımda): HTTPS/TLS 1.3+
- [ ] Rest (Depolamada): AES-256-GCM
- [ ] In-Memory: Minimal tutma süresi
- [ ] Test Ortamı: Anonimleştirilmiş veriler

---

## 6. Performans ve Ölçeklenebilirlik

| Metrik                   | Hedef         | Ölçüm Yöntemi        |
| :----------------------- | :------------ | :------------------- |
| **Yanıt Süresi**         | < 200ms (p95) | APM Tool (New Relic) |
| **Throughput**           | 1000+ req/s   | Load Test            |
| **Eş Zamanlı Kullanıcı** | 10.000+       | Simülasyon           |
| **Bellek Kullanımı**     | < 512 MB/pod  | Container Metrics    |

---

## 7. Hata Yönetimi ve Resilience

```
Hata Stratejisi:
- Retry: Exponential Backoff (1s, 2s, 4s, 8s)
- Circuit Breaker: Başarısızlık oranı > 50% ⟶ Aç
- Fallback: Varsayılan yanıt / Cache
- Timeout: 30 saniye maksimum
```

---

## 8. Deployment Mimarisi

### 8.1 Ortamlar
```
Development (dev) ⟶ Staging (stg) ⟶ Production (prod)
     ↓                   ↓                   ↓
  Local              Docker/K8s         K8s Cluster
```

### 8.2 Container Konfigürasyonu
- **Image:** node:18-alpine
- **Port:** 8080
- **Healthcheck:** /health (5s interval)
- **Resource Limits:**
  - CPU: 500m
  - Bellek: 512Mi

---

## 9. İzlenebilirlik ve Logging

- **Seviyeler:** INFO, WARN, ERROR, DEBUG
- **Format:** JSON + Türkçe mesajlar
- **Örnek:**
```json
{
  "timestamp": "2026-02-09T10:30:45.123Z",
  "level": "ERROR",
  "service": "auth-service",
  "message": "Kimlik doğrulama başarısız",
  "userId": "550e8400...",
  "errorCode": "AUTH_001",
  "stackTrace": "..."
}
```

---

## 10. Test Edilebilirlik

- [ ] Dependency Injection kullanıldı (Mock'lar kolay)
- [ ] External API'lar soyutlanmış
- [ ] Birim test hedefi: ≥%80 coverage
- [ ] Integration test gereği: [Belirtilen kritik flow]

---

## 11. İzlenebilirlik Matrisi (Design -> Code)

| Gereksinim | Tasarım Modülü | Kod Dosyası        | Test |
| :--------- | :------------- | :----------------- | :--- |
| FR-001     | Module A       | src/modules/a.ts   | ✅    |
| NFR-001    | Cache Layer    | src/cache/redis.ts | ✅    |

---

## 12. Değişiklik Geçmişi

| Sürüm | Tarih      | Değişiklik  | Yazılı      |
| :---- | :--------- | :---------- | :---------- |
| 1.0   | 09/02/2026 | İlk tasarım | [Mimar Adı] |
|       |            |             |             |

---

**Onay Tablosu (RACI Uyumu)**

| Rol                     | İmza              | Tarih     |
| :---------------------- | :---------------- | :-------- |
| Çözüm Mimarı (SA)       | _________________ | _________ |
| Güvenlik Sorumlusu (SO) | _________________ | _________ |
| Proje Yöneticisi (PM)   | _________________ | _________ |
