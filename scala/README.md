# Scala Actions

The scala folder contains a collection of GitHub Actions designed for building, testing, and managing Scala projects using SBT (Scala Build Tool). These actions provide a complete toolkit for Scala development workflows in GitHub Actions, from environment setup to testing with coverage reporting.

## Available Actions

### 1. **Setup** (`/scala/setup`)

Sets up the development environment for Scala projects.

**Features:**
- Installs JDK 25 (configurable distribution: zulu, temurin, etc.)
- Sets up SBT with caching enabled
- Configurable Java version (default: 25)

**Inputs:**
- `distribution`: JDK vendor (default: `zulu`)
- `java-version`: Java version to setup (default: `"25"`)

**Usage:**

```yaml
- name: Set up Scala environment
  uses: LedgerHQ/actions/scala/setup@main
  with:
    distribution: zulu
    java-version: "25"
```

### 2. **SBT Compile** (`/scala/sbt`)

Compiles Scala projects with caching and optimization.

**Features:**
- Configurable Scala version support
- Memory limit configuration (default: 2048 MB)
- Compilation caching with cache key management
- Custom script execution or default compile commands
- Compiles both main and test sources by default
- Cache upload functionality

**Inputs:**
- `scala-version`: Scala version to use (e.g., 2.13.8)
- `memory-limit`: Memory limit for sbt (default: `"2048"`)
- `cache-key`: Cache key (default: `target`)
- `upload-cache`: Upload cache after compilation (default: `"true"`)
- `script`: Custom script to run instead of default compile
- `command`: Compile command to run (default: `compile; Test / compile`)

**Outputs:**
- Standard SBT compilation outputs

**Usage:**

```yaml
- name: Compile Scala project
  uses: LedgerHQ/actions/scala/sbt@main
  with:
    scala-version: "2.13.8"
    memory-limit: "4096"
    cache-key: "my-project"
```

### 3. **Restore Compilation Cache** (`/scala/restore-compilation-cache`)

Restores previously cached compilation artifacts to speed up builds.

**Features:**
- Restores main compilation cache (target directories)
- Restores test compilation cache separately
- Multi-level cache key strategy with fallbacks
- Based on `build.sbt` and source file hashes

**Inputs:**
- `key`: Cache key (default: `target`)

**Outputs:**
- `cache-hit`: Whether cache was found and restored

**Usage:**

```yaml
- name: Restore compilation cache
  uses: LedgerHQ/actions/scala/restore-compilation-cache@main
  with:
    key: "my-project"
```

## Common Features

### Caching Strategy

All actions implement intelligent compilation cache management to speed up builds:
- Main compilation cache for source files
- Separate test compilation cache
- Multi-level cache keys with fallbacks based on:
  - `build.sbt` hash
  - Source file hashes
  - Custom cache keys

### Performance Optimization

- **Memory Management**: Configurable JVM memory limits
- **Incremental Compilation**: Leverages SBT's incremental compilation
- **Cache Reuse**: Aggressive caching of compilation artifacts
- **Parallel Execution**: Optimized for CI/CD pipeline performance

### Integration Support

- **GitHub**: Native GitHub Actions integration
- **Multi-Scala Version**: Support for Scala 2.13, 3.x, and others

## Example Workflow

Here's a complete example of using these actions in a GitHub workflow:

```yaml
name: Scala CI

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        scala-version: ["2.13", "3"]

    steps:
    - name: Checkout code
      uses: actions/checkout@v4

    - name: Set up Scala environment
      uses: LedgerHQ/actions/scala/setup@main
      with:
        java-version: "25"

    - name: Restore compilation cache
      uses: LedgerHQ/actions/scala/restore-compilation-cache@main
      with:
        key: "ci-${{ matrix.scala-version }}"

    - name: Compile project
      uses: LedgerHQ/actions/scala/sbt@main
      with:
        scala-version: ${{ matrix.scala-version }}
        cache-key: "ci-${{ matrix.scala-version }}"

```

## Notes

- **Cache Skipping**: Add `ci:skip-cache` to your PR body to skip cache lookup during development
- **Memory Requirements**: Adjust memory limits based on your project size and CI environment
- **Java Version**: All actions default to JDK 25 but are configurable for other versions
