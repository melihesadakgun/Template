# Gereksinim Dokümanı Şablonu (RD)

**Sürüm:** 1.0
**Tarih:** [.__/__/2026]
**Yazılı:** [Yazarın Adı]
**Onaylı:** [PO - Ürün Sahibi]

---

## 1. Genel Bakış

### 1.1 Amaç
[Tüm proje/özelliğin nihai hedefi nedir?]

### 1.2 Kapsam
[Hangi fonksiyonaliteler dahil? Hangisi dışında?]

### 1.3 Referanslar ve Standartlar
- ISO/IEC 12207 (Yazılım Yaşam Döngüsü)
- ISO/IEC 15288 (Sistem Yaşam Döngüsü)
- [Proje Spesifik Standartlar]

---

## 2. Yaş Taraflarının Gereksinimleri

| Paydaş       | Gereksinim                     |        Öncelik        | İzlenebilirlik ID |
| :----------- | :----------------------------- | :-------------------: | :---------------- |
| [Paydaş Adı] | [Gereğe ne yapmak istiyorlar?] | **Yüksek/Orta/Düşük** | REQ-001           |
|              |                                |                       |                   |

---

## 3. İşlevsel Gereksinimler (FR - Functional Requirements)

### FR-001: [Gereksinin Başlığı]
- **Açıklama:** [Detaylı açıklama]
- **Ön Koşullar:** [Bunun çalışması için neler gerekli?]
- **Beklenen Davranış:** [Sistem neyi yapmalı?]
- **Sonuç:** [İşlem tamamlandığında ne olmalı?]
- **Onay Kriterleri:**
  - [ ] Kontrol Noktası 1
  - [ ] Kontrol Noktası 2
- **Priorite:** Yüksek / Orta / Düşük
- **Tahmin Efor:** [X Adam/Saat]
- **Test Case Referansı:** TC-001, TC-002

### FR-002: [Diğer Gereksinimler...]

---

## 4. Maneviyat (İşlevsel Olmayan Gereksinimler - NFR)

| Gereksinim            | Koşul                      |      Ölçüm      | REQ ID  |
| :-------------------- | :------------------------- | :-------------: | :------ |
| **Performans**        | Ortalama yanıt süresi      |     < 200ms     | NFR-001 |
| **Kullanılabilirlik** | Mobil uyumlu tasarım       |   Responsive    | NFR-002 |
| **Güvenlik**          | Kritik veriler şifreli     | AES-256 minimum | NFR-003 |
| **Ölçeklenebilirlik** | Eş zamanı kullanıcı sayısı |     10.000+     | NFR-004 |
| **Bakım Kolaylığı**   | Kodun başarılı %           |      >%80       | NFR-005 |

---

## 5. İzlenebilirlik Matrisi (RTM)

| REQ ID  | Tasarım ID | Kod Modülü  | Test Case ID | Durum       |
| :------ | :--------- | :---------- | :----------- | :---------- |
| REQ-001 | DES-001    | mod_xyz.ts  | TC-001       | ✅ Aktif     |
| REQ-002 | DES-002    | mod_abc.ts  | TC-002       | ⏳ Tasarımda |
| NFR-001 | DES-003    | perf_opt.ts | TC-003       | ✅ Aktif     |

---

## 6. Kabul Kriterleri (Acceptance Criteria)

Proje bu gereksinimleri karşılarsa **ONAYLANIR**:
- [ ] Tüm FR ve NFR tamamen uygulanmış ve test edilmiş
- [ ] Birim test kapsamı ≥ %80
- [ ] SonarQube raporu kritik buluş yok
- [ ] Güvenlik taraması temiz
- [ ] Performans hedefleri karşılanmış
- [ ] Dokümantasyon %100 Türkçe ve açık

---

## 7. Değişiklik Geçmişi

| Sürüm | Tarih      | Değişiklik | Yazılı     |
| :---- | :--------- | :--------- | :--------- |
| 1.0   | 09/02/2026 | İlk yazım  | [Ad Soyad] |
|       |            |            |            |

---

**Onay Tablosu (RACI Uyumu)**

| Rol                   | İmza              | Tarih     |
| :-------------------- | :---------------- | :-------- |
| Ürün Sahibi (PO)      | _________________ | _________ |
| Çözüm Mimarı (SA)     | _________________ | _________ |
| Proje Yöneticisi (PM) | _________________ | _________ |
