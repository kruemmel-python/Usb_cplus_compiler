# KR Portable C++ MultiHost Compiler v1.0

USB-portabler C/C++-Compiler für Linux x86-64 und Windows x86-64 ohne Installation, Adminrechte, globale PATH-Änderung oder Registry-Setup.

## Linux x86-64

Der Linux-Pfad ist EDG-basiert und wurde End-to-End ausgeführt:

`C++ -> EDG cpfe 7.0 -> C-generating backend -> portables GCC-Backend -> ELF -> Ausführung`

Start:

```bash
chmod +x START-LINUX.sh kr-compile-linux.sh SELFTEST-LINUX.sh SELFTEST-LINUX-PORTABLE.sh
./START-LINUX.sh
```

Portabler Selbsttest:

```bash
./SELFTEST-LINUX-PORTABLE.sh
```

## Windows x86-64

Start:

```text
START-WINDOWS.cmd
```

Selbsttest:

```text
SELFTEST-WINDOWS.cmd
```

Der Windows-Pfad nutzt eine portable LLVM-MinGW/UCRT-Toolchain. Beim ersten Windows-Start wird sie direkt in `host/windows-x64/toolchain` auf dem USB-Laufwerk geladen und vor Verwendung per SHA-256 geprüft. Es wird nichts in Windows installiert. Danach kann die Windows-Seite offline vom USB verwendet werden.

Direkter Aufruf:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\KR-Windows.ps1 -Source .\src\hello.cpp -Std c++23 -Run
```

## Unterstützte Standards

- C++17
- C++20
- C++23

## Status v1.0

- Linux x86-64: End-to-End getestet
- Windows x86-64: One-Click-Bootstrap und nativer Self-Test enthalten; Windows-Ausführung muss auf einem Windows-Host erfolgen

## Lizenzen und Drittanbieter-Komponenten

Der EDG C/C++ Compiler Project wurde am 30. September 2026 als Open Source veröffentlicht. Der aktuelle Upstream `edgcpp/compiler` steht unter **Apache License 2.0 with LLVM Exceptions**. Diese Lizenz erlaubt die Weitergabe sowohl in Source- als auch Object-/Binary-Form, sofern die Lizenz- und Attributionsbedingungen eingehalten werden.

Für EDG-Binärdistributionen dieses Projekts muss deshalb die EDG/LLVM-Lizenz mitgeliefert werden. Geänderte EDG-Dateien müssen entsprechend als geändert gekennzeichnet werden. EDG-Markenzeichen werden dadurch nicht lizenziert.

Die KR-eigenen Projektdateien können unter der Repository-Lizenz stehen; eingebettete oder heruntergeladene Drittanbieter-Komponenten behalten ausdrücklich ihre jeweiligen eigenen Lizenzen. Eine Repository-Lizenz überschreibt diese Drittanbieter-Lizenzen nicht.

Upstream EDG: https://github.com/edgcpp/compiler

EDG Open-Source-Information: https://edgcpp.org/
