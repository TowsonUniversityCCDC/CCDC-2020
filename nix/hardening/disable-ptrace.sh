#!/bin/sh

# https://linux-audit.com/protect-ptrace-processes-kernel-yama-ptrace_scope/
# ...
# cat /proc/sys/kernel/yama/ptrace_scope
# 1
#
# For this particular key there are four valid options: 0-3
#
#    kernel.yama.ptrace_scope = 0: all processes can be debugged, as long as they have same uid. This is the classical way of how ptracing worked.
#    kernel.yama.ptrace_scope = 1: only a parent process can be debugged.
#    kernel.yama.ptrace_scope = 2: Only admin can use ptrace, as it required CAP_SYS_PTRACE capability.
#    kernel.yama.ptrace_scope = 3: No processes may be traced with ptrace. Once set, a reboot is needed to enable ptracing again.

PTRACE_SCOPE="/proc/sys/kernel/yama/ptrace_scope"

echo "[+] Disabling ptrace"
echo -n "  Current value of ${PTRACE_SCOPE}: "
cat $PTRACE_SCOPE

echo 3 >$PTRACE_SCOPE
