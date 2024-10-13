(define-module (input-match)
  #:export (def-rule))

(define max-pattern-size 50)
;;key-seq
;;key-seq: max-size=50 timeout=5000ms
(define-inlinable (eop? u64) (zero? u64))
(define-inlinable (pattern) (make-typed-array 'u64 0 max-pattern-size))
;;                          arr     int     string
(define-inlinable (def-rule pattern timeout input-id) (cons input-id timeut pattern))
(define (match-kp pattern-list)
  )
