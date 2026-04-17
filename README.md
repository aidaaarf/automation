# QA Automation

Automated End-to-End (E2E) & API testing platform. Built with **Playwright** and **TypeScript** to ensure messaging reliability, broadcast template integrity, and UI consistency.

## 🛠️ Technology Stack

- **Framework**: [Playwright](https://playwright.dev/)
- **Language**: [TypeScript](https://www.typescriptlang.org/)
- **Environment Management**: dotenv
- **CI/CD Ready**: Automated reporting and failure screenshots.

## 📋 Prerequisites

- [Node.js](https://nodejs.org/) (v16 or higher)
- npm or yarn

## ⚙️ Installation

1. Install dependencies:
   ```bash
   npm install
   ```

2. Install Playwright browsers:
   ```bash
   npx playwright install
   ```

## 🔐 Configuration

Create a `.env` file in the root directory based on `.env.example`:

```env
TEST_USERNAME=your_username
TEST_PASSWORD=your_password
BASE_URL=https://app.test.id
```

## 🧪 Running Tests

### Execute all tests
```bash
npx playwright test
```

### Run tests for specific feature (e.g., Broadcast)
```bash
npx playwright test tests/feature/
```

### Run tests in UI mode
```bash
npx playwright test --ui
```

### View HTML Report
```bash
npx playwright show-report
```

## 🎯 Running Tests Individually

### Run a specific test file
```bash
npx playwright test tests/feature/filter.spec.ts
```

### Run a specific test suite (describe block)
```bash
npx playwright test tests/feature/filter.spec.ts -g 
```

### Run a single test case by name
```bash
npx playwright test tests/feature/filter.spec.ts -g 
```

### Run tests in headed mode (visible browser)
```bash
npx playwright test tests/feature/test.spec.ts --headed
```

### Run tests in debug mode
```bash
npx playwright test tests/feature/test.spec.ts --debug
```

### Run tests with specific browser
```bash
npx playwright test tests/feature/test.spec.ts --project=chromium
npx playwright test tests/feature/test.spec.ts --project=firefox
npx playwright test tests/feature/test.spec.ts --project=webkit
```

### Run tests with trace enabled
```bash
npx playwright test tests/feature/test.spec.ts --trace on
```

### Combining Options
```bashin headed mode with trace
npx playwright test tests/feature/test.spec.ts -g "TC-CF-007" --headed --trace on

# Run test suite in debug mode
npx playwright test tests/feature/test.spec.ts -g "Channel Filter" --debug
```


## 📁 Project Structure

- `tests/`: Test specifications grouped by feature.
- `src/pages/`: Page Object Models (POM) for encapsulated UI logic.
- `docs/`: Comprehensive test case documentation and debugging guides.
- `playwright.config.ts`: Main framework configuration.

## 📊 Test Dashboard

A beautiful, real-time dashboard to visualize test results is included. After running tests, a JSON report is automatically generated.

### Open Dashboard
```bash
npm run dashboard
```

### Dashboard Features
- **KPI Cards**: Total tests, passed, failed, pass rate
- **Suite Breakdown**: Expandable test suites with individual results
- **Trend Chart**: Pass rate over last 10 runs
- **Failure Details**: Click failed tests to see error messages and stack traces
- **Filtering**: Filter by status (Passed/Failed/Flaky) or search by test name

The dashboard uses demo data by default. Run your tests to generate real data in `dashboard/history/`.

---
