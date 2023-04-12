#!/usr/bin/env ruby

require 'benchmark'

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

Benchmark.bm(12) do |x|
  ex = Example.new
  n = 10_000_000

  x.report('block') { n.times { ex.using_block } }
  x.report('ensure') { n.times { ex.using_ensure } }
end
