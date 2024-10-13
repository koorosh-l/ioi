(define-module (evdev)
  #:use-module (system foreign-library)
  #:use-module (system foreign)
  #:use-module (rnrs bytevectors))
;;#<procedure foreign-library-function (lib name #:key return-type arg-types return-errno?)>
(define-public libevdev
  (load-foreign-library "libevdev"
			#:search-path '("/home/koorosh/.guix-profile/lib/")))
(define func-desc
  `(("libevdev_set_name")
    ("libevdev_enable_event_type")
    ("libevdev_enable_event_code")))
(define ev-rel #x02)

(define-public evdev-new
  (foreign-library-function libevdev "libevdev_new" #:return-type '*  #:arg-types '()))

(define-public evdev-set-name
  (foreign-library-function libevdev "libevdev_set_name" #:return-type void #:arg-types '(* *)))
(define evdev-get-name
  (foreign-library-function libevdev "libevdev_get_name" #:return-type '* #:arg-types '(*)))
(define-public evdev-enable-event-code
  (foreign-library-function libevdev  "libevdev_enable_event_type" #:return-type void #:arg-types (list '* uint32)))
(define-public evdev-enable-event-type
  (foreign-library-function libevdev  "libevdev_enable_event_type" #:return-type int  #:arg-types (list '* uint32)))
;; imaganary
(auto-bind "libevdev" "libevdev-1.0/libevdev/libevdev-uinput.h" handler)

