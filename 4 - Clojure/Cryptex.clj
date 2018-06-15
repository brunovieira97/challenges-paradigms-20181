(def input ["t" "e" "s" "t" "e"])

(def userEntry (atom []))

(println "Inform the 5 letter keys: ")

(dotimes [n 5] (swap! userEntry conj (read-line)))

(= (compare @userEntry input) 0)
