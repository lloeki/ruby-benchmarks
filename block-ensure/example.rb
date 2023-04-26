#!/usr/bin/env ruby
# frozen_string_literal: true

require 'benchmark/ips'

class Example
  def initialize
    @mutex = Mutex.new
  end

  def using_block
    @mutex.synchronize do

    end
  end

  def using_ensure
    @mutex.lock
  ensure
    @mutex.unlock
  end
end

Benchmark.ips do |x|
  x.time = 5
  x.warmup = 0.5

  ex = Example.new
  n = 10_000_000

  x.report('block') { n.times { ex.using_block } }
  x.report('ensure') { n.times { ex.using_ensure } }

  x.compare!
end
