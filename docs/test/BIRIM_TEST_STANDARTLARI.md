\# Birim Test Standartları Rehberi



Bu belge, projenin kod kalitesini (ISO 5055) ve test doğruluğunu (ISO 29119) korumak için geliştiricilerin uyması gereken kuralları tanımlar.



\## 1. Temel İlkeler

\* \*\*Kapsam:\*\* Her yeni geliştirilen modül/fonksiyon için birim test yazılması zorunludur. Proje genelinde hedef \*\*%80 test kapsamıdır\*\*.

\* \*\*İzolasyon:\*\* Testler birbirinden bağımsız olmalı, dış sistemlere (veritabanı, API, Bambu Lab donanımı) bağımlı olmamalıdır.

\* \*\*Dil:\*\* Test fonksiyon isimleri ve hata mesajları \*\*Türkçe\*\* olmalıdır.



\## 2. İsimlendirme Standartları

Test fonksiyonları, test edilen senaryoyu açıkça belirtmelidir:

`test\_\[ModülAdi]\_\[FonksiyonAdi]\_\[BeklenenDavranis]`



\*\*Örnek:\*\*

`test\_BambuApi\_BaglantiKur\_HataliKimlik\_HataDonmeli()`



\## 3. Test Yapısı (AAA Deseni)

Her test fonksiyonu üç ana bölümden oluşmalıdır:

1\. \*\*Hazırlık (Arrange):\*\* Test nesnelerinin oluşturulması ve ön koşulların ayarlanması.

2\. \*\*Çalıştırma (Act):\*\* Test edilecek fonksiyonun çağrılması.

3\. \*\*Doğrulama (Assert):\*\* Sonucun beklenen değerle karşılaştırılması.



\## 4. Taklit Etme (Mocking) ve Saplamalar (Stubbing)

\* Dış sistemler (örn: Bambu Lab Studio API) mutlaka \*\*Mock\*\* nesnelerle simüle edilmelidir.

\* Donanım etkileşimleri için soyutlama katmanları (Interface) kullanılmalı ve bu arayüzler test edilmelidir.



\## 5. Kalite Kapısı (Gate 3) Entegrasyonu

\* Testler CI/CD sürecinde otomatik olarak çalıştırılır.

\* Başarısız olan tek bir test dahi olsa "Build" başarısız sayılır ve PR reddedilir.

\* Kapsam oranı %80'in altına düştüğünde uyarı verilir; kritik modüllerde bu oran %100'e çekilebilir.



---

\*\*İzleme Metriği (ISO 15939):\*\*

\- Toplam Test Sayısı

\- Başarı Oranı (%)

\- Kod Kapsamı (Line/Branch Coverage)

