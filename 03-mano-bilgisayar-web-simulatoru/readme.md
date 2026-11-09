# SUBÜ Mano Studio

**Mano Basic Computer Assembly Compiler & Simulator**

SUBÜ Mano Studio, Mano Basic Computer mimarisini assembly düzeyinde
öğrenmek ve komutların işlemci içinde nasıl yürütüldüğünü adım adım
incelemek amacıyla hazırlanmış tarayıcı tabanlı bir eğitim aracıdır.

Öğrenciler bu araçla assembly kodu yazabilir, makine kodlarını ve bellek
yerleşimini görebilir, komutları tek tek veya otomatik çalıştırabilir ve
yürütme sırasında CPU yazmaçlarını, ortak veri yolunu, bellek
erişimlerini ve mikroişlemleri izleyebilir.

> **Sürüm:** V1.7\
> **Çalışma biçimi:** İstemci tarafında çalışan tek HTML dosyası\
> **Gereksinim:** Güncel bir web tarayıcısı (Chrome, Edge, Firefox vb.)

------------------------------------------------------------------------

## 1. Başlarken

SUBÜ Mano Studio'yu kullanmak için:

1.  Depodaki `subu_mano_studio_v1_7.html` dosyasını indirin.
2.  Dosyayı Chrome, Edge veya Firefox gibi güncel bir tarayıcıda açın.
3.  **Assembly Editor** alanına Mano assembly kodunuzu yazın veya örnek
    kodu kullanın.
4.  **Compile** düğmesine basarak programı derleyin.
5.  Derleme başarılı olduğunda **Step** ile komutları mikroişlem
    adımlarıyla ilerletin veya **Play** ile otomatik çalıştırın.
6.  Çalışmayı durdurmak için **Pause**, başlangıç durumuna dönmek için
    **Reset** düğmesini kullanın.

Uygulama yerel olarak çalışır; temel kullanım için ayrıca sunucu veya
kurulum gerekmez.

------------------------------------------------------------------------

## 2. Arayüz Panelleri

### 01 --- Assembly Editor

Assembly programının yazıldığı alandır.

-   Komutlar ve etiketler bu alana girilir.
-   `;` karakteri yorum satırı başlatır. Satırın tamamı veya komutun
    devamındaki açıklama yorum olarak yazılabilir.
-   Programı derlemek için **Compile** düğmesi kullanılır.
-   **Clear** editör alanını temizler.
-   **Example** örnek programı editöre yükler.

Örnek:

``` asm
ORG 100

        LDA N1
        ADD N2
        STA RESULT
        HLT

N1,     DEC 12
N2,     DEC 4
RESULT, DEC 0

END.
```

Bu programın amacı `N1` ve `N2` değerlerini toplamak ve sonucu `RESULT`
bellek adresine yazmaktır.

### 02 --- Compiled Program / Memory Map

Derleme sonucunda oluşan makine kodlarını ve programın bellekteki
yerleşimini gösterir.

Tablodaki sütunlar:

  -----------------------------------------------------------------------
  Sütun                               Açıklama
  ----------------------------------- -----------------------------------
  ADDR                                Komutun veya verinin bellekte
                                      bulunduğu adres

  HEX                                 16 bit makine kodunun onaltılık
                                      gösterimi

  DEC                                 Makine kodunun işaretsiz onluk
                                      gösterimi

  INSTRUCTION / DATA                  Kaynak programdaki assembly komutu
                                      veya veri tanımı

  TYPE                                Satırın komut (`CODE`) veya veri
                                      (`DATA`) olduğunu belirtir
  -----------------------------------------------------------------------

Yürütülmekte olan komutun satırı vurgulanır. Böylece PC'nin hangi komutu
işaret ettiği takip edilebilir.

### 03 --- Execution Control

Programın yürütülmesini kontrol eder.

-   **Step:** Bir mikroişlem adımı ilerletir. Bir assembly komutunu
    tamamlamak için birden fazla Step gerekebilir.
