\# RACI Matrisi (Sorumluluk Atama Matrisi)



Bu belge, projenin her aşamasındaki rollerin sorumluluklarını tanımlar. ISO/IEC 12207 standartları ve kurumsal küresel iş akışına göre hazırlanmıştır.



\## Roller ve Kısaltmalar

\- \*\*R (Responsible - Sorumlu):\*\* İşi fiilen yapan kişidir.

\- \*\*A (Accountable - Hesap Verebilir):\*\* İşin sahibi ve onay makamıdır (Her satırda tek bir A bulunur).

\- \*\*C (Consulted - Danışılan):\*\* Görüşüne başvurulan uzmanlardır.

\- \*\*I (Informed - Bilgilendirilen):\*\* Süreç sonuçları hakkında bilgi verilen kişilerdir.



---



\## Sorumluluk Tablosu



| İş Akışı / Süreç Aşamaları | PO | PM | SA | DEV | QA | SO | SRE |

| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: |

| \*\*İnisiyasyon ve Kapsamlandırma\*\* | A/R | R | C | I | I | I | I |

| \*\*Analiz ve Gereksinim Belirleme\*\* | A | R | C | C | R | I | I |

| \*\*Sistem ve Mimari Tasarım\*\* | I | C | A/R | C | I | R | C |

| \*\*Kod Geliştirme (Implementation)\*\* | I | I | C | A/R | I | C | I |

| \*\*Test ve Doğrulama (QA)\*\* | C | I | I | C | A/R | C | I |

| \*\*Dağıtım ve Canlıya Alma\*\* | I | C | I | I | C | R | A/R |

| \*\*İşletme ve Bakım\*\* | I | I | I | R | I | I | A/R |



---



\## Notlar

\* \*\*PO:\*\* Ürün Sahibi

\* \*\*PM:\*\* Proje Yöneticisi

\* \*\*SA:\*\* Çözüm Mimarı

\* \*\*DEV:\*\* Geliştirici Takımı

\* \*\*QA:\*\* Test Takımı

\* \*\*SO:\*\* Güvenlik Sorumlusu

\* \*\*SRE:\*\* DevOps/Operasyon

