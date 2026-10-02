# KR Portable C++ MultiHost Compiler v1.1 OFFLINE

Vollständig portabler USB-C/C++-Compiler für Linux x86-64 und Windows x86-64 ohne Installation, Adminrechte, globale PATH-Änderung oder Registry-Setup.

## Windows x86-64 – vollständig offline

Die Windows-Toolchain ist ab v1.1 bereits im Distributionspaket enthalten. Beim ersten Start ist **kein Download und keine Internetverbindung mehr erforderlich**.

Start:

```text
START-WINDOWS.cmd
```

Selbsttest:

```text
SELFTEST-WINDOWS.cmd
```

Direkter Aufruf:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\KR-Windows.ps1 -Source .\src\hello.cpp -Std c++23 -Run
```

Enthalten ist LLVM-MinGW/UCRT 20260922 (LLVM 23.1.2) unter `host/windows-x64/toolchain`. Das Originalarchiv wurde vor Integration geprüft:

`SHA-256 e3ad77d117a4bea19a7a3b333341824d79a5a371004a10e25b8504e7b3047666`

Es werden weder Visual Studio, CMake noch Python benötigt.

## Linux x86-64

Der Linux-Pfad ist EDG-basiert:

`C++ -> EDG cpfe 7.0 -> C-generating backend -> portables GCC-Backend -> ELF -> Ausführung`

```bash
chmod +x START-LINUX.sh kr-compile-linux.sh SELFTEST-LINUX.sh SELFTEST-LINUX-PORTABLE.sh
./START-LINUX.sh
```

Portabler Selbsttest:

```bash
./SELFTEST-LINUX-PORTABLE.sh
```

## Unterstützte Standards

- C++17
- C++20
- C++23

## Teststatus v1.1

Linux x86-64 wurde erneut End-to-End getestet. Templates, Exceptions, C++20 und C++23 liefern PASS. Die vollständige Windows-x64-Toolchain ist eingebettet und der native Windows-Selftest ist enthalten. Eine Windows-EXE kann in der Linux-Buildumgebung nicht nativ ausgeführt werden; `SELFTEST-WINDOWS.cmd` führt diesen letzten Test auf einem Windows-Host durch.

## USB-Nutzung

`KR-Portable-CPP-MultiHost_v1.1-OFFLINE.zip` vollständig auf den USB-Stick entpacken. Danach genügt unter Windows ein Doppelklick auf `START-WINDOWS.cmd`. `compiler-main.zip` wird für die Nutzung nicht benötigt.

## Lizenzen und Drittanbieter-Komponenten

EDG C/C++ Compiler Project: Apache License 2.0 with LLVM Exceptions. LLVM/LLVM-MinGW und weitere Drittanbieter-Komponenten behalten ihre jeweiligen Lizenzen. Die entsprechenden Lizenz- und Attributionsbedingungen müssen bei Binärdistributionen erhalten bleiben.

Upstream EDG: https://github.com/edgcpp/compiler

LLVM-MinGW: https://github.com/mstorsjo/llvm-mingw
