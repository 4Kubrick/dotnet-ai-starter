# AI Guide — .NET Project

This file is the shared source of truth for Claude Code and Codex.

## Principles
- Inspect the real repository before proposing changes.
- Respect target frameworks, package versions, existing architecture and backwards compatibility.
- Prefer the smallest safe change over broad rewrites.
- Do not introduce CQRS, MediatR, repositories, microservices or extra layers without a concrete need.
- Do not weaken tests, analyzers or quality gates to hide a defect.

## Default stack
Typical technologies include C#/.NET 8-10, .NET Framework 4.8, ASP.NET Core, EF Core, .NET MAUI, WinForms/DevExpress, SQL Server/PostgreSQL/SQLite, RabbitMQ, SignalR, Quartz.NET, Docker, NGINX and structured logging. Use only what the target repository actually contains.

## Development workflow
For non-trivial work:
1. Research the repository and relevant official documentation.
2. Write or update a plan under `docs/plans/`.
3. Implement in small, reviewable units.
4. Build and run focused tests.
5. Review correctness, security, performance and simplicity.
6. Update the plan/status and record durable decisions as ADRs under `docs/decisions/`.

## Shared continuity contract
Any AI tool switching work with another tool must persist handoff state in the repository, not only in chat context.

A plan should contain:
- Goal
- Status
- Tasks with checkboxes
- Decisions
- Changed files
- Validation
- Open risks / next step

Important accepted technical decisions belong in `docs/decisions/`.

## .NET validation
Discover the real solution/project first. Typical gate:
- `dotnet build <solution-or-project>`
- `dotnet test <relevant-tests> --no-build`
- analyzers/formatter if configured by the repository
- platform-specific validation for MAUI/WinForms when relevant

Never claim a command passed unless it was actually run successfully.

## C# / async
- Avoid sync-over-async.
- `async void` only for event handlers.
- Propagate `CancellationToken` through meaningful I/O.
- Handle nullability deliberately.
- Dispose resources correctly.
- Prefer clear code over clever abstractions.

## ASP.NET Core
- Validate input at boundaries.
- Enforce authorization server-side.
- Use correct DI lifetimes.
- Preserve external API contracts unless breaking change is intentional.
- Use structured logging and avoid secrets/PII in logs.

## EF Core / databases
- Avoid N+1 and premature materialization.
- Prefer projection for read models.
- Use no-tracking reads where appropriate.
- Parameterize SQL.
- Review migrations for existing-data and deployment impact.
- Do not assume SQL Server/PostgreSQL/SQLite behavior is identical.

## MAUI
- Keep UI thread responsive.
- Respect lifecycle, navigation and platform differences.
- Watch event subscriptions and memory retention.
- Measure CollectionView/binding performance before optimizing.
- Define offline/retry/conflict behavior explicitly.

## WinForms / DevExpress
- Preserve message-loop responsiveness and designer compatibility.
- Prefer focused changes in stable legacy code.
- Verify DevExpress APIs against the version actually used in the repository.
- Treat event lifetimes and disposal carefully.

## Council policy
Use a multi-expert council for expensive-to-reverse decisions, architecture/security/performance trade-offs, migrations, production incidents with competing hypotheses, or explicit requests for multiple perspectives. Persist accepted outcomes as an ADR when they affect the project long-term.
