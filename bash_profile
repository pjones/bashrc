#!/bin/bash

# All interactive shells should use ~/.bashrc:
case "$-" in
  *i*) source ~/.bashrc
       ;;
esac
