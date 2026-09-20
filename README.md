# 🎯 SensFinder — CS2 & Valorant

> **Find your ideal mouse sensitivity through real gameplay — not guesswork.**
> Binary search algorithm + 3D aim scenarios + progressive rounds, all in one file.

[![Live Demo](https://img.shields.io/badge/Live%20Demo-Visit%20Site-e8ff47?style=for-the-badge&labelColor=070708&color=e8ff47&logoColor=black)](https://rasne-dev.github.io/SensFinder)
[![License: MIT](https://img.shields.io/badge/License-MIT-555?style=for-the-badge&labelColor=070708)](LICENSE)
[![Version](https://img.shields.io/badge/version-1.1.2-e8ff47?style=for-the-badge&labelColor=070708)](https://github.com/rasne-dev/SensFinder/releases)
[![No Dependencies](https://img.shields.io/badge/Zero%20Dependencies-Single%20File-555?style=for-the-badge&labelColor=070708)]()

---

## 🌐 Live Demo

**[https://rasne-dev.github.io/SensFinder](https://rasne-dev.github.io/SensFinder)**

---

## ✨ How It Works

SensFinder uses a **binary search algorithm** across multiple aim scenarios to converge on the sensitivity you actually perform best at — not just one you think feels right.

### Test Structure & Disciplines

Each round evaluates three core aim disciplines:

| Mode | Discipline | What it tests |
|------|------------|---------------|
| ⚡ **Flick** | Reflex & Target Acquisition | Large, sudden target jumps |
| ⊞ **Gridshot** | Speed & Dynamic Switching | Sequential dynamic targets across grid, rapid switching |
| ◎ **Tracking** | Smoothness & Crosshair Placement | Smoothly moving target, cursor on-target time |

Each mode tests three phases: **LOW**, **HIGH**, and a **MID (verification)** sensitivity. Performance is normalized and weighted (Flick 35%, Gridshot 35%, Tracking 30%).

- **Round 1 (Initial Setup):** 9 phases (3 modes × 3 tests, ~2.3 min) establishing an accurate initial baseline.
- **Round 2+ (Quick Refinement):** 9 phases (3 modes × 3 tests, ~2 min) narrowing down the exact sweet spot.

### Progressive Refinement

```
Round 1  →  Baseline result, ~60–75% confidence  (~2.3 min)
Round 2  →  Narrowed range,  ~80–88% confidence  (~2 min)
Round 3+ →  Precise result,  ~90%+ confidence    (~2 min)
```

Run as many rounds as you want. Each one narrows the range further. Your progress is **saved automatically** — close the tab and resume later.

---

## 🎮 Supported Games

| | CS2 | Valorant |
|---|---|---|
| Yaw constant | 0.022 | 0.07 |
| Default FOV | 90 | 103 |
| Sensitivity range | 0.1 – 10 | 0.1 – 2.0 |
| Theme | Yellow-green | Purple |

Cross-game conversion is shown automatically on every result screen.

---

## 🖱️ Calibration

Don't know your current sensitivity? Use the built-in **mousepad calibration**:

1. Click **"Calibrate via 360° movement"**
2. Place your mouse at one edge of your pad
3. Slide to the opposite edge
4. Press **ESC** — your sensitivity is estimated automatically

---

## ⌨️ Controls

| Key / Action | Effect |
|---|---|
| **Left Click** | Shoot target |
| **Mouse Move** | Aim (pointer lock) |
| **ESC** | Pause / resume |
| **ESC (pause menu)** | End early or quit |

Pausing mid-test saves your progress. "End & Show Results" shows the best estimate from completed phases.

---

## 💾 Session Persistence

Every round result is saved to `localStorage`. If you close the browser mid-test, the main menu will show a **"Last Session"** banner with your last known best sensitivity and round number. One click resumes.

---

## 📐 Calculations

### eDPI
```
eDPI = DPI × Sensitivity
```

### cm/360°
```
cm/360° = (360 ÷ (yaw × sens)) ÷ DPI × 2.54
```

### Cross-game Conversion
```
Valorant = CS2_Sens × (0.022 ÷ 0.07)   →  × 0.3143
CS2      = VAL_Sens  × (0.07 ÷ 0.022)  →  × 3.182
```

---

## 🚀 Deployment

### GitHub Pages

```bash
git clone https://github.com/rasne-dev/SensFinder.git
cd SensFinder
```

Push your changes, then:
- **Settings → Pages → Source:** `main` branch, `/ (root)`
- Live at: `https://YOUR_USERNAME.github.io/SensFinder`

### Local

```bash
# Just open the file — no build step, no server needed
open index.html        # macOS
xdg-open index.html    # Linux
start index.html       # Windows
```

---

## 📁 Structure

```
SensFinder/
├── index.html      # Entire app — HTML, CSS, JS, Three.js scene
├── README.md       # This file
└── LICENSE         # MIT
```

---

## 🛠️ Tech Stack

| | |
|---|---|
| **Three.js r128** | 3D scene, targets, pointer lock |
| **Vanilla JS** | Binary search engine, test loop, i18n |
| **CSS custom properties** | Per-game theming (CS2 / Valorant) |
| **localStorage** | Session persistence |
| **Google Fonts** | DM Mono + Barlow |

Zero build tools. Zero npm. One HTML file.

---

## 🌍 Language
 
Full **Turkish / English** toggle in the UI. Language preference is saved automatically to `localStorage` (defaults to browser locale).

---

## 📜 License

MIT — see [LICENSE](LICENSE)

---

---

# 🇹🇷 Türkçe

## SensFinder Nedir?

SensFinder, mouse hassasiyetini **gerçek nişan senaryoları** üzerinden **binary search algoritması** ile bulan ücretsiz, tek dosyalık bir web uygulamasıdır. Tahmin yok — performansınla öğrenir.

---

## Nasıl Çalışır?

Her tur, üç temel nişan disiplinini arka arkaya test eder:

| Mode | Disiplin | Neyi Test Eder? |
|-----|----------|-----------------|
| ⚡ **Flick** | Refleks & Hedef Yakalama | Ani ve geniş açılı hedef sıçramaları |
| ⊞ **Gridshot** | Hız & Seri Hedef Geçişi | Grid üzerinde ardışık beliren hedefler, seri geçiş |
| ◎ **Tracking** | Pürüzsüzlük & Crosshair Kontrolü | Akıcı hareket eden hedef, crosshair'i hedefte tutma |

Her mod için **DÜŞÜK**, **YÜKSEK** ve **ORTA (doğrulama)** olmak üzere 3 test aşaması uygulanır. Skorlar modun teorik tavanına göre normalize edilir ve ağırlıklandırılır (Flick %35, Gridshot %35, Tracking %30).

- **1. Tur (İlk Kurulum):** 9 aşama (3 mod × 3 test, ~2.3 dk) ile hızlı ve doğru bir temel aralık oluşturur.
- **2+ Tur (Hızlı İnce Ayar):** 9 aşama (3 mod × 3 test, ~2 dk) ile hassasiyeti tam noktasına oturtur.

### Aşamalı İyileştirme

```
Tur 1   →  Temel sonuç,   ~%60–75 güven  (~2.3 dk)
Tur 2   →  Daraltılmış,   ~%80–88 güven  (~2 dk)
Tur 3+  →  Kusursuz ayar, ~%90+ güven    (~2 dk)
```

Her tur aralığı daha da daraltır. İlerlemeniz **otomatik olarak kaydedilir** — sekmeyi kapatıp dilediğinizde devam edebilirsiniz.

---

## Kontroller

| Tuş / Eylem | İşlev |
|---|---|
| **Sol Tık** | Hedefe ateş et |
| **Fare Hareketi** | Nişan al (pointer lock) |
| **ESC** | Duraklat / devam et |
| **ESC (pause menüsü)** | Erken bitir veya çık |

---

## Oturum Kaydı

Her tur sonunda ilerleme `localStorage`'a kaydedilir. Tarayıcıyı kapatıp açarsan ana menüde **"Son Oturum"** banner'ı çıkar — tek tıkla kaldığın yerden devam edersin.

---

## Kalibrasyon

Mevcut hassasiyetini bilmiyorsan:
1. **"360° mousepad hareketi ile kalibre et"** butonuna tıkla
2. Fareyi pad'in bir kenarına koy, karşı kenara sürükle
3. **ESC** — hassasiyet otomatik hesaplanır

---

## GitHub Pages'e Yükleme

```bash
git clone https://github.com/rasne-dev/SensFinder.git
cd SensFinder
```

Değişikliklerini push'ladıktan sonra:
- **Settings → Pages → Source:** `main` branch, `/ (root)`
- Adresin: `https://KULLANICI_ADIN.github.io/SensFinder`

### Yerel Kullanım

`index.html` dosyasını doğrudan tarayıcıda aç. Kurulum gerekmez.

---

## Lisans

MIT — bkz. [LICENSE](LICENSE)