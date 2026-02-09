/**
 * Ana uygulamanın birim testleri
 *
 * Test adı: test_[ModulAdi]_[FonksiyonAdi]_[BeklenenDavranis]
 * Test deseni: AAA (Arrange, Act, Assert)
 * ISO 29119 uyumlu
 */

import { baslatUygulama, saglikKontrolu } from '../src/index';

describe('Ana Uygulama Testleri', () => {
  /**
   * Test: Sağlık kontrolü çalışmalı
   * Senaryo: GET /health request yapılınca sistem durumu döner
   * Beklenen: { durum: 'iyi', zaman: ISO string }
   */
  test('test_SaglikKontrolu_Cagrilinca_DurumDonmeli', () => {
    // Hazırlık (Arrange) - Test verileri hazırla
    // Sağlık kontrolü çağrılmaya hazır

    // Çalıştırma (Act) - Fonksiyonu çağır
    const sonuc = saglikKontrolu();

    // Doğrulama (Assert) - Sonuç kontrol et
    expect(sonuc).toBeDefined();
    expect(sonuc.durum).toBe('iyi');
    expect(sonuc.zaman).toBeDefined();
    expect(new Date(sonuc.zaman)).toBeInstanceOf(Date);
  });

  /**
   * Test: Başlatma fonksiyonu çalışmalı
   * Senaryo: Uygulamayı başlat
   * Beklenen: Hata olmadan çalış
   */
  test('test_BaslatUygulama_Cagrilinca_HataSizBitmeli', () => {
    // Hazırlık (Arrange)
    const consoleSpy = jest.spyOn(console, 'log').mockImplementation();

    // Çalıştırma (Act)
    baslatUygulama();

    // Doğrulama (Assert)
    expect(consoleSpy).toHaveBeenCalled();
    expect(consoleSpy).toHaveBeenCalledWith('✅ Uygulama başlatılıyor...');

    // Temizle (Cleanup)
    consoleSpy.mockRestore();
  });

  /**
   * Test: Sağlık kontrolü cevabı doğru formatta olmalı
   * Senaryo: Edge case - Zaman formatı doğru mu?
   * Beklenen: ISO 8601 formatında zaman
   */
  test('test_SaglikKontrol_ZamanFormati_ISO8601Olmali', () => {
    // Hazırlık
    const isoRegex = /^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}Z?$/;

    // Çalıştırma
    const { zaman } = saglikKontrolu();

    // Doğrulama
    expect(isoRegex.test(zaman)).toBe(true);
  });
});
