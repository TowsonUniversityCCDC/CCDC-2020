#!/bin/sh

for pkg in $(rpm -qa); do rpm -V $pkg; done

