(ns monitoring.newrelic
  (:require [clojure.walk :refer [stringify-keys]])
  (:import (com.newrelic.api.agent NewRelic)))

;; Found problems with names that contained hyphens, so use CamelCase
(defonce ^:private event-name "PoCCustomEvent")

(defn record-event [data]
  (let [data (stringify-keys data)]
    (.. (NewRelic/getAgent)
        (getInsights)
        (recordCustomEvent event-name data))))
