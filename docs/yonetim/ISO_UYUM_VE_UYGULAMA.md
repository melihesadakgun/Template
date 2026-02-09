\# ISO Uyum ve Uygulama Rehberi



Bu doküman, projenin ISO/IEC/IEEE standartlarına uyumunu doğrulamak ve geliştirme ekiplerine uygulama standartlarını aktarmak için hazırlanmıştır.



\## 1. Standart Uygulama Matrisi



| Standart | Uygulama Alanı | İzleme Aracı / Yöntemi |

| :--- | :--- | :--- |

| \*\*ISO/IEC 12207\*\* | Yazılım Yaşam Döngüsü | `globalworkflow.md` akış şeması |

| \*\*ISO/IEC 15939\*\* | Ölçüm ve Metrikler | SonarQube \& CI Pipeline Dashboard |

| \*\*ISO 27001\*\* | Bilgi Güvenliği | Minimum Ayrıcalık İlkesi \& Veri Anonimleştirme |

| \*\*ISO 5055\*\* | Kod Kalitesi (İç Yapı) | VS Code SonarLint \& Statik Analiz |

| \*\*ISO 29119\*\* | Test Stratejisi | Risk Tabanlı Test Planı (R-00x riskleri) |



---



\## 2. Uygulama Notları (Geliştirici Rehberi)



\### A. Kod Yazım ve İnceleme (Gate 3)

\* \*\*Karakter Seti:\*\* Tüm dosyalar UTF-8 (BOM'suz) olarak kaydedilmelidir.

\* \*\*Yorum Satırları:\*\* Karmaşık mantıklar mutlaka Türkçe yorum satırları ile açıklanmalıdır.

\* \*\*PR Koşulu:\*\* En az bir bağımsız geliştirici onayı ve %80 test kapsamı sağlanmadan birleştirme yapılamaz.



\### B. Güvenlik ve Veri (ISO 27001)

\* \*\*Veri Taşıma:\*\* Üretim ortamındaki veriler (örneğin Bambu Lab kullanıcı verileri) test ortamına asla anonimleştirilmeden taşınamaz.

\* \*\*Erişim:\*\* Erişimler rol bazlı (RACI) olarak yönetilir ve 6 ayda bir gözden geçirilir.



\### C. Ölçümleme (ISO 15939)

\* \*\*Hata Yoğunluğu:\*\* KLOC (bin satır kod) başına düşen hata oranı takip edilmelidir.

\* \*\*SLA:\*\* Güvenlik açıkları, risk seviyesine göre belirlenen SLA (Hizmet Seviyesi Taahhüdü) süreleri içinde kapatılmalıdır.



---



\## 3. Denetim ve Sürekli İyileştirme

\* \*\*İç Denetim:\*\* Yılda en az bir kez `GEMINI.md` kurallarına uyum denetimi yapılır.

\* \*\*CAPA Süreci:\*\* Herhangi bir uyumsuzluk tespit edildiğinde Düzeltici ve Önleyici Faaliyet (CAPA) süreci başlatılır.



---

\*\*Onaylayan:\*\* Proje Yöneticisi / Güvenlik Sorumlusu

\*\*Son Güncelleme:\*\* 2026-02-09

