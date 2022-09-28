(ns dummy-test
  (:require [clojure.test :refer [deftest is testing]]))

(deftest dummy-test
  (testing "Context of the test assertions"
    (is (= 1 1))))
