# Newman API Test Report Template

## Informasi Umum

- Nama project: API Stress Test Portfolio
- Tool: Newman
- Collection: `newman_health_stress_collection.json`
- Environment: `newman_health_env.json`
- Tanggal eksekusi: `2026-04-17`
- Endpoint yang diuji: `GET /health-check`
- Base URL: `https://practice.expandtesting.com/notes/api`

## Objective

Melakukan repeated execution pada endpoint health check untuk mengamati stabilitas status code, assertion result, dan response time dasar menggunakan Newman.

## Scope

- Jenis test: repeated API execution / light stress test
- Endpoint: `/health-check`
- Method: `GET`
- Validasi utama:
  - status code `200`
  - response time di bawah threshold
  - response body tidak kosong

## Test Setup

- Iterations baseline: `1`
- Iterations stress ringan: `20`
- Delay per request: `100 ms`
- Reporter: `cli,json`
- Threshold response time: `2000 ms`

## Command yang Digunakan

Baseline:

```powershell
newman run .\newman_health_stress_collection.json -e .\newman_health_env.json
```

Stress ringan:

```powershell
newman run .\newman_health_stress_collection.json -e .\newman_health_env.json -n 20 --delay-request 100 --reporters "cli,json" --reporter-json-export .\reports\health-20-latest.json
```

## Hasil Aktual

### Baseline Run

- Requests: `1`
- Assertions: `3`
- Failed assertions: `0`
- Response time: `1374 ms`
- Status: `PASS`

### Light Stress Run

- Iterations: `20`
- Requests: `20`
- Assertions: `60`
- Failed assertions: `0`
- Average response time: `366 ms`
- Minimum response time: `273 ms`
- Maximum response time: `858 ms`
- Standard deviation: `120 ms`
- Total duration: `11.6 s`
- Status: `PASS`

## Analisis

- Semua request mengembalikan status `200 OK`.
- Tidak ada assertion yang gagal pada baseline maupun stress ringan.
- Response time rata-rata berada jauh di bawah threshold `2000 ms`.
- Terdapat spike maksimum hingga `858 ms`, tetapi masih dalam batas threshold yang ditentukan.
- Untuk skala pembelajaran, endpoint health check terlihat stabil pada repeated execution 20 iterasi.

## Kesimpulan

Endpoint `GET /health-check` menunjukkan hasil stabil pada pengujian Newman skala ringan. Newman cukup efektif untuk validasi API dasar, regression ringan, dan observasi performa awal. Untuk concurrency tinggi atau load test yang lebih realistis, tool khusus seperti k6 atau JMeter lebih sesuai.

## Evidence

- Guide: `NEWMAN_STRESS_TEST_GUIDE.md`
- Collection demo: `newman_health_stress_collection.json`
- Main collection updated: `collection_api_management.json`
- Runner: `run_newman_stress.ps1`
- JSON report: `reports/health-20-latest.json`

## Improvement Plan

1. Tambahkan assertion ke endpoint autentikasi dan notes flow yang aman.
2. Buat data test unik agar flow create note bisa dijalankan berulang tanpa konflik.
3. Tambahkan HTML reporter untuk bukti visual yang lebih rapi.
4. Bandingkan hasil Newman dengan tool load test khusus.
