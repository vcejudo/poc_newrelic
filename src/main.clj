(ns main
  (:gen-class)
  (:require [monitoring.newrelic :as nr]))

(defn- record-batch-of-events []
  (loop [x 1]
    (when (< x 500)
      (println "Running iteration >> " x)
      (nr/record-event {:name "some-event",
                        :data (str "Executed the " x "th time")})
      (Thread/sleep 500)
      (recur (inc x)))))

(defn -main []
  (println "Hello, World, let's get started!")
  (record-batch-of-events))
