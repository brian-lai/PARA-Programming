# [Project Name]

> **Workflow Methodology:** Follow `.cursorrules` for PARA-Programming methodology

---

## 📌 Quick Reference

| Property | Value |
|----------|-------|
| **Purpose** | [One-line project description] |
| **Tech Stack** | [e.g., React, TypeScript, Node.js, PostgreSQL] |
| **Primary Language** | [e.g., TypeScript] |
| **Architecture** | [e.g., Microservices, Monolith, Serverless] |
| **Repository** | [GitHub/GitLab URL] |

---

## 🎯 What This Project Does

[2-3 paragraphs explaining:
- What problem this project solves
- Who the users are
- Key features or capabilities]

---

## 🏗 Architecture Overview

### System Design

[High-level architecture description. Include:
- Main components and how they interact
- Data flow
- External services/dependencies]

### Key Components

- **Component A** (`src/path/a/`): [Purpose and responsibilities]
- **Component B** (`src/path/b/`): [Purpose and responsibilities]
- **Component C** (`src/path/c/`): [Purpose and responsibilities]

### Data Flow

```
[User/Client] → [API Gateway] → [Service Layer] → [Database]
                      ↓
                [External APIs]
```

[Explain the data flow in words]

---

## 🛠 Tech Stack Details

### Runtime & Frameworks
- **Runtime:** [Node.js 20.x / Python 3.11 / etc.]
- **Framework:** [Express.js / Next.js / FastAPI / etc.]
- **Language:** [TypeScript 5.x / Python 3.11 / etc.]

### Frontend (if applicable)
- **Framework:** [React 18 / Vue 3 / etc.]
- **State Management:** [Redux / Zustand / Context API]
- **Styling:** [Tailwind / CSS Modules / Styled Components]

### Backend
- **API Framework:** [Express / Fastify / etc.]
- **Authentication:** [JWT / OAuth / etc.]
- **Validation:** [Zod / Joi / etc.]

### Data Layer
- **Database:** [PostgreSQL 15 / MongoDB 6 / etc.]
- **ORM/Query Builder:** [Prisma / TypeORM / Mongoose]
- **Cache:** [Redis 7.x / Memcached]
- **Search:** [Elasticsearch / Algolia] (if applicable)

### Infrastructure
- **Hosting:** [AWS / GCP / Azure / Vercel / Railway]
- **CI/CD:** [GitHub Actions / GitLab CI / CircleCI]
- **Monitoring:** [DataDog / Sentry / New Relic]
- **Logging:** [Winston / Pino / CloudWatch]

---

## 📂 Code Organization

```
src/
├── api/              # HTTP endpoints and route handlers
├── services/         # Business logic layer
├── models/           # Data models and schemas
├── lib/              # Shared utilities and helpers
├── middleware/       # Express/API middleware
├── config/           # Configuration files
├── types/            # TypeScript type definitions
└── tests/            # Test suites
```

### Key Files & Directories

| Path | Purpose |
|------|---------|
| `src/api/routes.ts` | [Main API route definitions] |
| `src/services/UserService.ts` | [User business logic] |
| `src/lib/db.ts` | [Database connection setup] |
| `src/config/env.ts` | [Environment configuration] |
| `src/middleware/auth.ts` | [Authentication middleware] |

---

## 🎨 Conventions & Standards

### Code Style
- **Formatting:** Prettier (see `.prettierrc`)
- **Linting:** ESLint (see `.eslintrc`)
- **Naming Conventions:**
  - Variables/Functions: `camelCase`
  - Classes/Types: `PascalCase`
  - Constants: `UPPER_SNAKE_CASE`
  - Files: `kebab-case` or `PascalCase` (for components)

