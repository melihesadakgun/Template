---
description: Bu belge tüm yazılım projeleri için standartlara dayalı küresel iş akışını tanımlar. Amaç, süreçlerin tutarlı, tekrarlanabilir ve denetlenebilir şekilde yürütülmesini sağlamaktır.
---

# Global Workflow

## Amaç
Bu belge tüm yazılım projeleri için standartlara dayalı küresel iş akışını tanımlar. Amaç, süreçlerin tutarlı, tekrarlanabilir ve denetlenebilir şekilde yürütülmesini sağlamaktır.

## Yaşam döngüsü aşamaları
### İnisiyasyon ve kapsamlandırma
- **Girdi:** İş gereksinimleri, paydaş talepleri.
- **Çıktı:** Kapsam belgesi, ön risk değerlendirmesi, fonksiyonel nokta tahmini.
- **Sorumlu:** Ürün Sahibi, Proje Yöneticisi.

### Analiz ve gereksinim
- **Girdi:** Kapsam belgesi.
- **Çıktı:** Onaylı gereksinim dokümanları, izlenebilirlik matrisi.
- **Sorumlu:** İş Analisti, Ürün Sahibi.

### Tasarım
- **Girdi:** Gereksinimler.
- **Çıktı:** Mimari kararları, güvenlik gereksinimleri, test edilebilir tasarım.
- **Sorumlu:** Çözüm Mimarı, Güvenlik Sorumlusu.

### Geliştirme
- **Girdi:** Tasarım dokümanları.
- **Çıktı:** Kod, birim testleri, kod inceleme kayıtları.
- **Sorumlu:** Geliştirici Takımı.

### Test ve doğrulama
- **Girdi:** Derlenmiş yazılım, test planları.
- **Çıktı:** Test raporları, hata kayıtları, onay/ret kararı.
- **Sorumlu:** QA Takımı.

### Dağıtım
- **Girdi:** Onaylı sürüm, dağıtım planı.
- **Çıktı:** Üretim sürümü, dağıtım notları, geri alma planı.
- **Sorumlu:** SRE/DevOps.

### İşletme ve bakım
- **Girdi:** Üretim sürümü.
- **Çıktı:** İzleme metrikleri, düzeltici faaliyetler, sürüm güncellemeleri.
- **Sorumlu:** Operasyon Takımı.

## Geçiş kapıları ve kabul kriterleri
- **Kapı 1:** Gereksinim onayı — izlenebilirlik ve test edilebilirlik sağlanmış.
- **Kapı 2:** Tasarım onayı — güvenlik ve performans gereksinimleri tanımlanmış.
- **Kapı 3:** Kod kalite kapısı — statik analiz, birim test hedefleri ve kod inceleme tamamlanmış.
- **Kapı 4:** Test onayı — kritik test senaryoları geçilmiş, açıklar SLA’ya göre sınıflandırılmış.
- **Kapı 5:** Dağıtım onayı — geri alma planı ve izleme hazır.

## CI/CD ve otomasyon akışı
- Commit → PR → Otomatik Build → Statik Analiz → Birim Test → Güvenlik Tarama → Kod İncelemesi → Merge → Entegrasyon Testleri → Canary Dağıtım → İzleme
- Özellik bayrakları ile Canary ve A/B testleri kontrol edilir.
- **Rollback:** Her dağıtım için otomatik geri alma tetikleyicisi bulunur.

## Test stratejisi ve otomasyon
- **Test katmanları:** Birim, entegrasyon, sistem, kabul, performans, güvenlik.
- **Risk tabanlı öncelik:** ISO 29119’e göre kritik iş fonksiyonları önceliklidir.
- **Otomasyon hedefi:** Kritik senaryoların otomasyonu; regresyon setinin sürekli çalıştırılması.
- **Test verisi:** Üretim verisi anonimleştirilmiş kopyalarla veya sentetik verilerle sağlanır.

## Güvenlik ve uyum akışı
- Güvenlik tasarım incelemesi tasarım aşamasında zorunludur.
- Güvenlik taramaları PR aşamasında otomatik, sürüm öncesi DAST/pen test planlı.
- **Risk yönetimi:** Bulgu oluştuğunda risk seviyesi belirlenir ve CAPA süreci başlatılır.
- **Erişim onayı:** Dağıtım ve üretim erişimleri onaylı rollerle sınırlıdır.

## Ölçüm, izleme ve geri bildirim döngüsü
- **Sürekli ölçüm:** CI pipeline, test sonuçları, performans ve güvenlik metrikleri toplanır.
- **Dashboard:** KPI’lar gerçek zamanlı dashboard’larda izlenir.
- **Geri bildirim:** Haftalık sprint retrospektifleri ve aylık kalite incelemeleri ile iyileştirme aksiyonları belirlenir.

## Rollerin sorumlulukları
- **Ürün Sahibi:** Kapsam, önceliklendirme, kabul kriterleri.
- **Proje Yöneticisi:** Zaman, kaynak ve süreç uyumu.
- **Çözüm Mimarı:** Teknik tasarım ve mimari kararlar.
- **Geliştirici:** Kod üretimi, birim test, PR.
- **QA:** Test planlama, otomasyon, test yürütme.
- **Güvenlik Sorumlusu:** Risk değerlendirmesi, güvenlik onayları.
- **SRE/DevOps:** CI/CD, dağıtım, izleme, geri alma.

## Denetim ve sürekli iyileştirme
- **Periyodik gözden geçirme:** Her sürüm sonrası kalite ve güvenlik retrospektifi.
- **İyileştirme döngüsü:** Planla Uygula Kontrol Et Önlem al (PDCA) yaklaşımıyla süreçler güncellenir.
- **Kayıt tutma:** Tüm denetim ve düzeltici faaliyet kayıtları saklanır.

## Acil durum ve felaket kurtarma
- **Olay sınıflandırma:** Seviyelere göre (kritik, yüksek, orta, düşük) tanımlanır.
- **Olay müdahale:** SLA’lar, iletişim planı ve sorumlular önceden belirlenir.
- **Felaket kurtarma:** Yedekleme, RTO/RPO hedefleri ve periyodik tatbikatlar tanımlanır.
