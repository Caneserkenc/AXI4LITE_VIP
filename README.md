# AXI4-Lite Verification IP (UVM)

## Proje Özeti

Bu proje, **UVM kullanılarak geliştirilmiş bir AXI4-Lite doğrulama IP’si (VIP)** içermektedir. VIP, register tabanlı basit bir AXI4-Lite slave tasarımının doğrulanması amacıyla oluşturulmuştur.

Çalışma, özellikle:
- UVM mimarisini öğrenmek,
- VALID/READY tabanlı el sıkışma mekanizmasını anlamak,
- DUT davranışına göre master sürme pratiği kazanmak

hedefleriyle geliştirilmiştir.

---

## RTL Kaynağı

Doğrulanan RTL tasarımı:

- `axi4_lite_slave.sv`
- Kaynak: https://github.com/arhamhashmi01/Axi4-lite

RTL tasarımı eğitim amacıyla kullanılmıştır.

---

## VIP Kapsamı

### Desteklenen İşlemler
- Tek seferde bir **okuma** veya **yazma** işlemi
- Yazma adresi (AW) ve yazma verisi (W) aynı clock çevriminde gönderilir
- Tam kelime yazma (`WSTRB = 4'b1111`)
- Okuma işlemleri adres → veri sıralaması ile gerçekleştirilir

### Varsayımlar
- Adres alanı register indeksi (0–31) olarak kullanılır
- Okuma ve yazma işlemleri seri yürütülür
- Back-pressure senaryoları test edilmez

Bu varsayımlar, doğrulanan RTL tasarımının davranışlarına uygun olacak şekilde seçilmiştir.

---

## Doğrulama Yaklaşımı

VIP aşağıdaki temel UVM bileşenlerinden oluşur:

- **Driver**: DUT’un beklediği handshake davranışına göre sinyal sürer
- **Monitor**: Okuma ve yazma işlemlerini gözlemleyerek transaction’ları oluşturur
- **Scoreboard**: Register tabanlı referans model ile sonuçları karşılaştırır

Coverage çalışmaları, eğitim amacıyla sınırlı tutulmuştur ve temel senaryoları kapsar.

---

## Amaç

Bu proje, AXI4-Lite benzeri arayüzlere sahip tasarımların doğrulanmasında kullanılan temel kavramları öğretmeyi amaçlar ve UVM tabanlı bir VIP’in nasıl yapılandırıldığını göstermeyi hedefler.
