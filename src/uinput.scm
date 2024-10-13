(define-module (uinput)
  #:use-module (key-codes)
  #:use-module (srfi srfi-26)
  #:use-module (system foreign)
  #:use-module (system foreign-library)
  #:export (make-device))
;;add non blocking
(define uinput "/dev/uinput")
(define flags (logior O_WRONLY O_NONBLOCK))

;; consts
(define EV_KEY #x1)
(define UI_SET_KEYBIT  1074025829)
(define UI_SET_EVBIT   1074025829)
(define UI_DEV_SETUP   1079792899)
(define UI_DEV_CREATE  21761)
(define UI_DEV_DESTROY 21762)

(define BUS     #x03)
(define VENDOR  #x1234)
(define PRODUCT #X5678)
(define VERSION #xfafb)
(define name "hello_test")
(define NAME (append (map char->integer (string->list name))
		     (make-list (- 79 (string-length name))
				0)
		     '(0)))

(define usetup (make-c-struct `(,uint16 ;;bustype
				,uint16 ;;vendor
				,uint16 ;;product
				,uint16 ;;version
				;;name[80]
				,int8 ,int8 ,int8 ,int8 ,int8 ,int8 ,int8 ,int8 ,int8 ,int8
				,int8 ,int8 ,int8 ,int8 ,int8 ,int8 ,int8 ,int8 ,int8 ,int8
				,int8 ,int8 ,int8 ,int8 ,int8 ,int8 ,int8 ,int8 ,int8 ,int8
				,int8 ,int8 ,int8 ,int8 ,int8 ,int8 ,int8 ,int8 ,int8 ,int8
				,int8 ,int8 ,int8 ,int8 ,int8 ,int8 ,int8 ,int8 ,int8 ,int8
				,int8 ,int8 ,int8 ,int8 ,int8 ,int8 ,int8 ,int8 ,int8 ,int8
				,int8 ,int8 ,int8 ,int8 ,int8 ,int8 ,int8 ,int8 ,int8 ,int8
				,int8 ,int8 ,int8 ,int8 ,int8 ,int8 ,int8 ,int8 ,int8 ,int8
				;;ff_effects_max
				,uint32)
			      `(,BUS
				,VENDOR
				,PRODUCT
				,VERSION
				,@NAME
				0)))

(define _ioctl (foreign-library-function #f "ioctl" #:return-type int #:arg-types `(,int ,int ,size_t)))
(define ioctl0
  (foreign-library-function #f "ioctl" #:return-type int #:arg-types `(,int ,int)))
(define (ioctl fd request arg) (_ioctl fd request arg))

(define (make-device name register-output)
  (let ([fd (open-fdes "/dev/uinput" flags)])
    (ioctl fd UI_SET_EVBIT EV_KEY)
    (for-each (cut ioctl fd UI_SET_KEYBIT <>)
	      register-output)
    (ioctl fd UI_DEV_SETUP (pointer-address usetup))
    (ioctl0 fd UI_DEV_CREATE)
    fd))

(define-public (distroy-device fd)
  (ioctl0 fd UI_DEV_DESTROY)
  (close-fdes fd))

(define (emit fd code val)
  1)
