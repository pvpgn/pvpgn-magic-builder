@echo off


@echo off
if defined ProgramFiles(x86) (
@echo yes
@echo Some 64-bit work
) else (
@echo no
@echo Some 32-bit work
)
