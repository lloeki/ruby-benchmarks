#!/usr/bin/env ruby
# frozen_string_literal: true

require 'benchmark/ips'

value = 'value'

Benchmark.ips do |x|
  x.time = 5
  x.warmup = 0.5

  x.report('format') { format('key:%s', value) }
  x.report('#{}') { "key:#{value}" }

  x.compare!
end
