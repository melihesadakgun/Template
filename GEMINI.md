Global Rules
İletişim
tercih edilen iletişim dili "Türkçe" olmalı (UTF-8)
-kodları açıklayan yorum satırları Türkçe olmalı (UTF-8)
-oluşturulan tüm dökümantasyonlar Türkçe olmalı (UTF-8)
===

## Amaç

Bu belge, tüm yazılım projeleri için uygulanacak küresel kuralları ve uyum gereksinimlerini ISO/IEC/IEEE standartlarına göre tanımlar. Hedef, kalite, güvenlik ve süreç tutarlılığı sağlayarak sürdürülebilir, izlenebilir ve denetlenebilir bir geliştirme ortamı oluşturmaktır.

## Kapsam

* **Uygulama alanı:** Tüm projenin yazılım bileşenleri, altyapı kodu, CI/CD boru hatları ve ilgili dokümantasyon.
* **Hariç tutulanlar:** Üçüncü taraf kapalı kaynak servislerin iç kodu; ancak entegrasyon güvenlik ve uyum gereksinimleri kapsama dahildir.

## Temel ilkeler

* **Standart uyumu:** Süreçler ISO/IEC 12207 ve ISO/IEC 15288 ile uyumlu olacak şekilde tanımlanır.
* **Ölçülebilirlik:** Ölçüm süreçleri ISO/IEC 15939 ve fonksiyonel boyutlama ISO/IEC 14143 esas alınarak uygulanır.
* **Risk tabanlı test:** Test stratejileri ISO 29119 ilkelerine göre risk odaklı hazırlanır.
* **Bilgi güvenliği:** ISO 27001 gereksinimleri proje yaşam döngüsü boyunca uygulanır.
* **İç kalite:** Kodun iç yapısı ISO 5055 kriterleriyle değerlendirilir.

## Kurallar ve zorunluluklar

* **Süreç tanımları:** Tüm yaşam döngüsü süreçleri yazılı, onaylı ve erişilebilir olmalıdır. (Gereksinim, tasarım, geliştirme, test, dağıtım, bakım)
* **RACI:** Her süreç için Sahip, Sorumlu, Danışılan, Bilgilendirilen roller RACI tablosunda tanımlanmalıdır.
* **Dokümantasyon:** Her sürüm için gereksinim, tasarım, test planı ve dağıtım notları saklanmalıdır. Doküman versiyonlanmalı ve erişim kontrolü uygulanmalıdır.
* **Kod yönetimi:** Tüm kaynak kod Git ile yönetilir; ana dal korumalıdır; pull request zorunludur.
* **Kod incelemesi:** Her PR en az bir bağımsız geliştirici tarafından onaylanmadan birleştirilemez.
* **Statik analiz:** Her PR için otomatik statik analiz çalıştırılmalı; kritik ve yüksek güvenlik bulguları çözülmeden birleştirme yasaktır.
* **Test kapsamı:** Kritik modüller için birim test kapsamı hedefi %80 veya proje risk değerlendirmesine göre belirlenen seviye.
* **Güvenlik taramaları:** Bağımlılık ve SAST/DAST taramaları düzenli olarak çalıştırılmalı; açıklar SLA içinde kapatılmalıdır.
* **Özellik bayrakları:** Yeni veya deneysel özellikler feature flag ile kontrol edilmelidir.
* **Sürüm kontrolü:** Her sürüm için değişiklik listesi, geri alma planı ve sürüm etiketi oluşturulmalıdır.
* **Veri koruma:** Üretim verileri test ortamına anonimleştirilmeden taşınamaz.
* **Erişim yönetimi:** En az ayrıcalık ilkesi uygulanır; erişimler düzenli olarak gözden geçirilir.
* **İzlenebilirlik:** Gereksinim → tasarım → kod → test izlenebilirliği sağlanmalıdır.

## Ölçüm ve metrikler

* **Fonksiyonel boyutlama:** Yeni projeler ve büyük değişiklikler için ISO/IEC 14143’e göre fonksiyonel nokta analizi yapılır.
* **Temel metrikler:**

  * Fonksiyonel nokta tahmin sapması
  * Birim test kapsamı
  * Hata yoğunluğu (KLOC başına)
  * Güvenlik açık çözüm süresi
  * CI pipeline başarı oranı

* **Ölçüm yönetimi:** Ölçüm planları ISO/IEC 15939 formatında hazırlanır; veri toplama sorumluları ve frekans açıkça tanımlanır.

## Uyum, denetim ve raporlama

* **Periyodik denetim:** Yılda en az bir iç uyum denetimi; kritik projelerde yarıyıl denetimleri.
* **Uyum raporu:** Denetim sonuçları, aksiyon planları ve KPI trendleri yönetim kuruluna sunulur.
* **Düzeltici faaliyet:** ISO 27001 uyumlu CAPA (Corrective and Preventive Action) süreci işletilir.
* **Uyumsuzluk:** Kritik uyumsuzluklar için acil düzeltici eylem ve geçici durdurma mekanizması uygulanır.

## İstisnalar ve değişiklik yönetimi

* **İstisna talebi:** Standartlardan sapma gerektiğinde yazılı istisna talebi, risk değerlendirmesi ve onay süreci gereklidir.
* **Değişiklik kontrolü:** Tüm süreç ve kural değişiklikleri değişiklik kontrol panosunda izlenir; geri dönülebilirlik planı olmalıdır.

## Eğitim ve kültür

* **Zorunlu eğitimler:** Yeni ekip üyeleri için güvenlik, kod kalitesi ve süreç eğitimleri zorunludur.
* **Sürekli gelişim:** Aylık teknik paylaşımlar ve çeyreklik süreç iyileştirme oturumları düzenlenir.

## Ekler

* **Şablonlar:** Ölçüm planı, test planı, RACI matrisi, istisna talep formu.
* **Araç önerileri:** GitHub/GitLab, SonarQube, Snyk, Jenkins/GitHub Actions, Grafana.
