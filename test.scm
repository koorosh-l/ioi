#! /bin/sh
# -*- mode: scheme; coding: utf-8 -*-
exec guile -L ./ -e main -s "$0" "$@"
!#
(use-modules (uinput)
	     (key-codes))

(define (main . a)
  (let ([fd (make-device "hello" `(,(car (assoc-ref keys 'KEY_SPACE))))])
    (sleep 10)
    (distroy-device fd)))