-   **Play:** Programı otomatik olarak yürütür.
-   **Pause:** Otomatik yürütmeyi duraklatır.
-   **Reset:** İşlemciyi ve yürütme durumunu programın başlangıç
    koşullarına döndürür.
-   **Speed:** Otomatik yürütme hızını ayarlar.

Panelde ayrıca şu bilgiler izlenir:

-   **Program Counter (PC):** Sıradaki komutun adresi.
-   **Time Step:** Yürütülmekte olan zamanlama adımı (`T0`, `T1`, `T2`
    vb.).
-   **Instruction:** O anda yürütülen komut.
-   **Executed Steps:** Gerçekleştirilen mikroişlem adımlarının sayısı.

**Önemli:** Step düğmesi bir assembly komutunu değil, bir mikroişlem
adımını ilerletir. Örneğin bir `LDA` komutu fetch, decode, operand okuma
ve AC'ye yükleme adımlarından oluşur.

### 04 --- CPU Register Monitor

İşlemcinin temel yazmaçlarını yürütme sırasında izlemek için kullanılır.

  -----------------------------------------------------------------------
  Yazmaç                              Görevi
  ----------------------------------- -----------------------------------
  PC (Program Counter)                Sıradaki komutun bellek adresini
                                      tutar.

  AR (Address Register)               Bellek erişiminde kullanılacak
                                      adresi tutar.

  DR (Data Register)                  Bellekten okunan veya belleğe
                                      yazılacak veriyi tutar.

  AC (Accumulator)                    Aritmetik ve mantıksal işlemlerde
                                      kullanılan temel yazmaçtır.

  IR (Instruction Register)           Yürütülmekte olan komutun makine
                                      kodunu tutar.

  TR (Temporary Register)             Geçici veri saklama amacıyla
                                      kullanılır.
  -----------------------------------------------------------------------

PC ve AR 12 bit, diğer gösterilen temel yazmaçlar 16 bit olarak sunulur.
Değerler onaltılık biçimde görüntülenir. Bir mikroişlemde hedef olan
yazmaç görsel olarak vurgulanır.

### 05 --- 16-bit Common Bus

CPU yazmaçları ile veri yolu arasındaki veri aktarımını gözlemlemek için
kullanılır.

-   Ortak veri yolu üzerinden taşınan değer görüntülenir.
-   Aktif kaynak ve hedef yazmaçlar vurgulanır.
-   Veri aktarımının hangi mikroişlemle ilişkili olduğu takip
    edilebilir.

Örneğin `AC ← DR` mikroişleminde DR kaynak, AC hedef yazmaçtır. Bu panel
veri yolundaki aktarımı anlamaya yardımcı olur.

### 06 --- Memory Explorer

Belleğin adres ve içerik bazında incelenmesini sağlar.

-   Bellek adresleri 12 bit adres alanı içinde gösterilir.
-   Her bellek sözcüğü 16 bittir.
-   Adres, HEX değer, DEC değer ve ilgili kaynak satırı görüntülenir.
-   Aktif komut veya erişilen adres vurgulanır.

Mano Basic Computer'ın 4096 × 16 bellek yapısını anlamak; komutların ve
verilerin bellekte nerede bulunduğunu incelemek için kullanılabilir.

### 07 --- Micro-operation Trace

Program yürütülürken gerçekleşen mikroişlemlerin geçmişini gösterir.

Örnek mikroişlemler:

``` text
T0: AR ← PC
T1: IR ← M[AR], PC ← PC + 1
T2: Decode IR, AR ← IR(0–11)
T4: DR ← M[AR]
T5: AC ← AC + DR
```

Bu panel özellikle şu konuları incelemek için kullanışlıdır:

-   Fetch (komut getirme) çevrimi
-   Decode (komut çözme) aşaması
-   Execute (komut yürütme) aşaması
-   Bellek okuma ve yazma işlemleri
-   Komutların farklı zamanlama adımlarında gerçekleştirdiği
    mikroişlemler

