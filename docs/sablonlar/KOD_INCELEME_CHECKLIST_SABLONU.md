# Kod İnceleme Checklist Şablonu (Code Review)

**Başladı:** [.__/__/2026 - Saat]
**Bitleyen:** [İnceleme Yapan Geliştirici]
**PR/Branch:** [#PR-123 veya branch-adı]
**Developer:** [Kod Yazan Geliştirici]

---

## 1. Genel Bilgiler

- **Değişiklik Türü:**
  - [ ] Yeni Özellik (Feature)
  - [ ] Hata Düzeltmesi (Bug Fix)
  - [ ] Refactor / Teknik Borç
  - [ ] Performans İyileştirmesi
  - [ ] Dokümantasyon

- **Kapsam:** [Etkilenen dosya sayısı, LOC (Lines of Code)]

- **İzlenebilirlik:**
  - [ ] Requirement/User Story bağlı
  - [ ] Test Case bağlı
  - [ ] Jira/Azure Board referansı: [URL]

---

## 2. Fonksiyonel Doğrulama (Functional Verification)

### 2.1 Gereksinimler Uyumu

- [ ] Kod, tasarım dokümanıyla uyumlu
- [ ] Tüm gereksinimler (FR) uygulanmış
- [ ] Maneviyat gereksinimler (NFR) karşılanmış
- [ ] Hiç test edilemeyen özellik yok

### 2.2 Mantık ve Akış

- [ ] Algoritma doğru ve verimli
- [ ] Tüm kodlar ve dallar açık mı?
- [ ] Sonsuz döngü (infinite loop) yok mu?
- [ ] İş kuralları doğru uygulanmış mı?
- [ ] Error handling yapılmış mı?

**Açıklama (varsa hata):**
```
[Problemli kodun örneği]
[Neden sorunlu olduğu]
[Önerilen çözüm]
```

---

## 3. Kod Kalitesi Kontrol (Code Quality - ISO 5055)

### 3.1 İsimlendirme ve Okunabilirlik

- [ ] Değişken isimleri anlamlı ve Türkçe açıklama
- [ ] Fonksiyon isimleri ne yaptığını açıkça belirtiyor
- [ ] Sınıf/modül isimleri tutarlı (PascalCase/camelCase)
- [ ] Magic number/string yok (Sabitler tanımlı)
- [ ] Uzun fonksiyonlar (>50 LOC) parçalandı mı?

**Örnek (Uygun):**
```typescript
// ✅ İyi
function kullaniciDogrulaButunler(email: string, sifre: string): boolean {
  // Email formatı kontrol edilir
  // Şifre güvenlik kriterleri kontrol edilir
}

// ❌ Uygun değil
function kd(e: string, s: string): boolean {
  // Anlaşılmaz isimler
}
```

### 3.2 Yorum ve Dokümantasyon

- [ ] Karmaşık mantık için yorum vardır (Türkçe)
- [ ] Fonksiyon başında JSDoc/TSDoc dokumentasyonu
- [ ] TODO/FIXME açıklamalı ve takvim referansı
- [ ] Eski/çıkartılmış kod silinmiş (comment değil)

**Örnek (Uygun):**
```typescript
/**
 * Kullanıcı e-mail adresini doğrular.
 * @param email - E-mail adresi
 * @returns true eğer geçerli e-mail, false değilse
 * @throws EmailValidationError - E-mail formatı hatalıysa
 * @example
 * dogrulaEmail('test@example.com') // true
 */
function dogrulaEmail(email: string): boolean {
  // RFC 5322 standartına göre e-mail doğrulanır
  const pattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return pattern.test(email);
}
```

### 3.3 Kod Kompleksitesi (Cyclomatic Complexity)

- [ ] Fonksiyon complexity < 10 (SonarQube hedef)
- [ ] Nested döngü başka yönteme refactor edildi
- [ ] If/else zinciri switch/pattern matching'e dönüştürüldü

### 3.4 Duplikasyon Kontrolü (DRY Prensibi)

- [ ] Benzer kod parçaları refactor edildi
- [ ] Ortak mantık reusable fonksiyona taşındı
- [ ] Tekrarlayan değerler sabitler/konfigürasyon

---

## 4. Test Coverage Kontrolü (ISO 29119)

### 4.1 Birim Testler

- [ ] Yeni kod için birim test yazılmış
- [ ] Test adı senaryoyu açıkça belirtiyor
- [ ] AAA Deseni: Arrange → Act → Assert
- [ ] Edge case'ler test edilmiş (null, empty, invalid)
- [ ] Hata durumları test edilmiş (try-catch blokları)
- [ ] Mock/Stub'lar dış bağımlılıklar için yazılmış

**Coverage Hedefi:**
- [ ] ≥80% line coverage
- [ ] ≥80% branch coverage
- [ ] Critical path %100

**Test Örneği:**
```typescript
describe('Kullanıcı Doğrulaması', () => {

  test('Geçerli email ve şifreyle başarılı olmalı', () => {
    // Hazırlık
    const user = { email: 'test@example.com', password: 'Pass123!' };

    // Çalıştırma
    const result = dogrulaKullanici(user);

    // Doğrulama
    expect(result.basarili).toBe(true);
    expect(result.token).toBeDefined();
  });

  test('Boş email hata döndürmeli', () => {
    const user = { email: '', password: 'Pass123!' };
    expect(() => dogrulaKullanici(user)).toThrow('Email boş olamaz');
  });

  test('Zayıf şifre reddedilmeli', () => {
    const user = { email: 'test@example.com', password: '123' };
    const result = dogrulaKullanici(user);
    expect(result.basarili).toBe(false);
    expect(result.hata).toContain('Şifre en az 8 karakter');
  });
});
```

### 4.2 Entegrasyon Testleri

- [ ] Modüller arası entegrasyon test edilmiş
- [ ] API endpoints'e entegrasyon test
- [ ] Veritabanı işlemleri entegrasyon test

---

## 5. Güvenlik Kontrolü (ISO 27001)

### 5.1 Girdilerin Validasyonu

- [ ] Tüm kullanıcı girdileri doğrulı (input validation)
- [ ] SQL Injection koruması var (parametrized queries)
- [ ] XSS koruması var (HTML encoding)
- [ ] Path Traversal koruması var

**Uygun Örnek:**
```typescript
// ❌ Uygun değil - SQL Injection riski
const query = `SELECT * FROM users WHERE email = '${email}'`;

// ✅ Uygun - Parametrized query
const query = 'SELECT * FROM users WHERE email = ?';
db.query(query, [email]);
```

### 5.2 Hassas Veri Koruması

- [ ] Şifreler hash'lenmiş (bcrypt minimum)
- [ ] API anahtarları environment'tan okunuyor (hardcoded yok)
- [ ] Hassas loglar mask'lenmiş (credit card, SSN)
- [ ] Veri transit'te şifreli (HTTPS)
- [ ] Veri depo'da şifreli (AES-256 minimum)

### 5.3 Yetkilendirme (Authorization)

- [ ] Her endpoint'te yetki kontrolü
- [ ] Kullanıcı sadece kendi verilerine erişebiliyor
- [ ] Admin fonksiyonları korumalı
- [ ] CORS ayarları uygun

---

## 6. Performans Kontrolü

### 6.1 Algoritmik Verimlilik

- [ ] n² ve üzeri complexity refactor edildi
- [ ] Veritabanı N+1 sorgusu yok
- [ ] Gereksiz döngüler optimize edildi
- [ ] Cache mekanizması var ise uygun

**Uygun Örnek:**
```typescript
// ❌ Uygun değil - N+1 sorgusu
for (const userId of userIds) {
  const user = db.query('SELECT * FROM users WHERE id = ?', [userId]);
  // Process user
}

// ✅ Uygun - Single batch query
const users = db.query('SELECT * FROM users WHERE id IN (?)', [userIds]);
```

### 6.2 Bellek Yönetimi

- [ ] Bellek sızıntısı yok (event listeners, listeners)
- [ ] Large arrays memory-efficient iterate
- [ ] Circular references temizlendi
- [ ] Unused variables release edildi

---

## 7. Error Handling

- [ ] Try-catch blokları uygun yerler
- [ ] Custom error sınıfları kullanılmış
- [ ] Error mesajları Türkçe ve açıklayıcı
- [ ] Hata stack'i prodükte gelmez
- [ ] Graceful degradation yapılmış
- [ ] Retry mekanizması nerede gerek

**Örnek:**
```typescript
try {
  const user = await fetchUser(userId);
} catch (error) {
  // ❌ Uygun değil
  console.log('Hata!');

  // ✅ Uygun
  logger.error('Kullanıcı alınamadı', {
    userId,
    error: error.message,
    timestamp: new Date().toISOString(),
  });
  throw new UserNotFoundError(userId);
}
```

---

## 8. Bağımlılık Yönetimi

- [ ] Yeni bağımlılıklar project lead'e haber verildi
- [ ] Bağımlılık versiyonları package-lock.json'a kilitli
- [ ] Deprecated paketler kullanılmadı
- [ ] Security vulnerability yok (npm audit)
- [ ] Ağır bağımlılıklar gerekçeli

---

## 9. Git ve Commit Uyumu

- [ ] Commit mesajı açıklayıcı (Türkçe veya İngilizce)
- [ ] Commit'ler mantıksal birimler
- [ ] Merge Conflict'ler çözülmüş
- [ ] Rebase history temiz (fixup commit'ler squash edildi)
- [ ] Branch isimleri açıklayıcı (feature/user-auth gibi)

**Commit Mesajı Format:**
```
[TYPE] Açıklayıcı başlık (50 karakter max)

Detaylı açıklama (72 karakter per line):
- Ne değişti
- Neden değişti
- Etkilenen bileşenler

Refs: #123 (Jira/GitHub issue)
```

---

## 10. Dokümantasyon

- [ ] README mevcut ve güncellenmişse
- [ ] API dokümantasyonu güncellenmiş
- [ ] Değişiklik log'u kaydedilmiş
- [ ] Tasarım dokümanı güncellenmişse (breaking change)
- [ ] Konfigürasyon örneği güncellenmişse

---

## 11. SonarQube / Linting Raporu

- [ ] SonarQube A derecesi (minimum)
- [ ] ESLint hatalı yok
- [ ] Prettier format'ı uygulandı
- [ ] Type checking (TypeScript) başarılı
- [ ] Unused imports yok

**Sonuçlar:**
```
SonarQube: A (Coverage: 82%)
ESLint: ✅ 0 errors
Prettier: ✅ Format applied
TypeScript: ✅ No errors
```

---

## 12. Sonuç ve Karar

### 12.1 Genel Değerlendirme

- [ ] **APPROVE** - Onaylı, merge edilebilir
- [ ] **COMMENT** - Revizyon bekleniyor (minor)
- [ ] **REQUEST CHANGES** - Zorunlu değişiklik (major)
- [ ] **BLOCK** - Merge yasak (critical issue)

### 12.2 Bulguları Özeti

**Güçlü Yönler:**
- [Pozitif bulgu 1]
- [Pozitif bulgu 2]

**Geliştirme Gereken Alanlar:**
- [ ] [Issue 1] - Zorunlu düzeltme
- [ ] [Issue 2] - Zorunlu düzeltme
- [ ] [Suggestion 1] - İsteğe bağlı iyileştirme

### 12.3 İnceleme Tarihi ve Notları

```
İnceleme Başlangıcı: 09/02/2026 10:00
İnceleme Bitmesi: 09/02/2026 11:30
Toplam Süre: 1.5 saat
Satır Başına Ortalama: ~2 dakika
```

---

## Onay Tablosu

| Görev                  | Kimin           | Tarih     | Durum |
| :--------------------- | :-------------- | :-------- | :---- |
| **Kod İncelemesi**     | [Reviewer Adı]  | _________ | ✅     |
| **Developer Revizyon** | [Developer Adı] | _________ | ⏳     |
| **Final Approval**     | [Tech Lead]     | _________ | ⏳     |
| **Merge**              | [QA/Tech Lead]  | _________ | ⏳     |

---

**İnceleme Yapan:** _________________ **Tarih:** _________
**Developer:** _________________ **Tarih:** _________
