#lang racket/base

(require ffi/unsafe
         ffi/unsafe/define
         racket/stxparam
         (for-syntax racket/base
                     racket/syntax
                     racket/stxparam-exptime)
         
         )

(define-ffi-definer define-nng
  (ffi-lib "libnng"))


(define-cstruct _nng-ctx
  ([id _uint32]))

(define-cstruct _nng-dialer
  ([id _uint32]))

(define-cstruct _nng-listener
  ([id _uint32]))

(define-cstruct _nng-pipe
  ([id _uint32]))

(define-cstruct _nng-socket
  ([id _uint32]))



(define nng-lib (ffi-lib "libnng"))

(define-nng bus-open
  (_fun _nng-socket-pointer -> _int)
  #:c-id nng_bus0_open)

(define-nng pub-open
  (_fun _nng-socket-pointer -> _int)
  #:c-id nng_pub0_open)

(define-nng listen
  (_fun _nng-socket _string _nng-listener-pointer/null _int -> _int)
  #:c-id nng_listen)

(define-nng dial
  (_fun _nng-socket _string _nng-dialer-pointer/null _int -> _int)
  #:c-id nng_dial)

(define-nng send
  (_fun _nng-socket _pointer _size _int -> _int)
  #:c-id nng_send)

(define-nng sendmsg
  (_fun _nng-socket _pointer _int -> _int)
  #:c-id nng_sendmsg)

(define-nng recv
  (_fun _nng-socket _pointer _pointer _int -> _int)
  #:c-id nng_recv)

(define-nng recvmsg
  ()
  #:c-id nng_recvmsg)
(define-nng close
  (_fun _nng-socket-pointer -> _void))


(define (demo)
  (let* [(socket (make-nng-socket 0))
         (rv1 (pub-open socket))
         (rv2 (listen socket "tcp://127.0.0.1:8888" #f 0))]
    socket))