Bir komutun kaç mikroişlem adımında tamamlandığını ve yazmaçların hangi
sırayla güncellendiğini buradan takip edebilirsiniz.

### 08 --- ALU Monitor

Aritmetik ve mantıksal işlem biriminin (ALU) çalışma durumunu izler.

Panelde aşağıdaki bilgiler bulunur:

-   **ALU A:** İşlemin birinci operandı olarak kullanılan AC değeri.
-   **ALU B:** İşlemin ikinci operandı olarak kullanılan DR değeri.
-   **ALU Result:** ALU sonuç alanında gösterilen değer.
-   **E (Carry):** Taşıma biti/flip-flop durumu.
-   **Operation:** İlgili işlem türü.

Özellikle `ADD` komutunda AC ve DR değerlerinin nasıl kullanıldığını,
sonucun AC'ye nasıl aktarıldığını ve taşıma bitinin durumunu
inceleyebilirsiniz.

> **Not:** ALU Monitor, eğitim amaçlı gözlem panelidir. Paneldeki
> gösterimler simülatörün mevcut yürütme modeline bağlıdır; fiziksel bir
> ALU devresinin kapı seviyesindeki iç yapısını temsil etmez.

### Output Console

Giriş/çıkış komutlarıyla ilişkili çıktıların görüntülendiği alandır.
Desteklenen giriş/çıkış komutlarının etkisini gözlemlemek için
kullanılabilir.

------------------------------------------------------------------------

## 3. Assembly Sözdizimi ve Kullanım Kuralları

### ORG --- Bellek başlangıç adresi

`ORG`, takip eden komut veya verilerin yerleştirileceği bellek adresini
belirler.

``` asm
ORG 100
```

Bu örnekte yerleşim adresi onaltılık `100` (yani 0x100) olarak
yorumlanır. Programdaki ilk `ORG` komutu, simülatörün program başlangıç
adresini belirler. Derleme tamamlandığında PC bu adrese ayarlanır.

Birden fazla `ORG` kullanılarak kod ve veri farklı bellek bölgelerine
yerleştirilebilir.

### DEC --- Onluk tabanda veri tanımlama

`DEC`, belleğe onluk tabanda sayısal veri yerleştirir.

``` asm
VALUE, DEC 25
NEG,   DEC -3
```

Negatif değerler 16 bit iki'nin tümleyeni gösterimiyle saklanır.

### HEX --- Onaltılık tabanda veri tanımlama

`HEX`, belleğe onaltılık tabanda veri yerleştirir.

``` asm
MASK, HEX 00FF
```

### Etiketler (Labels)

Etiketler, komut veya veri adreslerine isim vermek için kullanılır.

``` asm
LDA VALUE
...
VALUE, DEC 10
```

Etiket tanımında virgül kullanılması önerilir. Etiket adları büyük/küçük
harfe duyarsız olarak değerlendirilir.

### END --- Program sonu

`END` kaynak programın sonunu belirtir. Noktalı kullanım da kabul
edilir:

``` asm
END
```

veya

``` asm
END.
```

### Yorum satırları

Noktalı virgülden (`;`) sonraki bölüm yorum olarak kabul edilir.

``` asm
; Bu bir yorum satırıdır
LDA VALUE    ; VALUE verisini AC'ye yükle
```

------------------------------------------------------------------------

## 4. Desteklenen Komutlar

### Bellek başvurulu komutlar

  -----------------------------------------------------------------------
  Komut                               İşlev
  ----------------------------------- -----------------------------------
  AND                                 AC ← AC AND M\[AR\]

  ADD                                 AC ← AC + M\[AR\]

  LDA                                 AC ← M\[AR\]

  STA                                 M\[AR\] ← AC

  BUN                                 PC ← AR

  BSA                                 Alt program dönüş adresini belleğe
                                      kaydeder ve alt programa dallanır.

  ISZ                                 Bellekteki değeri bir artırır;
                                      sonuç sıfırsa PC'yi bir artırarak
                                      sonraki komutu atlar.
  -----------------------------------------------------------------------

