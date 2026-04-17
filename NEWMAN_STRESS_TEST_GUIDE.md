# Newman Stress Test Portfolio Guide

## Tujuan

Fokus awal yang disarankan:

- mulai dari endpoint yang aman dan tidak mengubah data
- hasilnya mudah dijelaskan saat interview
- ada bukti command, report, dan kesimpulan

Untuk koleksi yang ada sekarang, endpoint paling aman untuk latihan adalah:

- `Health / Health Check`

Endpoint yang sebaiknya tidak dipakai dulu untuk stress test pemula:

- `Register`
- `Delete Account`
- `Create Note`
- `Delete Note`
- request lain yang membuat atau menghapus data

## Kondisi File Saat Ini

File utama yang sudah ada:

- `collection_api_management.json`

Catatan penting:

- koleksi ini sudah punya variable `baseUrl`, `token`, `noteId`, dan `resetToken`
- request `Login` menyimpan `token`
- request `Create Note` menyimpan `noteId`
- sebagian besar request belum punya assertion `pm.test(...)`

Artinya, kalau langsung dijalankan di Newman, hasilnya belum kuat sebagai portfolio testing karena belum banyak validasi.

## Tools yang Dibutuhkan

Pastikan `node` dan `npm` tersedia. Di mesin ini keduanya sudah ada.

Install Newman:

```powershell
npm install -g newman
```

Cek versi:

```powershell
newman -v
```

Opsional, kalau ingin report HTML:

```powershell
npm install -g newman-reporter-htmlextra
```

## File Tambahan di Folder Ini

Saya tambahkan file berikut:

- `newman_health_stress_collection.json`
- `newman_health_env.json`
- `run_newman_stress.ps1`

Tujuannya:

- koleksi khusus stress test yang aman
- ada assertion dasar
- ada runner yang lebih gampang dipakai

## Langkah Belajar yang Disarankan

### 1. Jalankan sekali dulu

Ini untuk memastikan request dasar berhasil.

```powershell
newman run .\newman_health_stress_collection.json -e .\newman_health_env.json
```

Yang perlu kamu lihat:

- status request sukses
- assertion lolos
- response time tampil

### 2. Jalankan berkali-kali

Ini tahap paling mudah untuk simulasi load ringan.

```powershell
newman run .\newman_health_stress_collection.json -e .\newman_health_env.json -n 20 --delay-request 100 --reporters "cli,json" --reporter-json-export .\reports\health-20.json
```

Arti command:

- `-n 20`: jalankan 20 iterasi
- `--delay-request 100`: jeda 100 ms antar request
- `--reporters "cli,json"`: tampil di terminal dan simpan report JSON

### 3. Jalankan dengan script PowerShell

Lebih nyaman untuk portfolio karena parameter bisa diubah.

```powershell
.\run_newman_stress.ps1 -Iterations 50 -DelayMs 100 -ReportDir .\reports
```

### 4. Naikkan beban secara bertahap

Contoh skenario yang aman:

1. `10` iterasi
2. `50` iterasi
3. `100` iterasi
4. `250` iterasi

Jangan langsung lompat ke angka besar tanpa baseline.

## Memahami Keterbatasan Newman

Newman cocok untuk:

- collection run
- regression API
- data-driven test
- load ringan sampai menengah untuk demo pembelajaran

Newman bukan tool load test murni seperti k6 atau JMeter.

Hal penting:

- `iteration` bukan concurrency
- kalau kamu ingin request paralel, biasanya perlu menjalankan beberapa proses Newman sekaligus dari shell

Untuk portfolio pemula, itu sudah cukup. Kamu bisa tulis dengan jujur:

- Newman dipakai untuk repeated execution dan basic performance observation
- bukan untuk high-scale load test

## Contoh Skenario Portfolio

### Skenario 1: Baseline Check

Tujuan:

- memastikan endpoint sehat dan stabil

Command:

```powershell
newman run .\newman_health_stress_collection.json -e .\newman_health_env.json -n 10
```

Output yang dicatat:

- total request
- jumlah pass/fail
- response time min, max, average

### Skenario 2: Light Stress

Tujuan:

- melihat kestabilan endpoint saat dipanggil berulang

Command:

```powershell
newman run .\newman_health_stress_collection.json -e .\newman_health_env.json -n 100 --delay-request 50 --reporters "cli,json" --reporter-json-export .\reports\health-100.json
```

### Skenario 3: Multi-Process Demo

Kalau ingin simulasi beban lebih tinggi, kamu bisa buka beberapa terminal dan jalankan command yang sama bersamaan.

Contoh:

- Terminal 1: `50` iterasi
- Terminal 2: `50` iterasi
- Terminal 3: `50` iterasi

Catatan:

- ini pendekatan sederhana
- hasilnya cukup untuk demo belajar
- jangan klaim ini sebagai enterprise load test

## Struktur Portfolio yang Bagus

Kalau nanti mau dimasukkan ke portofolio atau laporan, isi minimalnya:

### 1. Objective

Contoh:

> Melakukan repeated API execution pada endpoint health check menggunakan Newman untuk mengamati kestabilan respons, status code, dan waktu respons dasar.

### 2. Scope

Contoh:

- endpoint: `/health-check`
- method: `GET`
- tools: Postman Collection, Newman, PowerShell

### 3. Test Setup

Contoh:

- collection: `newman_health_stress_collection.json`
- environment: `newman_health_env.json`
- iterations: `10`, `50`, `100`
- delay: `50-100 ms`

### 4. Result Summary

Isi yang bisa kamu tulis:

- semua request return `200`
- tidak ada assertion failure
- response time tetap berada di bawah threshold yang ditentukan
- saat iterasi meningkat, response time maksimum ikut naik atau tetap stabil

### 5. Conclusion

Contoh:

> Endpoint health check menunjukkan performa stabil pada repeated execution skala ringan. Newman efektif digunakan untuk validasi dasar dan observasi performa awal, namun untuk concurrency tinggi dibutuhkan tool khusus seperti k6 atau JMeter.

## Saran Peningkatan Berikutnya

Setelah paham baseline, baru naik level:

1. tambahkan assertion `pm.test` ke request lain
2. buat environment terpisah untuk `dev`, `staging`, dan `demo`
3. buat report HTML
4. coba jalankan beberapa proses Newman paralel
5. bandingkan hasil Newman dengan tool khusus load test

## Hal yang Sebaiknya Kamu Lakukan Sekarang

Urutan paling aman:

1. install Newman
2. jalankan 1 iterasi
3. jalankan 20-50 iterasi
4. simpan report JSON
5. tulis ringkasan hasil untuk portfolio

## Referensi Resmi

Dokumentasi resmi Newman:

- Postman Docs: https://learning.postman.com/docs/collections/using-newman-cli/newman-options/
- GitHub Newman: https://github.com/postmanlabs/newman
- Newman built-in reporters: https://learning.postman.com/docs/collections/using-newman-cli/newman-built-in-reporters/
