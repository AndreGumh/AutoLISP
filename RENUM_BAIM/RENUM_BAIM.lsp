(defun c:renum_baim (/ NumARK NumLoop NumDevice NameDevice)
  (vl-load-com)
  (setq ListAdress1 (list "AM1" "SC1" "BTM" "BTK" "UPS"))
  (setq ListAdress2 (list "MVK2"))
  (setq ListAdress4 (list "AM4"))
  (setq ListAdress8 (list "SC8"))
  (setq NumARK
    (getint
      (strcat "Input number of KAY-2: ")
    )
  )
  (setq NumLoop
    (getint
      (strcat "Input number of loop: ")
    )
  )
  (setq NumDevice
    (getint
      (strcat "Input the starting address: ")
    )
  )
  (while T
    (setq NameDevice
      (cdr(assoc 8(entget (car(entsel "Choose a block")))))
    )
    (if (vl-position NameDevice ListAdress1)
      (setq curStr(strcat (itoa NumARK) "." NameDevice "." (itoa NumLoop) "." (itoa NumDevice)))
      (if (vl-position NameDevice ListAdress2)
        (setq curStr(strcat (itoa NumARK) "." NameDevice "." (itoa NumLoop) "." (itoa NumDevice) "..." (itoa (+ NumDevice 2))))
        (if (vl-position NameDevice ListAdress4)
          (setq curStr(strcat (itoa NumARK) "." NameDevice "." (itoa NumLoop) "." (itoa NumDevice) "..." (itoa (+ NumDevice 4))))
          (if (vl-position NameDevice ListAdress8)
            (setq curStr(strcat (itoa NumARK) "." NameDevice "." (itoa NumLoop) "." (itoa NumDevice) "..." (itoa (+ NumDevice 8))))
          )
        )
      )
    )    
    (setq curText 
      (car 
        (nentsel "\n<<< Pick TEXT, MTEXT or ATTRIBUTE or press Esc to quit >>> "))) 
    (if 
      (and 
        curText 
        (member(cdr(assoc 0(entget curText))) '("TEXT" "MTEXT" "ATTRIB")) 
      ) 
      (progn 
        (vla-put-TextString 
          (vlax-ename->vla-object curText)curStr)
        (if (vl-position NameDevice ListAdress1)
          (setq NumDevice (1+ NumDevice))
          (if (vl-position NameDevice ListAdress2)
            (setq NumDevice (+ NumDevice 3))
            (if (vl-position NameDevice ListAdress4)
              (setq NumDevice (+ NumDevice 5))
              (if (vl-position NameDevice ListAdress8)
                (setq NumDevice (+ NumDevice 9))
              )
            )
          )
        )
      )
    (princ "\n<!> This is not DText or MText <!>")
    )     
  )
  (princ) 
)