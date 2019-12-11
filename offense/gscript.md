# gscript
Gscript is a malware dropper. The concept is basically duct taping a big ball of malware together,
throwing it at a system, and seeing what sticks.

Payloads are written in JavaScript with a superset of common OS functions, and the ability to import
and hook golang libraries at compile time. There are ways to make the malware contextually aware and
not detonate at all, or to skip certain payloads depending on the target.

The dropper is a static-linked binary that will run all of the payloads that you've bundled into it.

https://github.com/gen0cide/gscript -- Project's GitHub repo with install/basic usage instructions.

https://github.com/ahhh/gscripts -- Examples of gscript payloads


https://www.youtube.com/watch?v=8yjMlMf8NpQ -- Presentation about Gscript at DEF CON 26