Dolaylı adresleme, bellek başvurulu komutlarda `I` veya `@` gösterimiyle
belirtilebilir. Örneğin:

``` asm
LDA I PTR
```

### Yazmaç başvurulu komutlar

  Komut   İşlev
  ------- -----------------------------------------------
  CLA     AC'yi temizler.
  CLE     E taşıma bitini temizler.
  CMA     AC'nin tümleyenini alır.
  CME     E bitini tümleyenler.
  CIR     AC ve E üzerinde sağa döndürme yapar.
  CIL     AC ve E üzerinde sola döndürme yapar.
  INC     AC'yi bir artırır.
  SPA     AC pozitif veya sıfırsa sonraki komutu atlar.
  SNA     AC negatifse sonraki komutu atlar.
  SZA     AC sıfırsa sonraki komutu atlar.
  SZE     E sıfırsa sonraki komutu atlar.
  HLT     İşlemci yürütmesini durdurur.

### Giriş/çıkış komutları

  Komut   İşlev
  ------- ----------------------------------------------------------
  INP     Giriş yazmacındaki veriyi AC'nin düşük 8 bitine aktarır.
  OUT     AC'nin düşük 8 bitini çıkışa aktarır.
  SKI     Giriş bayrağı etkinse sonraki komutu atlar.
  SKO     Çıkış bayrağı etkinse sonraki komutu atlar.
  ION     Kesme sistemini etkinleştirir.
  IOF     Kesme sistemini devre dışı bırakır.

> **Kapsam notu:** Komutların simülatördeki davranışı, bu yazılım
> sürümünde uygulanan eğitim amaçlı yürütme modeline göredir. Donanım
> uygulaması, çevrim zamanlaması veya tüm Mano varyantlarıyla birebir
> eşdeğerlik varsayılmamalıdır.

------------------------------------------------------------------------

## 5. Örnek Uygulama: İki Sayının Toplanması

Aşağıdaki program 12 ve 4 sayılarını toplar ve sonucu `RESULT` etiketli
bellek alanına yazar.

``` asm
ORG 100

        LDA N1
        ADD N2
        STA RESULT
        HLT

N1,     DEC 12
N2,     DEC 4
RESULT, DEC 0

END.
```

### Beklenen sonuç

  Alan                            Beklenen değer
  -------------------------- -------------------
  Program başlangıç adresi             100 (HEX)
  N1                                          12
  N2                                           4
  RESULT                                      16
  HLT komutu                   Programı durdurur

### Adım adım inceleme

1.  **Compile:** Programı derleyin. Makine kodlarının ve bellek
    adreslerinin oluştuğunu kontrol edin.
2.  **PC:** Derleme sonrasında PC değerinin `100` olduğunu doğrulayın.
3.  **Step:** İlk adımlarda `AR ← PC` ve `IR ← M[AR]` mikroişlemlerini
    izleyin.
4.  **LDA N1:** N1 verisinin bellekten DR'ye, ardından AC'ye
    aktarılmasını takip edin.
5.  **ADD N2:** N2 değerinin okunmasını, ALU'da AC + DR işlemini ve
    sonucun AC'ye yazılmasını inceleyin.
6.  **STA RESULT:** AC'deki 16 değerinin RESULT bellek adresine
    yazıldığını Memory Explorer üzerinden doğrulayın.
7.  **HLT:** Programın durduğunu kontrol edin.

------------------------------------------------------------------------

## 6. Öğrenciler İçin Çalışma Önerileri

Konuları daha iyi anlamak için aşağıdaki çalışmaları sırasıyla
yapabilirsiniz:

1.  **Komut getirme çevrimi:** `LDA` komutunu Step ile ilerletin. T0, T1
    ve T2 adımlarında PC, AR ve IR değerlerini gözlemleyin.
