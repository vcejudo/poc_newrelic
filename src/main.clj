(ns main
  (:gen-class)
  (:import (com.newrelic.api.agent NewRelic)))

(defn- record-event [data-to-record]
  (.. (NewRelic/getAgent)
      (getInsights)
      (recordCustomEvent "MyCustomEvent" data-to-record)))

(defn -main []
  (println "Hello, World!")
  (record-event {"name" "some-event", "data" "Greetings!"})
  (Thread/sleep 20000))
