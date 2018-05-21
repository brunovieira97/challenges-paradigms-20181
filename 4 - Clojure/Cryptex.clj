(require '[clojure.string :as str])

(def cryptexKey "apple")
(def count 5)

(def receiveKey 
  (let [input (read-line)]
    (def inputKey input)
  )
)
           
receiveKey

inputKey



;(def testKey (fn [inputKey] (str "Hello " cryptexKey)))