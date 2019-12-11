#!/bin/sh

find / -type f -exec rpm -q --whatprovides {} \; |grep " package"

