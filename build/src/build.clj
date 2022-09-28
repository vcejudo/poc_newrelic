(ns build
  (:refer-clojure :exclude [compile apply])
  (:require [org.corfield.build :as b]))

(defn uberjar
  "Compile Clojure and create the jar package"
  [opts]
  (-> opts
      (assoc :main 'main
             :version "0.1"
             :uber-file "target/nr-example.jar")
      (b/clean)
      (b/uber)))
