(ns main
  (:gen-class)
  (:import (com.newrelic.api.agent NewRelic)))

(defn- record-event [data-to-record]
  (loop [x 1]
    (when (< x 100)
      (let [data-to-send (assoc data-to-record "iteration" (str x))]
        (println "Sending>> " data-to-send)
        (.. (NewRelic/getAgent)
            (getInsights)
            (recordCustomEvent "MyCustomEvent" data-to-send))
        (Thread/sleep 2000)
        (recur (inc x))))))

(defn -main []
  (println "Hello, World!")
  (record-event {"name" "some-event", "data" "Greetings!"})
  (Thread/sleep 20000))
