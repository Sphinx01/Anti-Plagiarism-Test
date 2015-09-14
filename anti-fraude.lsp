
;;********************Function levenshtein distance************************

(defun levenshtein-distance (str1 str2)
  "Calculates the Levenshtein distance between str1 and str2, returns an editing distance (int)."
  
 (let ((n (length str1))
	(m (length str2)))
    ;; Check trivial cases
    (cond ((= 0 n) (return-from levenshtein-distance m))
	  ((= 0 m) (return-from levenshtein-distance n)))
    (let ((col (make-array (1+ m) :element-type 'integer))
	  (prev-col (make-array (1+ m) :element-type 'integer)))
      (dotimes (i (1+ m))
	(setf (svref prev-col i) i))
      (dotimes (i n)
	(setf (svref col 0) (1+ i))
	(dotimes (j m)
	  (setf (svref col (1+ j))
		(min (1+ (svref col j))
		     (1+ (svref prev-col (1+ j)))
		     (+ (svref prev-col j)
			(if (char-equal (schar str1 i) (schar str2 j)) 0 1)))))
	(rotatef col prev-col))
      (svref prev-col m))))
	  
;;********************Function Convert text to a list************************	  
 (defparameter *comma-rt* (copy-readtable nil))
 (set-syntax-from-char #\, #\Space  *comma-rt*)
 
 (defun read-comma-separated-file (file)
   (let ((*read-eval* nil)
         (*readtable* *comma-rt*))     
(with-open-file (stream file)
      (loop for line = (read-line stream nil)
            while line
            when
             (with-input-from-string (stream line)
              (loop for elem = (READ stream nil)
                     while elem
                     collect elem))
            collect it))))
(defun text-to-list (file-name)
  "Look over the text and collect words in a list, this helps deleting blank spaces and lines"
	(let ((*read-eval* nil)
	(*readtable* *comma-rt*))
	(with-open-file (stream file-name)
	  (loop while (peek-char nil stream nil nil)
           collect (read stream)))
		   ))
		
;;********************Function Convert list to string************************	
	
(defun list-to-string (lst)
 "Convert a list to string by concatenating its elements"
  (when lst
    (concatenate 'string 
                 (write-to-string (car lst)) (list-to-string (cdr lst)))))
				 
;;************************Function Plagiat seed************************
				 
(defun FraudeSeed (distance CHAINE1 CHAINE2) 
"Calculates the degree of similarity between the 2 texts : 0<=the result<=1"
		(let ((SeedDet 0))
			(setf SeedDet (- 1.0(/ distance (max (length CHAINE1)(length CHAINE2)))))
			(return-from FraudeSeed SeedDet)
		) )

;;********************Main function for testing plagiarism************************
		
(defun plagiat-testing (file1  file2) 
 "Test plagiarism between file1 and file2"
  (let ((distance 0)(seedResult 0.0)) 
  (print (list-to-string (read-comma-separated-file file1)))
  (print (list-to-string (read-comma-separated-file file2)))
  (setf distance (levenshtein-distance (list-to-string (read-comma-separated-file file1)) (list-to-string (read-comma-separated-file file2))))
  (print distance)
  (setf seedResult (FraudeSeed distance (list-to-string (read-comma-separated-file file1)) (list-to-string (read-comma-separated-file file2))))
  (if (= seedResult 1.0)  "Fraude" (if (= seedResult 0.0) "Pas de Fraude"  "Fraude probable"))
  ))
