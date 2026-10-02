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

## Lizenzhinweis

Dieses Repository steht unter AGPL-3.0. Mitgelieferte oder optional heruntergeladene Drittanbieter-Komponenten behalten ihre jeweiligen eigenen Lizenzen. Insbesondere dürfen EDG-Komponenten nur veröffentlicht bzw. weiterverteilt werden, wenn die jeweilige EDG-Lizenz dies ausdrücklich erlaubt.