### Git Practices
- **Branch naming:** `feature/description`, `fix/description`, `refactor/description`
- **Commit style:** [Conventional Commits](https://www.conventionalcommits.org/)
  - `feat:` New feature
  - `fix:` Bug fix
  - `refactor:` Code refactoring
  - `docs:` Documentation
  - `test:` Tests
  - `chore:` Maintenance
- **PR requirements:**
  - [ ] Tests passing
  - [ ] Code reviewed
  - [ ] Documentation updated

### File Organization
- Co-locate tests with source (`*.test.ts` next to `*.ts`)
- Group by feature, not by type
- Keep files under 300 lines when possible

### Import Order
1. External dependencies (`react`, `express`, etc.)
2. Internal absolute imports (`@/services`, `@/lib`)
3. Relative imports (`./Component`, `../utils`)

---

## 🧪 Testing Strategy

### Framework
- **Unit Tests:** [Jest / Vitest / pytest]
- **Integration Tests:** [Supertest / Testing Library]
- **E2E Tests:** [Playwright / Cypress / Selenium]

### Coverage Target
- **Overall:** >80%
- **Critical paths:** >90%
- **New code:** >85%

### Test Location
- Co-located with source: `src/services/UserService.test.ts`
- Integration tests: `tests/integration/`
- E2E tests: `tests/e2e/`

### Running Tests

```bash
# Run all tests
npm test

# Run specific test file
npm test UserService

# Run with coverage
npm run test:coverage

# Run in watch mode
npm run test:watch
```

---

## 🔌 External Integrations

### APIs & Services
- **[Service A]:** [Purpose] - Auth: [API Key/OAuth] - [Docs URL]
- **[Service B]:** [Purpose] - Auth: [API Key/OAuth] - [Docs URL]

### Authentication
- **Provider:** [Auth0 / Firebase / Custom JWT]
- **Strategy:** [OAuth2 / JWT / Session]

### Payment Processing (if applicable)
- **Provider:** [Stripe / PayPal / etc.]

### Email (if applicable)
- **Provider:** [SendGrid / Mailgun / etc.]

---

## 🌍 Environment Variables

Key environment variables (see `.env.example` for full list):

### Required
- `DATABASE_URL` - PostgreSQL connection string
- `REDIS_URL` - Redis connection string
- `JWT_SECRET` - Secret for JWT signing
- `API_KEY_X` - External service API key

### Optional
- `LOG_LEVEL` - Logging level (default: `info`)
- `PORT` - Server port (default: `3000`)

---

## 🚀 Development Workflow

### Initial Setup

```bash
# Clone repository
git clone [repo-url]
cd [project-name]

# Install dependencies
npm install

# Setup environment
cp .env.example .env
# Edit .env with your values

# Run database migrations
npm run migrate

# Seed database (if applicable)
npm run seed

# Start development server
npm run dev
```

### Common Commands

| Command | Description |
|---------|-------------|
| `npm run dev` | Start development server with hot reload |
| `npm run build` | Build for production |
| `npm start` | Start production server |
| `npm test` | Run test suite |
| `npm run test:watch` | Run tests in watch mode |
| `npm run lint` | Lint code |
| `npm run format` | Format code with Prettier |
| `npm run migrate` | Run database migrations |
| `npm run migrate:rollback` | Rollback last migration |

### Development Server

```bash
npm run dev
# Server runs on http://localhost:3000
# API available at http://localhost:3000/api
```

---

## 📚 Domain Knowledge

### Business Logic

[Explain key business rules or domain concepts that developers need to understand:
- Important workflows
- Business constraints
- Domain terminology]

### Terminology

- **[Term A]:** [Definition and usage in this project]
- **[Term B]:** [Definition and usage in this project]
- **[Term C]:** [Definition and usage in this project]

---

## 🔍 Troubleshooting Common Issues

### Issue 1: Database Connection Fails

**Symptoms:** `ECONNREFUSED` when starting server

**Solution:**
1. Ensure PostgreSQL is running: `brew services start postgresql` (Mac)
2. Check DATABASE_URL in `.env`
3. Verify database exists: `psql -l`

### Issue 2: Tests Failing After Fresh Clone

**Symptoms:** Multiple test failures

**Solution:**
1. Install dependencies: `npm install`
2. Setup test database: `npm run migrate:test`
3. Clear test cache: `npm test -- --clearCache`

### Issue 3: [Add project-specific issues]

**Symptoms:** [What you see]

**Solution:**
[How to fix]

---

## 🔐 Security Considerations

### Authentication
- All API routes require authentication except `/health` and `/metrics`
- JWT tokens expire after 1 hour
- Refresh tokens expire after 30 days

### Authorization
- Role-based access control (RBAC)
- Permissions checked at route level and service level

### Data Protection
- Sensitive data encrypted at rest
- PII handling follows [GDPR/CCPA/etc.]
- All external API calls use HTTPS

### Input Validation
- All user input validated with [Zod/Joi/etc.]
- SQL injection prevention via parameterized queries
- XSS prevention via input sanitization

---

## 📖 Additional Resources

### Documentation
- [API Documentation] - [Link to Swagger/OpenAPI]
- [Component Library] - [Link to Storybook]
- [Team Wiki] - [Link to Notion/Confluence]

### Design
- [Design System] - [Link to Figma/etc.]
- [Brand Guidelines] - [Link]

### Monitoring
- [Production Dashboard] - [Link to DataDog/Grafana]
- [Error Tracking] - [Link to Sentry]

### Related Repositories
- [Frontend Repo] - [Link]
- [Mobile App Repo] - [Link]
- [Shared Libraries] - [Link]

---

## 🤝 Contributing

### Before Submitting PR

1. Create a plan in `context/plans/` using PARA methodology
2. Get plan approved
3. Implement following the plan
4. Create summary in `context/summaries/`
5. Ensure all tests pass
6. Update documentation if needed

### Code Review Process

- All PRs require at least 1 approval
- Address review comments promptly
- Keep PRs focused and reasonably sized

---

## 📞 Getting Help

- **Team Chat:** [Slack channel / Discord / etc.]
- **Tech Lead:** [Name / Contact]
- **Documentation Questions:** [Contact / Channel]
- **Bug Reports:** [GitHub Issues / Jira]

---

## 🗺 Roadmap

### Current Sprint
- [Feature 1]
- [Feature 2]
- [Bug fix 1]

### Next Sprint
- [Feature 3]
- [Feature 4]

### Long-term
- [Major initiative 1]
- [Major initiative 2]

---

**Last Updated:** [YYYY-MM-DD]
**Maintained by:** [Team/Person]
