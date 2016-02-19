class TestCase
  attr :args

  def initialize(args = {})
    @args = args
  end

  def should_be(expectation)
    evaluation == expectation
  end

  def should_not_be(expectation)
    evaluation != expectation
  end

  def evaluation
    eval("begin $stdout = StringIO.new; #{args}; $stdout.string; ensure $stdout = STDOUT end")
  end
end

puts '1'
foo = TestCase.new('puts "BOB"')
puts foo.should_be("BOB\n")


puts '2'
bar = TestCase.new('puts "BOB"')
foo = TestCase.new(bar)
puts foo.args == bar

puts '3'
puts foo.args

puts '4'
puts foo.args.class
puts foo.args.class == TestCase

puts '5'
ev = TestCase.new('puts 2 + 2')
puts ev.evaluation
puts ev.should_be("4\n")

puts '6'
bob = TestCase.new('def add(x, y)
    x + y
  end

  puts add(2, 2)')
puts bob.evaluation
puts bob.should_be("4\n")
