module Primes
  class Test
    def initialize(source)
      @source = source
    end

    def run
      coalesced_result = true
      while (numbers = @source.next_batch) do
        result = check_primality(numbers)
        coalesced_result &&= result
      end
      coalesced_result
    end

    private
    def check_primality(numbers)
      puts "--- Checking primes #{numbers.first} - #{numbers.last}"
      puts "#{numbers.join(' ')}"
      numbers.reduce(true) do |memo, num|
        success = Professor.is_prime?(num)
        report_failure(num) unless success
        memo && success
      end
    end

    def report_failure(number)
      puts "+++ \033[31m" + "Failure: #{number} is not prime" + "\033[0m\n"
    end
  end

  class Professor
    def self.is_prime?(num)
      num == 2 ? true : is_prime_by_trial_division?(num)
    end

    private
    def self.is_prime_by_trial_division?(num)
      !(2..num-1).detect { |n| num % n == 0 }
    end
  end

  class Source
    def next_batch
      file.close unless line = file.gets
      line ? line.strip.split(/\s+/).map { |str| str.to_i } : nil
    end

    private
    def file
      @file ||= File.open("primes.txt")
    end
  end
end

source = Primes::Source.new
test = Primes::Test.new(source)
abort() unless test.run
