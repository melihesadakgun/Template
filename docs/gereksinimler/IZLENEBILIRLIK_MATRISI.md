\# Gereksinim İzlenebilirlik Matrisi (RTM)



Bu belge, iş gereksinimlerinin yazılım yaşam döngüsü boyunca (Tasarım -> Kod -> Test) izlenebilirliğini garanti altına almak için kullanılır.



\## İzlenebilirlik Tablosu



| Gereksinim ID | Gereksinim Tanımı | Tasarım Belgesi / Kararı (Kapı 2) | Kaynak Kod (PR/Modül) | Test Senaryosu ID (Kapı 4) | Durum |

| :--- | :--- | :--- | :--- | :--- | :--- |

| \*\*REQ-001\*\* | Tüm dökümantasyon UTF-8 ve Türkçe olmalıdır. | Mimari Karar #1 | `/.vscode/settings.json` | `TC-DOC-01` | Onaylandı |

| \*\*REQ-002\*\* | Kritik modüller için %80 birim test kapsamı. | Test Stratejisi v1 | `CI/CD Pipeline` | `TC-QUAL-01` | Devam Ediyor |

| \*\*REQ-003\*\* | Statik analizde kritik bulgu olmamalı. | Güvenlik Tasarımı | `SonarQube Config` | `TC-SEC-01` | Beklemede |

| \*\*REQ-004\*\* | Bambu Lab Studio entegrasyonu sağlanmalı. | Entegrasyon Belgesi | `/src/bambu\_api/` | `TC-INT-01` | Tanımlandı |



---



\## Durum Açıklamaları

\* \*\*Tanımlandı:\*\* Gereksinim analiz aşamasındadır.

\* \*\*Devam Ediyor:\*\* Geliştirme veya tasarım aşaması sürmektedir.

\* \*\*Beklemede:\*\* Test veya onay aşamasına geçiş kapısında bekliyor.

\* \*\*Onaylandı:\*\* Kalite kapılarından geçmiş ve doğrulanmıştır.



\## Revizyon Geçmişi

| Versiyon | Tarih | Değişiklik Özeti | Sorumlu (RACI) |

| :--- | :--- | :--- | :--- |

| v1.0.0 | 2026-02-09 | İlk matris oluşturuldu. | Ürün Sahibi (PO) |