2.  **Aritmetik işlem:** `ADD` komutunu çalıştırın. AC, DR, ALU Result
    ve E değerlerini karşılaştırın.
3.  **Belleğe yazma:** `STA` komutunu çalıştırın. AC değeri ile hedef
    bellek adresindeki verinin eşit olduğunu doğrulayın.
4.  **Koşullu atlama:** `ISZ` komutuyla bir sayacı sıfıra kadar azaltan
    program yazın. PC'nin hangi durumda arttığını inceleyin.
5.  **Dallanma:** `BUN` komutuyla bir döngü oluşturun ve PC'nin nasıl
    değiştiğini izleyin.
6.  **Etiket ve bellek yerleşimi:** Farklı `ORG` adresleri kullanarak
    kod ve verileri farklı bellek bölgelerine yerleştirin.
7.  **Mikroişlem karşılaştırması:** Aynı programı Step ve Play
    modlarında çalıştırın; Micro-operation Trace panelindeki adımları
    karşılaştırın.

------------------------------------------------------------------------

## 7. Sık Karşılaşılan Durumlar

  -----------------------------------------------------------------------
  Durum                               Kontrol edilmesi gereken
  ----------------------------------- -----------------------------------
  Derleme hatası alıyorum.            Komut adlarını, etiketleri,
                                      virgülleri ve `END` satırını
                                      kontrol edin. Hata mesajındaki
                                      satır numarasını inceleyin.

  Etiket bulunamadı hatası alıyorum.  Etiketin doğru yazıldığını ve
                                      tanımının programda bulunduğunu
                                      kontrol edin.

  PC beklediğim adreste başlamıyor.   İlk `ORG` komutunun adresini ve
                                      derleme sonrasında PC değerini
                                      kontrol edin.

  Program beklenmedik adrese          `BUN`, dolaylı adresleme ve
  dallanıyor.                         etiketlerin bellek adreslerini
                                      inceleyin.

  Step düğmesine basınca komut        Step'in tek bir mikroişlem adımı
  tamamlanmıyor.                      ilerlettiğini unutmayın. Komut
                                      tamamlanana kadar ilerlemeye devam
                                      edin.

  Sonuç bellekte görünmüyor.          `STA` komutunun yürütüldüğünü ve
                                      doğru hedef etiketin kullanıldığını
                                      Memory Explorer üzerinden kontrol
                                      edin.
  -----------------------------------------------------------------------

------------------------------------------------------------------------

## 8. Eğitim Amaçlı Kullanım ve Sınırlamalar

SUBÜ Mano Studio, Mano Basic Computer mimarisinin temel kavramlarını
görselleştirmek ve assembly programlarının yürütülmesini incelemek için
hazırlanmıştır.

-   Simülasyon tarayıcıda çalışır; gerçek bir işlemci veya FPGA üzerinde
    kod yürütmez.
-   Görselleştirilen mikroişlemler, uygulamanın mevcut simülasyon
    modeline dayanır.
-   Zamanlama ve bellek davranışları, farklı ders kitaplarındaki veya
    donanım tasarımlarındaki Mano uygulamalarıyla birebir aynı
    olmayabilir.
-   Bu nedenle yazılım, ders ve laboratuvar çalışmalarını destekleyen
    bir eğitim aracı olarak değerlendirilmelidir.

## 9. Katkı ve Geri Bildirim

Yazılımla ilgili hata bildirimleri, öneriler ve eğitim amaçlı geliştirme
fikirleri için GitHub deposunun **Issues** bölümünü kullanabilirsiniz.

Hata bildirirken mümkünse aşağıdaki bilgileri ekleyin:

-   Çalıştırdığınız assembly kodu
-   Aldığınız hata mesajı
-   Beklediğiniz sonuç
-   Gerçekleşen sonuç
-   Kullandığınız tarayıcı

------------------------------------------------------------------------

**SUBÜ Mano Studio --- Mano Basic Computer mimarisini adım adım
keşfedin.**
